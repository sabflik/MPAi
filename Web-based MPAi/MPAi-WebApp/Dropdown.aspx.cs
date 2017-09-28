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
            // Output JSON file
            string json;
            
            // Connect to database class and call query method.
            MPAiSQLite context = new MPAiSQLite();
            List<Word> wordList = context.GenerateWordList();
            // Create an array of strings representing the words retreived from the database.
            String[] wordNames = new String[wordList.Count];
            for (int i = 0; i < wordList.Count; i++)
            {
                wordNames[i] = wordList[i].WordName.Replace("_", " ");
            }

            // Create a JSON file containing the words in the correct format.
            if (wordList.Count == 0)
            {
                json = "nothing";
            }
            else
            {
                json = JsonConvert.SerializeObject(wordNames, Formatting.Indented);
            }
            
            // Output result as JSON
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(json);
            Response.End();
        }
    }
}