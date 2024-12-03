using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace milestone3
{
    public partial class CalculateCashback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CalculateCashbackClick(object sender, EventArgs e)
        {
            string mobileNum = TextMobileNo.Text.Trim();
            int paymentId = int.Parse(TextPaymentID.Text.Trim());
            int benefitId = int.Parse(TextBenefitID.Text.Trim());

            if (string.IsNullOrEmpty(mobileNum) || !int.TryParse(TextPaymentID.Text.Trim(), out paymentId) || !int.TryParse(TextBenefitID.Text.Trim(), out benefitId))
            {
                Response.Write("<script>alert('Please enter valid inputs.');</script>");
                return;
            }
           
            string connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
                
            conn.Open();


            SqlCommand cmd = new SqlCommand("Payment_wallet_cashback", conn);
                    
            cmd.CommandType = CommandType.StoredProcedure;

                        
            cmd.Parameters.AddWithValue("@mobile_num", mobileNum);
            cmd.Parameters.AddWithValue("@payment_id", paymentId);
            cmd.Parameters.AddWithValue("@benefit_id", benefitId);

            int cashbackAmount = (int)cmd.ExecuteScalar();

            LabelResult.Text = $"Cashback Amount: {cashbackAmount}";

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