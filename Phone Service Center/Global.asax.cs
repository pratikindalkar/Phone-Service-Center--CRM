using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Phone_Service_Center
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            RouteTable.Routes.MapPageRoute(
        "UserMasterRoute",
        "UserMaster",
        "~/UserMaster.aspx"
    );

            RouteTable.Routes.MapPageRoute(
                "ServiceCenterMasterRoute",
                "ServiceCenterMaster",
                "~/ServiceCenterMaster.aspx"
            );

            RouteTable.Routes.MapPageRoute(
                "ServiceCenterMappingMasterRoute",
                "ServiceCenterMappingMaster",
                "~/ServiceCenterMappingMaster.aspx"
            );
        }
    }
}