using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MPAi_WebApp.DataModel
{
    public class Word
    {
        public int WordId { get; set; }

        public string WordName { get; set; }

        public string Name { get; set; }
        public List<Recording> Recordings { get; set; }
    }
}