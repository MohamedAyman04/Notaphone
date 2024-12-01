using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Ahmed_part
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["NotaphoneConnection"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

     
            
        }

        
    }
}