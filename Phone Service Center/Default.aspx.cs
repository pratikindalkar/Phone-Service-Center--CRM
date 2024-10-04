using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Phone_Service_Center
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string userCategory = Session["userCategory"] as string;
                LoadCounts(userCategory);
            }
        }
        private void LoadCounts(string userCategory)
        {
            LoadTotalTicketCounts();
            LoadCloseTicketCounts();
            if (userCategory == "Admin")
            {
                adminAssignedTickets.Visible = true; 
                LoadAssignTicketCounts(); 
            }
            else if (userCategory == "Engineer")
            {
                engineerRejectTickets.Visible = true; 
                LoadRejectedTicketCounts(); 
            }
        }

        private void LoadTotalTicketCounts()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM GenerateTicket";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int totalTickets = (int)cmd.ExecuteScalar();
                lblTotalTickets.Text = totalTickets.ToString();
            }
        }

        private void LoadAssignTicketCounts()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM AssignedEngineers";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int AssignedTickets = (int)cmd.ExecuteScalar();
                lblAssignedTickets.Text = AssignedTickets.ToString();
            }
        }

        private void LoadCloseTicketCounts()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM AssignedEngineers WHERE Status = 'Close'";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int CloseTickets = (int)cmd.ExecuteScalar();
                lblClosedTickets.Text = CloseTickets.ToString();
            }
        }

        private void LoadRejectedTicketCounts()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM AssignedEngineers WHERE Status = 'Reject'"; 

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int RejectedTickets = (int)cmd.ExecuteScalar();
                lblRejectTickets.Text = RejectedTickets.ToString(); 
            }
        }
    }
}