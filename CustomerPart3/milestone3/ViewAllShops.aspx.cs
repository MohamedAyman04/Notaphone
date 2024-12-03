using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace milestone3
{
    public partial class ViewAllShops : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                View();
            }
        }
        protected void View()
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            conn.Open();
            string query = "SELECT * FROM allShops";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader adapter = cmd.ExecuteReader();
            GridView1.DataSource = adapter;
            GridView1.DataBind();
        }

        protected void BackClick(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["TeleConnection"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            Response.Redirect("CustomerPart3.aspx");
        }
    }

}