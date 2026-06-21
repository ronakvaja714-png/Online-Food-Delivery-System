using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Desi_Bite.User
{
    public partial class mycart : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("UserLoginChoice.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"SELECT c.CartId, p.Name, p.Description, p.ImageUrl, c.Price, c.Quantity, (c.Price * c.Quantity) as Total 
                                FROM Carts c 
                                INNER JOIN Products p ON c.ProductId = p.ProductId 
                                WHERE c.UserId = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    int totalItems = dt.Rows.Count;
                    lblCartCount.Text = totalItems.ToString();

                    if (totalItems > 0)
                    {
                        rptrCart.DataSource = dt;
                        rptrCart.DataBind();
                        pnlCart.Visible = true;
                        pnlEmptyCart.Visible = false;
                        lblTopItemCount.Text = totalItems + " items";
                        CalculateTotal(dt);
                    }
                    else
                    {
                        pnlCart.Visible = false;
                        pnlEmptyCart.Visible = true;
                    }
                }
            }
        }

        private void CalculateTotal(DataTable dt)
        {
            decimal subTotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                subTotal += Convert.ToDecimal(row["Total"]);
            }

            decimal gstRate = 0.05m;
            decimal gstAmount = subTotal * gstRate;
            decimal grandTotal = subTotal + gstAmount;

            litSubtotal.Text = subTotal.ToString("N2");
            litGST.Text = gstAmount.ToString("N2");
            litTotalPayable.Text = grandTotal.ToString("N0");
        }

        protected void rptrCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RemoveItem")
            {
                int cartId = Convert.ToInt32(e.CommandArgument);
                DeleteFromCart(cartId);
                LoadCart();
            }
            else if (e.CommandName == "Plus" || e.CommandName == "Minus")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int cartId = Convert.ToInt32(args[0]);
                int currentQty = Convert.ToInt32(args[1]);
                int newQty = (e.CommandName == "Plus") ? currentQty + 1 : currentQty - 1;

                if (newQty > 0)
                {
                    UpdateQuantity(cartId, newQty);
                    LoadCart();
                }
            }
        }

        private void DeleteFromCart(int cartId)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "DELETE FROM Carts WHERE CartId = @CartID AND UserId = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CartID", cartId);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void UpdateQuantity(int cartId, int newQty)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "UPDATE Carts SET Quantity = @Qty WHERE CartId = @CartID AND UserId = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Qty", newQty);
                    cmd.Parameters.AddWithValue("@CartID", cartId);
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderSummary.aspx");
        }
    }
}