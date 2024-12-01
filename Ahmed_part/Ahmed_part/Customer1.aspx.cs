using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ahmed_part
{
    public partial class Customer1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
     

        }

       

        protected void ServicePlansClick(object sender, EventArgs e)
        {
            Response.Redirect("SP.aspx");

        }

        protected void TotalConsumptionClick(object sender, EventArgs e)
        {
            Response.Redirect("TC.aspx");

        }
        protected void OfferedPlansClick(object sender, EventArgs e)
        {
            Response.Redirect("OP.aspx");

        }

        protected void PlanUsageClick(object sender, EventArgs e)
        {
            Response.Redirect("PU.aspx");

        }

        protected void CashbackTransactionsClick(object sender, EventArgs e)
        {
            Response.Redirect("CT.aspx");

        }
    }
}