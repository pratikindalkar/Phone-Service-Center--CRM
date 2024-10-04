using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.EnterpriseServices;

namespace Phone_Service_Center
{
    public partial class EngineerTickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEngineerTickets();
            }
        }

        private void BindEngineerTickets()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetEngineerTickets", con))
                {
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    GridViewEngineerTickets.DataSource = dt;
                    GridViewEngineerTickets.DataBind();
                }
            }
        }

        protected void GridViewEngineerTickets_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                int assignmentID = Convert.ToInt32(e.CommandArgument);
                ShowTicketDetails(assignmentID);
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#viewTicketModal').modal('show');", true);
            }
        }

        private void ShowTicketDetails(int assignmentID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetEngineerTicketsInPopUp", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@AssignmentID", assignmentID);
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
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
                            lblDetailAppointmentDate.Text = "Appointment Date: " + reader["AppointmentDate"].ToString();
                            lblDetailInstructions.Text = "Instructions: " + reader["Instruction"].ToString();
                            hfAssignmentID.Value = assignmentID.ToString();

                            string currentStatus = reader["Status"].ToString();
                            ddlModalTicketStatus.SelectedValue = currentStatus == "Close" ? "Close" : currentStatus == "Reject" ? "Reject" : "0";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error fetching ticket details: {ex.Message}');", true);
            }
        }

        protected void btnModalUpdateStatus_Click(object sender, EventArgs e)
        {
            try
            {
                int assignmentID = Convert.ToInt32(hfAssignmentID.Value);
                string status = ddlModalTicketStatus.SelectedValue;
                string remark = txtModalTicketRemark.Text;

                if (status == "0")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select a status.');", true);
                    return;
                }

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("UpdateTicketStatus", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@AssignmentID", assignmentID);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Remark", remark);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                ClearForm();
                BindEngineerTickets();
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "$('#viewTicketModal').modal('hide'); alert('Ticket status updated successfully.');", true);
            }
            catch (Exception ex)
            {
                LogError(ex);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error updating ticket status: {ex.Message}');", true);
            }
        }


        private void LogError(Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);

        }
        private void ClearForm()
        {
            ddlModalTicketStatus.SelectedIndex = 0;
            txtModalTicketRemark.Text = string.Empty;
        }
    }
}
