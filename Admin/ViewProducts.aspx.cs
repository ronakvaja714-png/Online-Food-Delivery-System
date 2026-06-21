using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Desi_Bite.Admin
{
    public partial class ViewProducts : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["resId"] != null)
                {
                    string resId = Request.QueryString["resId"];

                    
                    hlAddProduct.NavigateUrl = "AddProduct.aspx?resId=" + resId;

                    LoadProducts(Convert.ToInt32(resId));
                }
            }
        }

        void LoadProducts(int resId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                
                string query = "SELECT * FROM Products WHERE Restaurant_ID = @resId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@resId", resId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                    else
                    {
                        lblMessage.Visible = true;
                    }
                }
            }
        }
    }
}