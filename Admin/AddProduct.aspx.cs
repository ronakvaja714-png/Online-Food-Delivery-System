using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace Desi_Bite.Admin
{
    public partial class AddProduct : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["resId"] == null)
                {
                    Response.Redirect("Restaurent.aspx");
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string resId = Request.QueryString["resId"];
            string imagePath = "Images/default.png";

            if (fuProductImg.HasFile)
            {
                string extension = Path.GetExtension(fuProductImg.FileName);
                string fileName = Guid.NewGuid().ToString() + extension;
                fuProductImg.SaveAs(Server.MapPath("~/Images/") + fileName);
                imagePath = "Images/" + fileName;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO Products (Name, Description, Price, Quantity, ImageUrl, CategoryId, IsActive, CreatedDate, Restaurant_ID) 
                                VALUES (@name, @desc, @price, @qty, @img, @catId, @active, @date, @resId)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@desc", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@price", Convert.ToDecimal(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@qty", Convert.ToInt32(txtQuantity.Text));
                    cmd.Parameters.AddWithValue("@img", imagePath);
                    cmd.Parameters.AddWithValue("@catId", 1);
                    cmd.Parameters.AddWithValue("@active", chkIsActive.Checked);
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                    cmd.Parameters.AddWithValue("@resId", resId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            Response.Redirect("ViewProducts.aspx?resId=" + resId);
        }
    }
}