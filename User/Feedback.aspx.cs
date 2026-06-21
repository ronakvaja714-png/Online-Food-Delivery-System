using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace Desi_Bite.User
{
    public partial class Feedback : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("UserLoginChoice.aspx");
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["userId"] == null) return;

            int userId = Convert.ToInt32(Session["userId"]);
            string msg = txtMessage.Text.Trim();
            string rating = ddlRating.SelectedValue;

            if (msg == "" || rating == "")
            {
                Response.Write("<script>alert('Please fill all fields');</script>");
                return;
            }

            if (IsUserEligible(userId))
            {
                string userName = "";
                string userPhone = "";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string userQuery = "SELECT Name, Mobile FROM Users WHERE UserId = @uid";
                    SqlCommand cmdUser = new SqlCommand(userQuery, con);
                    cmdUser.Parameters.AddWithValue("@uid", userId);
                    SqlDataReader dr = cmdUser.ExecuteReader();

                    if (dr.Read())
                    {
                        userName = dr["Name"].ToString();
                        userPhone = dr["Mobile"].ToString();
                    }
                    dr.Close();

                    string insertQuery = "INSERT INTO Feedback (name, phone, msg, rating, created_at) VALUES (@name, @phone, @msg, @rating, GETDATE())";
                    SqlCommand cmdInsert = new SqlCommand(insertQuery, con);
                    cmdInsert.Parameters.AddWithValue("@name", userName);
                    cmdInsert.Parameters.AddWithValue("@phone", userPhone);
                    cmdInsert.Parameters.AddWithValue("@msg", msg);
                    cmdInsert.Parameters.AddWithValue("@rating", rating);

                    cmdInsert.ExecuteNonQuery();
                    con.Close();
                }

                Response.Write("<script>alert('Thank you for your feedback!');</script>");
                txtMessage.Text = "";
                ddlRating.SelectedIndex = 0;
            }
            else
            {
                Response.Write("<script>alert('You can only give feedback after placing an order.');</script>");
            }
        }

        private bool IsUserEligible(int userId)
        {
            bool hasOrdered = false;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM Orders WHERE UserId = @userId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@userId", userId);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                hasOrdered = (count > 0);
            }
            return hasOrdered;
        }
    }
}