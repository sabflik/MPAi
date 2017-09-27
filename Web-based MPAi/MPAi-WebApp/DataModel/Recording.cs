using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MPAi_WebApp.DataModel
{
    /// <summary>
    /// Wrapper class to hold values from the recording table. 
    /// Each field corresponds to a row in the Recording SQL table.
    /// These classes make it easier to move results from queries around the program.
    /// </summary>
    public class Recording
    {
        public int RecordingId { get; set; }

        public Speaker Speaker { get; set; }
 
        public Word Word { get; set; }

        public int WordId { get; set; }

        public string FilePath { get; set; }
    }
}