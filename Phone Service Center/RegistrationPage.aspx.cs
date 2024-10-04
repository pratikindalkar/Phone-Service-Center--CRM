using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Web.Caching;

namespace Phone_Service_Center
{
    public partial class RegistrationPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadStateDropdown();
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                List<string> imagePaths = new List<string>();

                if (fileUploadImage.HasFiles)
                {
                    foreach (HttpPostedFile uploadedFile in fileUploadImage.PostedFiles)
                    {
                        string fileExtension = Path.GetExtension(uploadedFile.FileName).ToLower();
                        if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png" && fileExtension != ".gif")
                        {
                            lblResult.Text = "Invalid file type. Only .jpg, .jpeg, .png, and .gif are allowed.";
                            lblResult.Visible = true;
                            return;
                        }

                        if (uploadedFile.ContentLength > 2 * 1024 * 1024)
                        {
                            lblResult.Text = "File size exceeds the 2 MB limit.";
                            lblResult.Visible = true;
                            return;
                        }

                        string folderPath = Server.MapPath("~/Images/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string imagePath = "~/Images/" + fileName;
                        uploadedFile.SaveAs(Path.Combine(folderPath, fileName));

                        imagePaths.Add(imagePath);
                    }
                }

                string imagePathsString = string.Join(",", imagePaths);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("InsertUserMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserName", txtUName.Text.Trim());
                        cmd.Parameters.AddWithValue("@MobileNo", txtMob.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text.Trim());
                        cmd.Parameters.AddWithValue("@StateID", ddlState.SelectedValue);
                        cmd.Parameters.AddWithValue("@UserCategory", ddlUserCategory.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                        cmd.Parameters.AddWithValue("@PasswordExpiryDate", DateTime.Parse(txtExpiry.Text.Trim()));
                        cmd.Parameters.AddWithValue("@PasswordQuestion", ddlPasswordQuestion.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@PasswordAnswer", txtPasswordAnswer.Text.Trim());
                        cmd.Parameters.AddWithValue("@ImagePaths", string.IsNullOrEmpty(imagePathsString) ? (object)DBNull.Value : imagePathsString);
                        cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked ? 1 : 0);

                        SqlParameter returnValue = new SqlParameter
                        {
                            ParameterName = "@ReturnValue",
                            SqlDbType = SqlDbType.Int,
                            Direction = ParameterDirection.ReturnValue
                        };
                        cmd.Parameters.Add(returnValue);

                        cmd.ExecuteNonQuery();

                        int result = (int)returnValue.Value;
                        if (result == 1)
                        {
                            Response.Write("<script>alert('User registered successfully!')</script>");
                        }
                        else if (result == 2)
                        {
                            Response.Write("<script>alert('Duplicate Email found. Please use a different email address.')</script>");
                        }
                        else if (result == 3)
                        {
                            Response.Write("<script>alert('Duplicate Mobile number found. Please use a different mobile number.')</script>");
                        }
                        else if (result == 4)
                        {
                            Response.Write("<script>alert('Duplicate User name found. Please use a different User name.')</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Something went wrong, try again.')</script>");
                        }
                        ClearForm();
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.Message;
                lblResult.Visible = true;
            }
        }
        private void LoadStateDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT StateID, StateName FROM State", con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    ddlState.Items.Clear();
                    ddlState.Items.Add(new ListItem("--Select State--", "0"));

                    ddlState.DataSource = reader;
                    ddlState.DataTextField = "StateName";
                    ddlState.DataValueField = "StateID";
                    ddlState.DataBind();
                }
                else
                {
                    Debug.WriteLine("No states found in the database.");
                }

                con.Close();
            }
        }
        private void ClearForm()
        {
            txtUName.Text = string.Empty;
            txtMob.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtPincode.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtExpiry.Text = string.Empty;
            txtPasswordAnswer.Text = string.Empty;

            if (ddlState.Items.Count > 0)
            {
                ddlState.SelectedIndex = 0;
            }

            if (ddlUserCategory.Items.Count > 0)
            {
                ddlUserCategory.SelectedIndex = 0;
            }

            if (ddlPasswordQuestion.Items.Count > 0)
            {
                ddlPasswordQuestion.SelectedIndex = 0;
            }

            chkIsActive.Checked = false;
            lblResult.Text = string.Empty;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }
    }
}