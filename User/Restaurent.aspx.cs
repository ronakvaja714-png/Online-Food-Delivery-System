using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Desi_Bite.User
{
    public partial class Restaurent : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRestaurants();
            }
        }

        private void BindRestaurants()
{
    using (SqlConnection con = new SqlConnection(cs))
    {
       
        string query = "SELECT Restaurant_ID, Restaurant_Name, Location, Photo FROM Restaurant";
        SqlDataAdapter sda = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        
        rptrRestaurants.DataSource = dt;
        rptrRestaurants.DataBind();
    }
}
    }
}