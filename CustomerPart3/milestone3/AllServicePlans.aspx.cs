using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class AllServicePlans : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void GetPlansClick(object sender, EventArgs e)
        {
            string mobileNo = TextMobileNo.Text.Trim();

            if (string.IsNullOrEmpty(mobileNo) || mobileNo.Length != 11)
            {
                Response.Write("<script>alert('Please enter a valid 11-digit mobile number.');</script>");
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
     
            conn.Open();

            string query = "SELECT * FROM dbo.Subscribed_plans_5_Months (@MobileNo)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@MobileNo", mobileNo);

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable table = new DataTable();
            adapter.Fill(table);

            GridViewPlans.DataSource = table;
            GridViewPlans.DataBind();   
        }

        protected void BackClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("CustomerPart3.aspx");
        }
    }
}