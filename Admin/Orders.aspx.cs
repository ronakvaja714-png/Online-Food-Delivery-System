using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Desi_Bite.Admin
{
    public partial class Orders : Page
    {
        private readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrdersList();
            }
        }

        private void BindOrdersList()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string sql = @"SELECT o.OrderNo, 
                               u.Name as UserName, 
                               ISNULL(p.Name, 'Product #' + CAST(o.ProductId AS VARCHAR)) as ProductName, 
                               o.Quantity, 
                               o.Status,
                               (ISNULL(p.Price, 0) * o.Quantity) as TotalPrice
                               FROM Orders o
                               LEFT JOIN Users u ON o.UserId = u.UserId
                               LEFT JOIN Products p ON o.ProductId = p.ProductId
                               ORDER BY o.OrderDate DESC";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            gvOrders.DataSource = dt;
                            gvOrders.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string errorMsg = ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", "");
                Response.Write("<script>alert('Error: " + errorMsg + "');</script>");
            }
        }
    }
}