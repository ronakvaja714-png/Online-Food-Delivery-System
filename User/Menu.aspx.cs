using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Desi_Bite.User
{
    public partial class Menu : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ResId"] == null)
            {
                Response.Redirect("Restaurent.aspx");
            }

            if (!IsPostBack)
            {
                BindMenu();
            }
        }

        private void BindMenu()
        {
            string restaurantId = Request.QueryString["ResId"];
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ProductId, Name, Description, Price, ImageUrl FROM Products WHERE Restaurant_ID = @ResId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ResId", restaurantId);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptrMenu.DataSource = dt;
                    rptrMenu.DataBind();
                }
            }
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