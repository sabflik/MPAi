﻿using Microsoft.Owin;
using MPAi_WebApp.DataModel;
using Owin;

[assembly: OwinStartupAttribute(typeof(MPAi_WebApp.Startup))]
namespace MPAi_WebApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
            //using(MPAiContext context = MPAiContext.InitializeDBModel())
            //{
            //    // Force the database to be seeded on startup
            //    context.Database.Initialize(true);
            //}
            MPAiSQLite test = new MPAiSQLite();
        }
    }
}
