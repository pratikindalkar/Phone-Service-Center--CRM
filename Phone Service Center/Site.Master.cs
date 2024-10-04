using System;
using System.Web;

namespace Phone_Service_Center
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userCategory = Session["UserCategory"] as string; 

                if (userCategory == null)
                {
                    Response.Redirect("~/LoginPage.aspx");
                }

                lblWelcome.Text = "Welcome, " + Session["Username"]; 
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("LoginPage.aspx", true);
        }
    }
}
