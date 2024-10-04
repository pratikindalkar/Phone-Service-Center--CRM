using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;

namespace Phone_Service_Center
{
    public partial class EngineerWiseTicketsReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowEngineerTicketCounts();
            }
        }

        private void ShowEngineerTicketCounts()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetEngineerTicketCounts", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        GridViewEngineers.DataSource = dt;
                        GridViewEngineers.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error fetching data: " + ex.Message + "');</script>");
            }
        }


        protected void GridViewEngineers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                string commandArgument = e.CommandArgument.ToString();

                if (int.TryParse(commandArgument, out int engineerID))
                {
                    ShowTicketDetails(engineerID); 
                }
                else
                {
                    Response.Write("<script>alert('Invalid Engineer ID. Please try again.');</script>");
                }
            }
        }


        private void ShowTicketDetails(int engineerID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetTicketsByEngineer", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@EngineerID", engineerID);  

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            GridViewTicketDetails.DataSource = dt;
                            GridViewTicketDetails.DataBind();
                            pnlTicketDetails.Style["display"] = "block";
                        }
                        else
                        {
                            Response.Write("<script>alert('No ticket details found for the selected engineer.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error fetching ticket details: " + ex.Message + "');</script>");
            }
        }


        protected void btnClosePopup_Click(object sender, EventArgs e)
        {
            pnlTicketDetails.Style["display"] = "none";
        }
    }
}
