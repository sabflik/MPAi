using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace MPAi_WebApp
{
    public partial class Save : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (string upload in Request.Files)
            {
                // get target word
                string targetWord = Request.Form["maoriWord"];

                // upload audio file
                string dictionary = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"uploads");
                Directory.CreateDirectory(dictionary);
                var file = Request.Files[upload];
                if (file == null) continue;
                string recordingPath = Path.Combine(dictionary, Request.Form["fileName"]);
                file.SaveAs(recordingPath);

                // analyse audio file
                HTKEngine engine = new HTKEngine();
                Dictionary<string, string> htkResult = engine.Recognize(recordingPath).ToDictionary(x => x.Key, x => x.Value);

                Console.WriteLine(recordingPath);

                string result = "";
                if (htkResult.Count == 0)
                {
                    result = "nothing";
                }
                else
                {
                    result = htkResult.Values.ToArray()[0];
                }

                // Output result as JSON
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(result);
                Response.End();
            }
        }
    }
}