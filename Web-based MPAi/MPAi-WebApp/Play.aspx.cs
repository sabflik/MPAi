using Newtonsoft.Json;
using System;
using System.Data;
using System.Diagnostics;
using System.IO;

namespace MPAi_WebApp
{
    public partial class Play : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // get target word name and category
            string name = Request.Form["wordName"];
            string category = Request.Form["wordCategory"];

            Debug.WriteLine("Count: " + Request.Form.Count);
            Debug.WriteLine("Name: " + name);
            Debug.WriteLine("Category: " + category);

            // get data from Json
            string jsonPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Json\audio.json");
            string json = File.ReadAllText(jsonPath);
            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(json);
            DataTable dataTable = dataSet.Tables[category];

            // make a new Dataset
            DataSet newDataSet = new DataSet("newDataSet");
            newDataSet.Namespace = "MPAi_WebApp";
            DataTable newDataTable = new DataTable("resultJsonTable");
            DataColumn nameColumn = new DataColumn("name", typeof(string));
            newDataTable.Columns.Add(nameColumn);
            DataColumn categoryColumn = new DataColumn("category", typeof(string));
            newDataTable.Columns.Add(categoryColumn);
            DataColumn pathColumn = new DataColumn("path", typeof(string));
            newDataTable.Columns.Add(pathColumn);
            newDataSet.Tables.Add(newDataTable);

            // set filtered data to a new Json
            foreach (DataRow row in dataTable.Rows)
            {
                if (row["name"].Equals(name) && row["category"].Equals(category))
                {
                    DataRow newRow = newDataTable.NewRow();
                    newRow["name"] = row["name"];
                    newRow["category"] = row["category"];
                    newRow["path"] = row["path"];
                    newDataTable.Rows.Add(newRow);
                }
            }
            string newJson;
            if (newDataTable.Rows.Count == 0)
            {
                newJson = "nothing";
            }
            else
            {
                newJson = JsonConvert.SerializeObject(newDataSet, Formatting.Indented);
            }

            // Output result as JSON
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(newJson);
            Response.End();
        }
    }
}