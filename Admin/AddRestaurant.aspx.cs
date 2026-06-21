using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Desi_Bite.Admin
{
    public partial class AddRestaurant : System.Web.UI.Page
    {
        
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string photoPath = "";

               
                if (fuPhoto.HasFile)
                {
                    string folder = "~/Images/Restaurant/";

                    
                    string physicalPath = Server.MapPath(folder);
                    if (!Directory.Exists(physicalPath))
                    {
                        Directory.CreateDirectory(physicalPath);
                    }

                    string fileName = Guid.NewGuid() + Path.GetExtension(fuPhoto.FileName);
                    photoPath = folder + fileName;
                    fuPhoto.SaveAs(Path.Combine(physicalPath, fileName));
                }

                
                string query = "INSERT INTO Restaurant (Restaurant_Name, Phone_Number, Email, Location, Open_Hours, Photo) " +
                               "VALUES (@name, @phone, @email, @location, @open, @photo)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@location", txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@open", txtOpenHours.Text.Trim());
                    cmd.Parameters.AddWithValue("@photo", photoPath);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                
                Clear();
                Response.Write("<script>alert('Restaurant Added Successfully!');</script>");
            }
            catch (Exception ex)
            {
                
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                if (con.State == ConnectionState.Open) con.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
           
            try
            {
                string photoPath = "";

                
                if (fuPhoto.HasFile)
                {
                    string folder = "~/Images/Restaurant/";
                    string fileName = Guid.NewGuid() + Path.GetExtension(fuPhoto.FileName);
                    photoPath = folder + fileName;
                    fuPhoto.SaveAs(Server.MapPath(photoPath));
                }

                string query = "UPDATE Restaurant SET Restaurant_Name=@name, Phone_Number=@phone, Email=@email, " +
                               "Location=@location, Open_Hours=@open" +
                               (string.IsNullOrEmpty(photoPath) ? "" : ", Photo=@photo") +
                               " WHERE Restaurant_ID=@id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", hfId.Value);
                    cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@location", txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@open", txtOpenHours.Text.Trim());

                    if (!string.IsNullOrEmpty(photoPath))
                        cmd.Parameters.AddWithValue("@photo", photoPath);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                btnSave.Visible = true;
                btnUpdate.Visible = false;
                Clear();
                Response.Write("<script>alert('Restaurant Updated!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Update Error: " + ex.Message + "');</script>");
            }
        }

        void Clear()
        {
            txtName.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            txtLocation.Text = "";
            txtOpenHours.Text = "";
            hfId.Value = "";
        }
    }
}