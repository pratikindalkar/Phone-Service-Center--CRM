using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Phone_Service_Center
{
    public partial class ServiceCenterMappingMaster : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowAllServiceCenterMappingMasterData();
                BindServiceCenterName();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("InsertServiceCenterMappingMaster", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@ServiceCenter", ddlServiceCenter.SelectedItem.Text);
                        string selectedPincodes = string.Join(",", chkPincodeList.Items.Cast<ListItem>().Where(i => i.Selected).Select(i => i.Value));
                        cmd.Parameters.AddWithValue("@Pincode", selectedPincodes);
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
                            Response.Write("<script>alert('Data saved successfully!');</script>");
                            ClearForm();
                            ShowAllServiceCenterMappingMasterData(); 
                        }
                        else
                        {
                            Response.Write("<script>alert('Something went wrong. Please try again.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
        private void BindServiceCenterName()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ServiceCenterID, ServiceCenterName FROM ServiceCenterMaster WHERE ServiceCenterName = ServiceCenterName", conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlServiceCenter.DataSource = reader;
                    ddlServiceCenter.DataValueField = "ServiceCenterID";
                    ddlServiceCenter.DataTextField = "ServiceCenterName";
                    ddlServiceCenter.DataBind();
                }
            }

            ddlServiceCenter.Items.Insert(0, new ListItem("Select Service Center", "0"));
        }
        private void ShowAllServiceCenterMappingMasterData()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["PSEConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("ShowAllServiceCenterMappingMasterData", con))
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
        
        private void ClearForm()
        {
            ddlServiceCenter.SelectedIndex = 0;
            foreach (ListItem item in chkPincodeList.Items)
            {
                item.Selected = false;
            }
        }
    }
}
