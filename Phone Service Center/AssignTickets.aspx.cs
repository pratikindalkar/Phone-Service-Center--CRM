using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace Phone_Service_Center
{
    public partial class AssignTickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetTicketsWithDetails", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
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
            catch (Exception ex)
            {
                LogError(ex);

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('An error occurred while loading tickets. Please try again later.');", true);
            }
        }


        protected void GridViewTickets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                int ticketID = Convert.ToInt32(e.CommandArgument);
                ShowTicketDetails(ticketID);
                ViewState["SelectedTicketID"] = ticketID;
            }
        }

        private void ShowTicketDetails(int ticketID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetTicketsWithDetailsInPopUp", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@TicketID", ticketID);
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            lblDetailTicketID.Text = "Ticket ID: " + reader["TicketID"].ToString();
                            lblDetailTicketNo.Text = "Ticket No: " + reader["TicketNo"].ToString();
                            lblDetailCustomerName.Text = "Customer Name: " + reader["CustomerName"].ToString();
                            lblDetailContactNo.Text = "Contact No.: " + reader["CustomerContactNo"].ToString();
                            lblDetailEmail.Text = "Email: " + reader["CustomerEmail"].ToString();
                            lblDetailState.Text = "State: " + reader["StateName"].ToString();
                            lblDetailPincode.Text = "Pincode: " + reader["Pincode"].ToString();
                            lblDetailProduct.Text = "Product: " + reader["ProductName"].ToString();
                            lblDetailItemSerialNo.Text = "Item Serial No: " + reader["ItemSerialNo"].ToString();
                            lblDetailServiceCenter.Text = "Service Center: " + reader["ServiceCenterName"].ToString();
                            lblPurchaseDate.Text = "Purchase Date: " + Convert.ToDateTime(reader["PurchaseDate"]).ToString("yyyy-MM-dd");
                            lblDetailWarrentyDate.Text = "Warranty Date: " + Convert.ToDateTime(reader["WarrantyDate"]).ToString("yyyy-MM-dd");
                            lblDetailProductIssue.Text = "Product Issue: " + reader["ProductIssues"].ToString();
                            lblDetailIssue.Text = "Issue Description: " + reader["IssueDescription"].ToString();

                            int serviceCenterID = Convert.ToInt32(reader["ServiceCenterID"]);
                            LoadEngineers(serviceCenterID);
                            pnlTicketDetails.Style["display"] = "block";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error fetching ticket details: " + ex.Message + "');", true);
            }
        }

        private void LoadEngineers(int serviceCenterID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("LoadInEngineerDdl", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ServiceCenterID", serviceCenterID);

                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        ddlEngineer.Items.Clear();

                        if (reader.HasRows)
                        {
                            ddlEngineer.Items.Add(new ListItem("Select Engineer", "0"));

                            while (reader.Read())
                            {
                                ddlEngineer.Items.Add(new ListItem(reader["EngineerName"].ToString(), reader["EngineerID"].ToString()));
                            }
                        }
                        else
                        {
                            ddlEngineer.Items.Add(new ListItem("No Engineers Available", "0"));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error loading engineers: " + ex.Message + "');", true);
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["SelectedTicketID"] == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a ticket first.');", true);
                    return;
                }

                int ticketID = Convert.ToInt32(ViewState["SelectedTicketID"]);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("AssignEngineerToTicket", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@EngineerID", ddlEngineer.SelectedValue);
                        cmd.Parameters.AddWithValue("@TicketID", ticketID);
                        cmd.Parameters.AddWithValue("@AppointmentDate", appointmentDate.Text);
                        cmd.Parameters.AddWithValue("@Instructions", instructions.Text);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "closeModalWithMessage",
                            "setTimeout(function() { hideModal(); alert('Engineer assigned successfully.'); }, 1000);", true); ClearForm();
                BindGridView();
            }
            catch (Exception ex)
            {
                LogError(ex);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error assigning engineer: " + ex.Message + "');", true);
            }
        }



        private void ClearForm()
        {
            ddlEngineer.SelectedIndex = 0;
            appointmentDate.Text = string.Empty;
            instructions.Text = string.Empty;
        }

        private void LogError(Exception ex)
        {
            
        }
    }
}