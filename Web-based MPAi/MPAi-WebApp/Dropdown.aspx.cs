using MPAi_WebApp.DataModel;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MPAi_WebApp
{
    public partial class Dropdown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            // get data from Json
            string jsonPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Json\audio.json");
            string json = File.ReadAllText(jsonPath);
            */
            // Get data from database
            string json;
            using (MPAiContext context = MPAiContext.InitializeDBModel())
            {
                List<Word> wordList = DbAdapter.GenerateWordList(context);
                String[] wordNames = new String[wordList.Count];
                for (int i = 0; i<wordList.Count; i++)
                {
                    wordNames[i] = wordList[i].Name.Replace("_", " ");
                }

                if (wordList.Count == 0)
                {
                    json = "nothing";
                }
                else
                {
                    json = JsonConvert.SerializeObject(wordNames, Formatting.Indented);
                }
            }
            // Output result as JSON
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(json);
            Response.End();
        }
    }
}