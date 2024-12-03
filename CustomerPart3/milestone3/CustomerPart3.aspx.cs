using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.NetworkInformation;

namespace milestone3
{
    public partial class ShopDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ShopClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("ViewAllShops.aspx");
        }
        protected void PlansClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("AllServicePlans.aspx");
        }
        protected void RenewSubscriptionClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("RenewSubscription.aspx");
        }
        protected void CalculateCashbackClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("CalculateCashback.aspx");
        }
        protected void RechargeBalance(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("RechargeBalance.aspx");
        }
        protected void RedeemVoucherClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("RedeemVoucher.aspx");
        }
    }
}