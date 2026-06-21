using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace Desi_Bite.Admin
{
    public partial class EditRestaurant : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    LoadData(Convert.ToInt32(Request.QueryString["id"]));
                }
                else
                {
                    Response.Redirect("Restaurent.aspx");
                }
            }
        }

        void LoadData(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Restaurant WHERE Restaurant_ID = @id", con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtName.Text = dr["Restaurant_Name"].ToString();
                    txtLocation.Text = dr["Location"].ToString();
                    txtOpenHours.Text = dr["Open_Hours"].ToString();
                    imgCurrent.ImageUrl = dr["Photo"].ToString();
                    hfCurrentPhoto.Value = dr["Photo"].ToString();
                }
            }
        }

        protected void btnSubmitUpdate_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(Request.QueryString["id"]);
            string photoPath = hfCurrentPhoto.Value;

            if (fuPhoto.HasFile)
            {
                string fileName = Path.GetFileName(fuPhoto.FileName);
                photoPath = "~/Image/" + fileName;
                fuPhoto.SaveAs(Server.MapPath(photoPath));
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE Restaurant SET Restaurant_Name=@name, Location=@loc, Open_Hours=@hours, Photo=@photo WHERE Restaurant_ID=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", txtName.Text);
                cmd.Parameters.AddWithValue("@loc", txtLocation.Text);
                cmd.Parameters.AddWithValue("@hours", txtOpenHours.Text);
                cmd.Parameters.AddWithValue("@photo", photoPath);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("Restaurent.aspx");
            }
        }
    }
}