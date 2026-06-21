using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Desi_Bite.Admin
{
    public partial class AdminLogin : Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT Admin_Id FROM Admin WHERE Name=@name AND Password=@pass";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@name", txtAdminName.Text.Trim());
                        cmd.Parameters.AddWithValue("@pass", txtPassword.Text.Trim());

                        con.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            Session["AdminID"] = result.ToString();
                            Session["AdminName"] = txtAdminName.Text.Trim();

                          
                            System.Diagnostics.Debug.WriteLine("Login Successful, Redirecting...");

                            Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Username or Password incorrect!');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error", $"alert('Error: {ex.Message}');", true);
            }
        }
    }
}