using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Desi_Bite.Admin
{
    public partial class Restaurent : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRestaurants();
            }
        }

        void LoadRestaurants()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Restaurant", con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvRestaurant.DataSource = dt;
                    gvRestaurant.DataBind();
                }
            }
        }

        protected void gvRestaurant_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int restaurantId = Convert.ToInt32(gvRestaurant.DataKeys[e.NewEditIndex].Value);
            Response.Redirect("EditRestaurant.aspx?id=" + restaurantId);
        }

        protected void gvRestaurant_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int restaurantId = Convert.ToInt32(gvRestaurant.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    string deleteProducts = "DELETE FROM Products WHERE Restaurant_ID = @id";
                    using (SqlCommand cmd1 = new SqlCommand(deleteProducts, con, transaction))
                    {
                        cmd1.Parameters.AddWithValue("@id", restaurantId);
                        cmd1.ExecuteNonQuery();
                    }

                    string deleteRestaurant = "DELETE FROM Restaurant WHERE Restaurant_ID = @id";
                    using (SqlCommand cmd2 = new SqlCommand(deleteRestaurant, con, transaction))
                    {
                        cmd2.Parameters.AddWithValue("@id", restaurantId);
                        cmd2.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();
                }
                finally
                {
                    con.Close();
                }
            }

            LoadRestaurants();
        }

        protected void btnAddRestaurant_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddRestaurant.aspx");
        }
    }
}