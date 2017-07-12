using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MPAi_WebApp.Startup))]
namespace MPAi_WebApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
