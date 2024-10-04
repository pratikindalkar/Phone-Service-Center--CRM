using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Phone_Service_Center
{
    public partial class ServiceCenterMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStateDropdown();
                BindEngineers();
                LoadAssignProductDropdown();
                ShowAllServiceCenterMasterData();
                GridView1.Visible = true;
                btnUpdate.Visible = false;
                btnCancel.Visible = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("InsertServiceCenterMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ServiceCenterName", txtServiceCenterName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text.Trim());
                        cmd.Parameters.AddWithValue("@StateID", ddlState.SelectedValue);
                        cmd.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@AssignProductID", ddlAssignProduct.SelectedValue);

                        List<string> selectedEngineers = new List<string>();
                        foreach (ListItem item in chkAssignEngineer.Items)
                        {
                            if (item.Selected)
                            {
                                selectedEngineers.Add(item.Text);
                            }
                        }
                        string engineerNames = string.Join(", ", selectedEngineers);
                        cmd.Parameters.AddWithValue("@AssignEngineer", engineerNames);


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
                            Response.Write("<script>alert('Service center registered successfully!');</script>");
                            ClearForm();
                            ShowAllServiceCenterMasterData();
                        }
                        else
                        {
                            Response.Write("<script>alert('Something went wrong, try again.');</script>");
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



        private void ShowAllServiceCenterMasterData()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("ShowAllServiceCenterMasterData", con);
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
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT StateID, StateName FROM State", con);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                ddlState.Items.Clear();
                ddlState.Items.Add(new ListItem("--Select State--", "0"));

                ddlState.DataSource = reader;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "StateID";
                ddlState.DataBind();
            }
        }

        private void BindEngineers()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT UserID, UserName FROM UserMaster WHERE UserCategory = 'engineer'", con))
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        chkAssignEngineer.DataSource = reader;
                        chkAssignEngineer.DataValueField = "UserID"; 
                        chkAssignEngineer.DataTextField = "UserName"; 
                        chkAssignEngineer.DataBind(); 
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }





        private void ClearForm()
        {
            txtServiceCenterName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtPincode.Text = string.Empty;
            ddlState.SelectedIndex = 0;
            txtMobileNo.Text = string.Empty;
            ddlAssignProduct.SelectedIndex = 0;
            lblResult.Text = string.Empty;
        }

        private void LoadServiceCenterData(int serviceCenterID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetServiceCenterById", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ServiceCenterID", serviceCenterID);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtServiceCenterName.Text = reader["ServiceCenterName"].ToString();
                        txtAddress.Text = reader["Address"].ToString();
                        txtPincode.Text = reader["Pincode"].ToString();
                        ddlState.SelectedValue = reader["StateID"].ToString();
                        txtMobileNo.Text = reader["MobileNo"].ToString();
                        ddlAssignProduct.SelectedValue = reader["AssignProductID"].ToString();
                        chkAssignEngineer.SelectedValue = reader["AssignEngineer"].ToString();

                        ViewState["ServiceCenterID"] = serviceCenterID; 
                        btnSubmit.Visible = false;
                        btnUpdate.Visible = true;
                    }
                }
            }
        }

        private void LoadAssignProductDropdown()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT SlNo, ProductName FROM AssignProduct", con);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                ddlAssignProduct.Items.Clear();
                ddlAssignProduct.Items.Add(new ListItem("--Select Product--", "0"));

                ddlAssignProduct.DataSource = reader;
                ddlAssignProduct.DataTextField = "ProductName";
                ddlAssignProduct.DataValueField = "SlNo";
                ddlAssignProduct.DataBind();
            }
        }

        protected void onRowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int serviceCenterID = Convert.ToInt32(e.CommandArgument);
                LoadServiceCenterData(serviceCenterID);
            }
            else if (e.CommandName == "Delete")
            {
                int serviceCenterID = Convert.ToInt32(e.CommandArgument);
                DeleteUser(serviceCenterID);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["ServiceCenterID"] == null)
                {
                    Response.Write("<script>alert('Service Center ID is not set.')</script>");
                    return;
                }

                int serviceCenterID = (int)ViewState["ServiceCenterID"];

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("UpdateServiceCenterMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ServiceCenterID", serviceCenterID);
                        cmd.Parameters.AddWithValue("@ServiceCenterName", txtServiceCenterName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text.Trim());
                        cmd.Parameters.AddWithValue("@StateID", ddlState.SelectedValue);
                        cmd.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@AssignProductID", ddlAssignProduct.SelectedValue); // Correct parameter
                        cmd.Parameters.AddWithValue("@AssignEngineer", chkAssignEngineer.SelectedValue);
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
                            Response.Write("<script>alert('Service center updated successfully!')</script>");
                            ClearForm();
                            btnSubmit.Visible = true;
                            btnUpdate.Visible = false;
                            ShowAllServiceCenterMasterData();
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

        private void DeleteUser(int serviceCenterId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DeleteServiceCenterMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ServiceCenterID", serviceCenterId);

                        con.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Write("<script>alert('Service Center deleted successfully!')</script>");
                            ShowAllServiceCenterMasterData(); // Refresh the grid
                        }
                        else
                        {
                            Response.Write("<script>alert('Deletion failed. Service Center may not exist.')</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "')</script>");
            }
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

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
    }
}
