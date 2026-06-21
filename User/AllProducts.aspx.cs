using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Desi_Bite.User
{
    public partial class AllProducts : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAllProducts();
            }
        }

        private void BindAllProducts()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT p.ProductId, p.Name, p.Description, p.Price, p.ImageUrl, r.Restaurant_Name 
                               FROM Products p 
                               INNER JOIN Restaurant r ON p.Restaurant_ID = r.Restaurant_ID 
                               WHERE p.IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptrAllProducts.DataSource = dt;
                    rptrAllProducts.DataBind();
                }
            }
        }

        protected void btnOrderNow_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("UserLoginChoice.aspx");
                return;
            }

            string productId = ((LinkButton)sender).CommandArgument;
            string userId = Session["UserID"].ToString();

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // Step 1: Clear existing cart
                string clearCart = "DELETE FROM Carts WHERE UserId = @UserId";
                SqlCommand cmdClear = new SqlCommand(clearCart, conn);
                cmdClear.Parameters.AddWithValue("@UserId", userId);
                cmdClear.ExecuteNonQuery();

                // Step 2: Get product details
                string getProduct = "SELECT ProductId, Price FROM Products WHERE ProductId = @Pid";
                SqlCommand cmdGet = new SqlCommand(getProduct, conn);
                cmdGet.Parameters.AddWithValue("@Pid", productId);

                SqlDataReader dr = cmdGet.ExecuteReader();
                if (dr.Read())
                {
                    // ✅ Fix: Convert the price to double/decimal instead of just a string
                    double price = Convert.ToDouble(dr["Price"]);
                    dr.Close();

                    // Step 3: Insert into Carts
                    string addToCart = "INSERT INTO Carts (UserId, ProductId, Quantity, Price) VALUES (@Uid, @Pid, 1, @Price)";
                    SqlCommand cmdAdd = new SqlCommand(addToCart, conn);
                    cmdAdd.Parameters.AddWithValue("@Uid", userId);
                    cmdAdd.Parameters.AddWithValue("@Pid", productId);

                    // ✅ Fix: Use the numeric value so SQL doesn't get confused by the string format
                    cmdAdd.Parameters.AddWithValue("@Price", price);

                    cmdAdd.ExecuteNonQuery();
                }
            }

            Response.Redirect("OrderSummary.aspx");
        }   
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("UserLoginChoice.aspx");
                return;
            }

            Button btn = (Button)sender;
            string productId = btn.CommandArgument;
            string userId = Session["UserID"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO Carts (ProductId, Quantity, UserId, Price) 
                                SELECT ProductId, 1, @UserId, Price 
                                FROM Products WHERE ProductId = @Pid";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Pid", productId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Redirect("mycart.aspx");
        }
    }
}