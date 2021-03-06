﻿using Microsoft.Owin;
using MPAi_WebApp.DataModel;
using Owin;

[assembly: OwinStartupAttribute(typeof(MPAi_WebApp.Startup))]
namespace MPAi_WebApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            // Set up authentication.
            ConfigureAuth(app);
            // Initialise database. This could take some time, so is called on startup.
            MPAiSQLite initialDB = new MPAiSQLite();
        }
    }
}
