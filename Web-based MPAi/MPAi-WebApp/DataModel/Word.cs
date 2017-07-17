using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MPAi_WebApp.DataModel
{
    [Table("Word")]
    public partial class Word
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int WordId { get; set; }

        [Required]
        [StringLength(64)]
        [Index(IsUnique = true)]
        public string Name { get; set; }

        public virtual ICollection<Recording> Recordings { get; set; }
    }
}