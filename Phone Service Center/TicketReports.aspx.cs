using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Phone_Service_Center
{
    public partial class TicketReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindGridView();
        }
        private void BindGridView()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetTicketsWithDetails", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    GridViewTickets.DataSource = reader;
                    GridViewTickets.DataBind();
                }
            }
        }
    }
}