using MPAi_WebApp.DataModel;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MPAi_WebApp
{
    /// <summary>
    /// Server side class to retrieve scores from the server.
    /// </summary> 
    public partial class Statistics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Retrieve the list of scores from the database.
            MPAiSQLite context = new MPAiSQLite();
            List<Score> scoreList = context.GenerateScoreList(HttpContext.Current.User.Identity.Name);

            // Calculate current score (That is, the average score in the donut)
            double totalScores = 0;
            foreach (Score s in scoreList)
            {
                totalScores += s.Percentage;
            }
            double currentScore = Math.Round(totalScores / scoreList.Count());  // Change this line to alter the calculation.

            // make a new Dataset - chosen for how well it serialises into JSON.
            DataSet newDataSet = new DataSet("newDataSet");
            newDataSet.Namespace = "MPAi_WebApp";

            // Current average score table
            DataTable donutDataTable = new DataTable("donutScore");
            DataColumn currentScoreColumn = new DataColumn("donutScore");
            donutDataTable.Columns.Add(currentScoreColumn);
            newDataSet.Tables.Add(donutDataTable);

            // Add the average score to the table.
            DataRow donutRow = donutDataTable.NewRow();
            donutRow["donutScore"] = currentScore;
            donutDataTable.Rows.Add(donutRow);

            // Scores over time table
            DataTable scoresDataTable = new DataTable("scores");
            DataColumn timeColumn = new DataColumn("time", typeof(string));
            scoresDataTable.Columns.Add(timeColumn);
            DataColumn scoreColumn = new DataColumn("score", typeof(string));
            scoresDataTable.Columns.Add(scoreColumn);
            newDataSet.Tables.Add(scoresDataTable);

            // Add the scores over time to the table.
            foreach (Score s in scoreList)
            {
                DataRow newRow = scoresDataTable.NewRow();
                newRow["time"] = s.Date.ToString();
                newRow["score"] = s.Percentage;
                scoresDataTable.Rows.Add(newRow);
            }

            // Serialise the data into JSON.
            string newJson;
            if (scoresDataTable.Rows.Count == 0)
            {
                newJson = "nothing";
            }
            else
            {
                newJson = JsonConvert.SerializeObject(newDataSet, Formatting.Indented);
            }

            // Output result as JSON.
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(newJson);
            Response.End();
            }
        }
    }