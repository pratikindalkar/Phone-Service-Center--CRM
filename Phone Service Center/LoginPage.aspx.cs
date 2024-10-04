using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace Phone_Service_Center
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegistrationPage.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string UMob = txtUMob.Text.Trim();
                string Pass = txtLPass.Text.Trim();

                if (string.IsNullOrEmpty(UMob) || string.IsNullOrEmpty(Pass))
                {
                    lblError.Text = "Please enter both username and password.";
                    return;
                }


                string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT UserID, UserName, UserCategory 
                        FROM UserMaster 
                        WHERE (Email = @UMob OR UserName = @UMob OR MobileNo = @UMob) 
                        AND Password = @Pass";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UMob", UMob);
                        cmd.Parameters.AddWithValue("@Pass", Pass); 

                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            Session["UserID"] = reader["UserID"];
                            Session["UserName"] = reader["UserName"];
                            Session["UserCategory"] = reader["UserCategory"];  

                            FormsAuthentication.SetAuthCookie(UMob, false);

                            string userCategory = reader["UserCategory"].ToString();
                            if (userCategory == "Admin")
                            {
                                Response.Redirect("~/Default.aspx");
                            }
                            else if (userCategory == "Engineer")
                            {
                                Response.Redirect("~/Default.aspx");
                            }
                            else
                            {
                                lblError.Text = "User category not recognized.";
                            }
                        }
                        else
                        {
                            lblError.Text = "Invalid username or password.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred during login. Please try again later.";
            }
        }
    }
}
