using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Phone_Service_Center
{
    public partial class UserMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserCategory"] != null && Session["UserCategory"].ToString() != "Admin")
                {
                    Response.Redirect("AccessDenied.aspx");
                }
                LoadStateDropdown();
                ShowAllData();
                GridView1.Visible = true;
                btnUpdate.Visible = false;
                btnCancel.Visible = false;
            }

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
                            ClearForm();
                            ShowAllData();
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
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.Message;
                lblResult.Visible = true;
            }
        }
        private void ShowAllData()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("ShowAllData", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataColumn column in dt.Columns)
                {
                    Debug.WriteLine(column.ColumnName);
                }
                GridView1.DataSource = dt;
                GridView1.DataBind();
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
        protected string BindImages(object dataItem)
        {
            DataRowView rowView = (DataRowView)dataItem;
            string imagePathsString = rowView["ImagePaths"]?.ToString(); // Use ImagePaths instead of ProfilePicture
            string[] imagePaths = string.IsNullOrEmpty(imagePathsString) ? new string[0] : imagePathsString.Split(',');

            StringBuilder html = new StringBuilder();

            foreach (string path in imagePaths)
            {
                if (!string.IsNullOrWhiteSpace(path))
                {
                    string resolvedUrl = ResolveUrl(path.Trim());
                    html.Append($"<img src='{resolvedUrl}' width='100px' height='100px' style='margin-right:5px;' alt='Profile Image' />");
                }
            }
            return html.ToString();
        }

        protected void onRowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                LoadUserData(userId);
            }
            else if (e.CommandName == "Delete")
            {
                int UserID = Convert.ToInt32(e.CommandArgument);
                DeleteUser(UserID);
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int userId = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            LoadUserData(userId);
        }

        protected void OnRowDeleting1(object sender, GridViewDeleteEventArgs e)
        {

        }
        private void LoadUserData(int userId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetUserData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        DataRow row = dt.Rows[0];

                        txtUName.Text = row["UserName"].ToString();
                        txtMob.Text = row["Mobile"].ToString();
                        txtEmail.Text = row["Email"].ToString();
                        txtAddress.Text = row["Address"].ToString();
                        txtPincode.Text = row["Pincode"].ToString();
                        ddlState.SelectedValue = row["StateID"].ToString();
                        ddlUserCategory.SelectedValue = row["UserCategory"].ToString();
                        txtExpiry.Text = Convert.ToDateTime(row["PasswordExpiryDate"]).ToString("yyyy-MM-dd");
                        ddlPasswordQuestion.SelectedValue = row["PasswordQuestion"].ToString();
                        txtPasswordAnswer.Text = row["PasswordAnswer"].ToString();
                        chkIsActive.Checked = Convert.ToBoolean(row["IsActive"]);

                        string imagePathsString = row["ImagePaths"]?.ToString();
                        if (!string.IsNullOrEmpty(imagePathsString))
                        {
                            string[] imagePaths = imagePathsString.Split(',');
                            foreach (string path in imagePaths)
                            {
                                if (!string.IsNullOrWhiteSpace(path))
                                {
                                    string resolvedUrl = ResolveUrl(path.Trim());
                                    imgProfilePicture.ImageUrl = resolvedUrl; 
                                    break; 
                                }
                            }
                        }
                        else
                        {
                            imgProfilePicture.ImageUrl = ""; 
                        }

                        ViewState["UserID"] = userId; 
                        btnUpdate.Visible = true; 
                        btnCancel.Visible = true;  
                        btnSubmit.Visible = false;
                        btnClear.Visible = false;
                    }
                    else
                    {
                        lblResult.Text = "User not found.";
                        lblResult.Visible = true;
                    }
                }
            }
        }
        private void DeleteUser(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DeleteUserMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        con.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Write("<script>alert('User deleted successfully!')</script>");
                            ShowAllData(); 
                        }
                        else
                        {
                            Response.Write("<script>alert('Deletion failed. Please try again.')</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "')</script>");
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                List<string> newImagePaths = new List<string>();
                string existingImagePaths = GetExistingImagePaths(Convert.ToInt32(ViewState["UserID"]));

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

                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string imagePath = "~/Images/" + fileName;
                        uploadedFile.SaveAs(Server.MapPath(imagePath));
                        newImagePaths.Add(imagePath);
                    }
                }

                string newImagePathsString = string.Join(",", newImagePaths);
                string finalImagePaths = string.IsNullOrEmpty(newImagePathsString) ? existingImagePaths : newImagePathsString;

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("UpdateUserMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserID", ViewState["UserID"]);
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
                        cmd.Parameters.AddWithValue("@ImagePaths", string.IsNullOrEmpty(finalImagePaths) ? (object)DBNull.Value : finalImagePaths);
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
                            Response.Write("<script>alert('User updated successfully!')</script>");
                            ClearForm();
                            btnSubmit.Visible = true;
                            btnCancel.Visible = true;
                            btnUpdate.Visible = false;
                            btnClear.Visible = false;
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
                        ShowAllData();
                        btnSubmit.Visible = false;
                        btnClear.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.Message;
                lblResult.Visible = true;
            }
        }

        private string GetExistingImagePaths(int userID)
        {
            string existingImagePaths = string.Empty;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetExistingImagePaths", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    con.Open();
                    existingImagePaths = cmd.ExecuteScalar()?.ToString() ?? string.Empty;
                }
            }
            return existingImagePaths;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
            btnSubmit.Visible = true;
            btnClear.Visible = true;

            btnUpdate.Visible = false;
            btnCancel.Visible = false;
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
            btnSubmit.Visible = true;
            btnClear.Visible = true;

            btnUpdate.Visible = false;
            btnCancel.Visible = false;
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
    }
}
