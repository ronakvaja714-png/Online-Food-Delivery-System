using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Desi_Bite.User
{
    public partial class Default : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFeedback();
            }
        }

        private void BindFeedback()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT TOP 6 name, msg, rating, created_at FROM Feedback ORDER BY created_at DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    rptrFeedback.DataSource = dt;
                    rptrFeedback.DataBind();
                }
            }
        }
    }
}