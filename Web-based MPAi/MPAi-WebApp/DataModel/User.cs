using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MPAi_WebApp.DataModel
{
    /// <summary>
    /// Wrapper class to hold values from the User table. 
    /// Each field corresponds to a row in the User SQL table.
    /// These classes make it easier to move results from queries around the program.
    /// </summary>
    public class User
    {
        public int UserId { get; set; }

        public string Username { get; set; }
    }
}