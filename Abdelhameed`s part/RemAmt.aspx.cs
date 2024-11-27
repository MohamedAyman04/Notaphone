using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Abdelhameed_s_part
{
    public partial class RemAmt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        private object GetSingleValue()
        {
            String connStr = WebConfigurationManager.ConnectionStrings["NotaphoneConnection"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Remaining_plan_amount", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string userID = Session["mobno"] as string;
            string input2 = TextBox1.Text;

            cmd.Parameters.AddWithValue("@mobile_num", userID);
            cmd.Parameters.AddWithValue("@plan_name", input2);

            conn.Open();
            return cmd.ExecuteScalar();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Text = GetSingleValue().ToString();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer2.aspx");
        }
    }
}