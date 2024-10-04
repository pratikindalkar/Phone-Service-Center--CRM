using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Phone_Service_Center
{
    public partial class GenerateTickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStateDropdown();
                LoadAssignProductDropdown();
                GridViewTickets.Visible = true;
                BindGridView();

                btnUpdate.Visible = false; 
            }
        }
        private void BindGridView()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetTicketsWithDetails", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            DataTable dt = new DataTable();
                            dt.Load(reader);
                            DataView dv = dt.DefaultView;
                            dv.Sort = "TicketID DESC";

                            GridViewTickets.DataSource = dv;
                            GridViewTickets.DataBind();
                        }
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("InsertGenerateTicket", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerContactNo", txtCustomerContactNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerEmail", txtCustomerEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@StateID", Convert.ToInt32(ddlState.SelectedValue));
                        cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text.Trim());
                        cmd.Parameters.AddWithValue("@Product", ddlAssignProduct.SelectedValue);
                        cmd.Parameters.AddWithValue("@ItemSerialNo", txtItemSerialNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@ServiceCenter", ddlServiceCenter.SelectedValue);

                        if (DateTime.TryParse(txtPurchaseDate.Text.Trim(), out DateTime purchaseDate) &&
                            DateTime.TryParse(txtWarrantyDate.Text.Trim(), out DateTime warrantyDate))
                        {
                            cmd.Parameters.AddWithValue("@PurchaseDate", purchaseDate);
                            cmd.Parameters.AddWithValue("@WarrantyDate", warrantyDate);
                        }
                        else
                        {
                            throw new Exception("Invalid date format.");
                        }

                        string productIssues = string.Join(", ", chkProductIssues.Items.Cast<ListItem>()
                                                    .Where(i => i.Selected)
                                                    .Select(i => i.Text));
                        cmd.Parameters.AddWithValue("@ProductIssues", productIssues);

                        cmd.Parameters.AddWithValue("@IssueDescription", txtIssueDescription.Text.Trim());

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
                            Response.Write("<script>alert('Ticket generated successfully!');</script>");
                            ClearForm(); 
                            BindGridView(); 
                        }
                        else if (result == 2)
                        {
                            Response.Write("<script>alert('Duplicate Mobile number found. Please use a different mobile number.')</script>");
                        }
                        else if (result == 3)
                        {
                            Response.Write("<script>alert('Duplicate Email found. Please use a different email address.')</script>");
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
                Debug.WriteLine("Error: " + ex.Message);
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("UpdateGenerateTicket", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@TicketID", ViewState["TicketID"]);
                        cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerContactNo", txtCustomerContactNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@CustomerEmail", txtCustomerEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@StateID", Convert.ToInt32(ddlState.SelectedValue));
                        cmd.Parameters.AddWithValue("@Pincode", txtPincode.Text.Trim());
                        cmd.Parameters.AddWithValue("@Product", ddlAssignProduct.SelectedValue);
                        cmd.Parameters.AddWithValue("@ItemSerialNo", txtItemSerialNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@ServiceCenter", ddlServiceCenter.SelectedValue);
                        DateTime updatedAt = DateTime.Now;
                        cmd.Parameters.AddWithValue("@UpdatedAt", updatedAt);

                        DateTime purchaseDate;
                        DateTime warrantyDate;
                        string issueDescription = txtIssueDescription.Text.Trim();
                        string productIssues = string.Join(", ", chkProductIssues.Items.Cast<ListItem>()
                                                                        .Where(i => i.Selected)
                                                                        .Select(i => i.Text));

                        if (DateTime.TryParse(txtPurchaseDate.Text.Trim(), out purchaseDate) &&
                            DateTime.TryParse(txtWarrantyDate.Text.Trim(), out warrantyDate))
                        {
                            cmd.Parameters.AddWithValue("@PurchaseDate", purchaseDate);
                            cmd.Parameters.AddWithValue("@WarrantyDate", warrantyDate);
                        }
                        else
                        {
                            throw new Exception("Invalid date format.");
                        }

                        cmd.Parameters.AddWithValue("@IssueDescription", issueDescription);
                        cmd.Parameters.AddWithValue("@ProductIssues", productIssues);

                        SqlParameter returnValue = new SqlParameter
                        {
                            ParameterName = "@ReturnValue",
                            SqlDbType = SqlDbType.Int,
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(returnValue);

                        cmd.ExecuteNonQuery();

                        int result = (int)returnValue.Value;

                        if (result == 1)
                        {
                            Response.Write("<script>alert('Ticket updated successfully!')</script>");
                            ClearForm();
                            BindGridView();
                            btnSubmit.Visible = true;
                            btnCancel.Visible = false;
                            btnUpdate.Visible = false;
                        }
                        else if (result == 0)
                        {
                            Response.Write("<script>alert('No Ticket found with the given Ticket ID.')</script>");
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

        private void LoadStateDropdown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT StateID, StateName FROM State", con);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                ddlState.Items.Clear();
                ddlState.Items.Add(new ListItem("--Select State--", "0"));

                while (reader.Read())
                {
                    ddlState.Items.Add(new ListItem(reader["StateName"].ToString(), reader["StateID"].ToString()));
                }

                con.Close();
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
        private void LoadServiceCenters()
        {
            string pincode = txtPincode.Text.Trim();
            string productId = ddlAssignProduct.SelectedValue;

            if (!string.IsNullOrEmpty(pincode) && productId != "0")
            {
                DataTable serviceCenters = GetServiceCentersByPincodeAndProduct(pincode, productId);

                ddlServiceCenter.Items.Clear();
                ddlServiceCenter.Items.Add(new ListItem("Select Service Center", "0"));

                if (serviceCenters.Rows.Count > 0)
                {
                    ddlServiceCenter.DataSource = serviceCenters;
                    ddlServiceCenter.DataTextField = "ServiceCenterName";
                    ddlServiceCenter.DataValueField = "ServiceCenterID";
                    ddlServiceCenter.DataBind();
                }
                else
                {
                    ddlServiceCenter.Items.Add(new ListItem("Service Center not found", "0"));
                }
            }
        }

        private void ClearForm()
        {
            txtCustomerName.Text = string.Empty;
            txtCustomerContactNo.Text = string.Empty;
            txtCustomerEmail.Text = string.Empty;
            txtPincode.Text = string.Empty;
            ddlAssignProduct.SelectedIndex = 0;
            txtItemSerialNo.Text = string.Empty;
            txtPurchaseDate.Text = string.Empty;
            txtWarrantyDate.Text = string.Empty;
            txtIssueDescription.Text = string.Empty;

            if (ddlState.Items.Count > 0)
            {
                ddlState.SelectedIndex = 0;
            }
            foreach (ListItem item in chkProductIssues.Items)
            {
                item.Selected = false; 
            }

            ddlServiceCenter.Items.Clear();
            ddlServiceCenter.Items.Add(new ListItem("Select Service Center", "0"));
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void txtPincode_TextChanged(object sender, EventArgs e)
        {
            LoadServiceCenters();
        }
        protected void txtPurchaseDate_TextChanged(object sender, EventArgs e)
        {
            if (ddlAssignProduct.SelectedValue != "0")
            {
                UpdateWarrantyDate();
            }
            else
            {
                txtWarrantyDate.Text = string.Empty; 
            }
        }


        private DataTable GetServiceCentersByPincodeAndProduct(string pincode, string productId)
        {
            DataTable dt = new DataTable();

            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetServiceCentersByPincodeAndProduct", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Pincode", pincode);
                    cmd.Parameters.AddWithValue("@ProductID", productId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        protected void ddlAssignProduct_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadServiceCenters(); 
            UpdateWarrantyDate(); 
        }
        private void UpdateWarrantyDate()
        {
            int productId = Convert.ToInt32(ddlAssignProduct.SelectedValue);
            int warrantyMonths = GetWarrantyMonthsByProductId(productId);

            if (warrantyMonths > 0)
            {
                DateTime purchaseDate;
                if (DateTime.TryParse(txtPurchaseDate.Text.Trim(), out purchaseDate))
                {
                    DateTime warrantyDate = purchaseDate.AddMonths(warrantyMonths);
                    
                    DateTime validWarrenty = DateTime.Parse(warrantyDate.ToShortDateString());
                    txtWarrantyDate.Text = validWarrenty.ToString("yyyy-MM-dd");
                }
                else
                {
                    txtWarrantyDate.Text = string.Empty; 
                }
            }
            else
            {
                txtWarrantyDate.Text = string.Empty;
            }
        }

        private int GetWarrantyMonthsByProductId(int productId)
        {
            int warrantyMonths = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetProductWarranty", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SlNo", productId);
                    con.Open();
                    var result = cmd.ExecuteScalar();
                    Debug.WriteLine($"Warranty Months Result for Product ID {productId}: {result}");
                    if (result != null && int.TryParse(result.ToString(), out warrantyMonths))
                    {
                        Debug.WriteLine($"Parsed Warranty Months: {warrantyMonths}");
                    }
                    else
                    {
                        Debug.WriteLine($"No warranty months found for Product ID {productId}");
                    }
                }
            }
            return warrantyMonths;
        }
        protected void onRowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int ticketID = Convert.ToInt32(e.CommandArgument);
                LoadUserData(ticketID); 
            }
            else if (e.CommandName == "Delete")
            {
                int ticketId = Convert.ToInt32(e.CommandArgument);
                DeleteGenerateTicket(ticketId);
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int ticketId = Convert.ToInt32(GridViewTickets.DataKeys[e.NewEditIndex].Value);
            LoadUserData(ticketId);
        }
        protected void OnRowDeleting1(object sender, GridViewDeleteEventArgs e)
        {

        }
        private void LoadUserData(int ticketId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetGenerateTicketData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TicketID", ticketId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    Debug.WriteLine($"Loaded Data for Ticket ID: {ticketId}, Rows Count: {dt.Rows.Count}");

                    if (dt.Rows.Count > 0)
                    {
                        DataRow row = dt.Rows[0];

                        txtCustomerName.Text = row["CustomerName"].ToString();
                        txtCustomerContactNo.Text = row["CustomerContactNo"].ToString();
                        txtCustomerEmail.Text = row["CustomerEmail"].ToString();
                        ddlState.SelectedValue = row["StateID"].ToString();
                        txtPincode.Text = row["Pincode"].ToString();
                        ddlAssignProduct.SelectedValue = row["Product"].ToString();
                        txtItemSerialNo.Text = row["ItemSerialNo"].ToString();

                        LoadServiceCenters(); 

                        string selectedServiceCenter = row["ServiceCenter"].ToString();
                        if (ddlServiceCenter.Items.FindByValue(selectedServiceCenter) != null)
                        {
                            ddlServiceCenter.SelectedValue = selectedServiceCenter; 
                        }
                        else
                        {
                            ddlServiceCenter.SelectedIndex = 0; 
                            Debug.WriteLine($"Service Center ID '{selectedServiceCenter}' not found in ddlServiceCenter.");
                        }

                        txtPurchaseDate.Text = Convert.ToDateTime(row["PurchaseDate"]).ToString("yyyy-MM-dd");
                        txtWarrantyDate.Text = Convert.ToDateTime(row["WarrantyDate"]).ToString("yyyy-MM-dd");
                        txtIssueDescription.Text = row["IssueDescription"].ToString();

                        string productIssuesRaw = row["ProductIssues"].ToString();  
                        string[] productIssues = productIssuesRaw.Split(',')
                            .Select(issue => issue.Trim())  
                            .ToArray();

                        foreach (ListItem item in chkProductIssues.Items)
                        {
                            if (productIssues.Contains(item.Text))  
                            {
                                item.Selected = true;
                            }
                        }

                        btnUpdate.Visible = true;
                        btnCancel.Visible = true;
                        btnSubmit.Visible = false;

                        ViewState["TicketID"] = ticketId;
                    }
                    else
                    {
                        lblResult.Text = "Ticket not found.";
                        lblResult.Visible = true;
                    }
                }
            }
        }


        private void DeleteGenerateTicket(int ticketID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DeleteGenerateTicket", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@TicketID", ticketID);

                        con.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Write("<script>alert('Ticket deleted successfully!')</script>");
                            ClearForm();
                            BindGridView(); 
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

        protected void btnCancel_Click1(object sender, EventArgs e)
        {
            ClearForm();
        }
    }
}
