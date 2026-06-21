using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Desi_Bite.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDashboardStats();
            }
        }

        private void GetDashboardStats()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            {
                try
                {
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Orders", con);
                    lblTotalOrders.Text = cmd1.ExecuteScalar().ToString();

                    SqlCommand cmd2 = new SqlCommand(@"SELECT ISNULL(SUM(p.Price * o.Quantity), 0) 
                                              FROM Orders o 
                                              LEFT JOIN Products p ON o.ProductId = p.ProductId", con);
                    object revenueResult = cmd2.ExecuteScalar();
                    decimal revenue = (revenueResult != DBNull.Value) ? Convert.ToDecimal(revenueResult) : 0;
                    lblTotalRevenue.Text = "₹ " + revenue.ToString("N0");

                    SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM Restaurant", con);
                    lblTotalRestaurants.Text = cmd3.ExecuteScalar().ToString();

                    SqlCommand cmd4 = new SqlCommand("SELECT COUNT(*) FROM Users", con);
                    lblActiveUsers.Text = cmd4.ExecuteScalar().ToString();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
                finally
                {
                    if (con.State == System.Data.ConnectionState.Open)
                    {
                        con.Close();
                    }
                }
            }
        }
    }
}