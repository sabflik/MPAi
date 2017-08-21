using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MPAi_WebApp.DataModel
{
    /**
     * Wrapper class to hold values from the recording table.
     */
    public class Recording
    {
        public int RecordingId { get; set; }

        public Speaker Speaker { get; set; }
 
        public Word Word { get; set; }

        public int WordId { get; set; }

        public string FilePath { get; set; }
    }
}