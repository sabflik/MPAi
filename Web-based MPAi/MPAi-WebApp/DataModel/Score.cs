using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace UploadRecording.DataModel
{
    [Table("Score")]
    public partial class Score
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ScoreId { get; set; }

        [ForeignKey("UserId")]
        public virtual User user { get; set; }
        public int UserId { get; set; }

        [ForeignKey("WordId")]
        public virtual Word word { get; set; }
        public int WordId { get; set; }

        [Required]
        public float Percentage { get; set; }

        // Add other fields if the scoreboard calls for it
    }
}