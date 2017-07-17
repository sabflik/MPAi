using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace MPAi_WebApp.DataModel
{
    public class DbAdapter
    {
        private MPAiContext context;

        public DbAdapter(MPAiContext context)
        {
            this.context = context;
        }
    }
}