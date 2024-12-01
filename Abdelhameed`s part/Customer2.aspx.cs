using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Abdelhameed_s_part
{
    public partial class Customer2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void ActiveBenefitsClick(object sender, EventArgs e)
        {
            Response.Redirect("AcBs.aspx");

        }

        protected void NotResolvedTicketsClick(object sender, EventArgs e)
        {
            Response.Redirect("NRT.aspx");
        }

        protected void HighestVoucherClick(object sender, EventArgs e)
        {
            Response.Redirect("HighestVoucher.aspx");
        }

        protected void RemainingAmountClick(object sender, EventArgs e)
        {
            Response.Redirect("RemAmt.aspx");
        }

        protected void ExtraAmountClick(object sender, EventArgs e)
        {
            Response.Redirect("ExAmt.aspx");
        }

        protected void TopSuccessfulPaymentsClick(object sender, EventArgs e)
        {
            Response.Redirect("TSP.aspx");
        }
    }
}