using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MPAi_WebApp.DataModel
{
    /// <summary>
    /// Wrapper class to hold values from the Word table. 
    /// Each field corresponds to a row in the Word SQL table.
    /// These classes make it easier to move results from queries around the program.
    /// </summary>
    public class Word
    {
        public int WordId { get; set; }

        public string WordName { get; set; }

        public string Name { get; set; }
        
        public List<Recording> Recordings { get; set; }
    }
}