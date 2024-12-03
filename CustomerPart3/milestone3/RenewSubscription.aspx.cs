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
    public partial class RenewSubscription : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }
        protected void RenewSubscriptionClick(object sender, EventArgs e)
        {
            string planID = TextPlanID.Text.Trim();
            string mobileNo = TextMobileNo.Text.Trim();
            string paymentMethod = TextPaymentMethod.Text.Trim();
            string amount = TextAmount.Text.Trim();

            if (string.IsNullOrEmpty(planID) || string.IsNullOrEmpty(mobileNo) || string.IsNullOrEmpty(paymentMethod) || string.IsNullOrEmpty(amount))
            {
                Response.Write("<script>alert('Please fill in all the fields');</script>");
                return;
            }

            decimal paymentAmount;
            if (!decimal.TryParse(amount, out paymentAmount))
            {
                Response.Write("<script>alert('Invalid amount entered');</script>");
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            conn.Open();
            SqlCommand cmd = new SqlCommand("Initiate_plan_payment", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@mobile_num", mobileNo);
            cmd.Parameters.AddWithValue("@amount", paymentAmount);
            cmd.Parameters.AddWithValue("@payment_method", paymentMethod);
            cmd.Parameters.AddWithValue("@plan_id", Convert.ToInt32(planID));

            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('Subscription renewed successfully');</script>");

            conn.Close();
        }

        protected void BackClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("CustomerPart3.aspx");
        }
    }
    
    
}