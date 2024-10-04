using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Phone_Service_Center
{
    public partial class SCWiseTicketsReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowServiceCenterWithTicketCounts();
            }
        }

        private void ShowServiceCenterWithTicketCounts()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetServiceCenterWithTicketCounts", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error fetching data: " + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                int serviceCenterID = Convert.ToInt32(e.CommandArgument);
                hdnSelectedServiceCenter.Value = serviceCenterID.ToString();
                ShowTicketDetails(serviceCenterID);
            }
        }

        private void ShowTicketDetails(int serviceCenterID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("GetTicketsByServiceCenter", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ServiceCenterID", serviceCenterID);

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
                            Response.Write("<script>alert('No ticket details found for the selected service center.');</script>");
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
