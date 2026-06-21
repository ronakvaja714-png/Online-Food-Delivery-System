using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Desi_Bite.Admin
{
    public partial class SellingReport : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDeliveredOrders();
            }
        }

        private void GetDeliveredOrders()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT OrderNo, UserId, OrderDate, Status FROM Orders WHERE Status = 'Delivered' ORDER BY OrderDate DESC";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                gvSellingReport.DataSource = dt;
                gvSellingReport.DataBind();

                litTotalOrders.Text = dt.Rows.Count.ToString();
            }
        }
    }
}