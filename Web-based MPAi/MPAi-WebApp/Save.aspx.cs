﻿using MPAi_WebApp.DataModel;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace MPAi_WebApp
{
    /// <summary>
    /// Uploads, analyses, and records the results, from the server, of a recording.
    /// </summary>
    public partial class Save : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (string upload in Request.Files)
            {
                // Get target word
                string targetWord = Request.Form["target"];

                // Upload audio file
                string dictionary = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"uploads");
                Directory.CreateDirectory(dictionary);
                var file = Request.Files[upload];
                if (file == null) continue;
                string recordingPath = Path.Combine(dictionary, Request.Form["fileName"]);
                file.SaveAs(recordingPath);

                // Analyse audio file
                HTKEngine engine = new HTKEngine();
                Dictionary<string, string> htkResult = engine.Recognize(recordingPath).ToDictionary(x => x.Key, x => x.Value);

                Console.WriteLine(recordingPath);

                // Convert results to JSON
                string result = "";
                if (htkResult.Count == 0)
                {
                    result = "nothing";
                }
                else
                {
                    result = htkResult.Values.ToArray()[0];
                }
                // Add scores to database.
                MPAiSQLite context = new MPAiSQLite();
                context.SaveScore(System.Web.HttpContext.Current.User.Identity.Name, targetWord.ToLower(), (int)(Math.Round(SimilarityAlgorithm.DamereauLevensheinDistanceAlgorithm(Request.Form["target"], result) * 100, 0)));

                // Output result as JSON.
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(GetResponse(Request.Form["target"], result));
                Response.End();
            }
        }

        /// <summary>        
        /// Converts two words into a JSON object, containing the word and the score.
        /// </summary>
        /// <param name="target">The word that the user was attempting to say.</param>
        /// <param name="result">The word returned by the HTK engine.</param>
        /// <result>The JSON object containing the word and score.</result>
        private string GetResponse(string target, string result)
        {
            double score = Math.Round(SimilarityAlgorithm.DamereauLevensheinDistanceAlgorithm(target, result), 2) * 100;

            var obj = new JObject();

            obj["result"] = result;
            obj["score"] = score;

            return JsonConvert.SerializeObject(obj, Formatting.Indented);
        }
    }

    /// <summary>
    /// Wrapper class for the similarity algorithm employed for the correctness value.
    /// </summary>
    public static class SimilarityAlgorithm
    {
        /// <summary>
        /// Implementation of the Damereau-Levenshein Distance Algorithm with adjacent transpositions.
        /// This calculates the difference between two strings based on the minimal number of operations to get from one to the other.
        /// </summary>
        /// <param name="str1">The first string to compare.</param>
        /// <param name="str2">The second string to compare.</param>
        /// <returns>A float representing the percentage difference between the two parameters.</returns>
        public static float DamereauLevensheinDistanceAlgorithm(string str1, string str2)
        {
            if (string.IsNullOrEmpty(str1))
            {
                if (string.IsNullOrEmpty(str2))
                    return 0;
                return str2.Length;
            }

            if (string.IsNullOrEmpty(str2))
            {
                return str1.Length;
            }

            int n = str1.Length;
            int m = str2.Length;
            int[,] d = new int[n + 1, m + 1];

            // initialize the top and right of the table to 0, 1, 2, ...
            for (int i = 0; i <= n; d[i, 0] = i++) ;
            for (int j = 1; j <= m; d[0, j] = j++) ;

            for (int i = 1; i <= n; i++)
            {
                for (int j = 1; j <= m; j++)
                {
                    int cost = (str2[j - 1] == str1[i - 1]) ? 0 : 1;
                    int min1 = d[i - 1, j] + 1;
                    int min2 = d[i, j - 1] + 1;
                    int min3 = d[i - 1, j - 1] + cost;
                    d[i, j] = Math.Min(Math.Min(min1, min2), min3);
                }
            }

            return Math.Abs(1 - (float)d[n, m] / Math.Max(m, n));
        }
    }
}