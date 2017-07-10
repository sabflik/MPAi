using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UploadRecording
{
    public partial class Dropdown : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // get data from Json
            string jsonPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Json\audio.json");
            string json = File.ReadAllText(jsonPath);
            DataSet dataSet = JsonConvert.DeserializeObject<DataSet>(json);

            string newJson = JsonConvert.SerializeObject(dataSet, Formatting.Indented);

            // Output result as JSON
            Response.Clear();
            Response.ContentType = "application/json; charset=utf-8";
            Response.Write(newJson);
            Response.End();
        }
    }
}