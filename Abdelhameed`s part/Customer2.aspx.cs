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

        protected void ActiveBenefitsView(object sender, EventArgs e)
        {
            Response.Redirect("AcBs.aspx");

        }

        protected void TicketAccountCustomerProc(object sender, EventArgs e)
        {
            Response.Redirect("NRT.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("HighestVoucher.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("RemAmt.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExAmt.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("TSP.aspx");
        }
    }
}