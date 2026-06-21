using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Desi_Bite.Admin
{
    public partial class Viewfeedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeedback();
            }
        }

        private void LoadFeedback()
        {
            string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Feedback ORDER BY created_at DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvFeedback.DataSource = dt;
                gvFeedback.DataBind();
            }
        }
    }
}
