using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace UploadRecording.DataModel
{
    [Table("Recording")]
    public partial class Recording
    {
        [Required]
        public Speaker Speaker { get; set; }
 
        [ForeignKey("WordId")]
        public virtual Word Word { get; set; }
        public int WordId { get; set; }

        [Required]
        [StringLength(256)]
        public string FilePath { get; set; }
    }
}