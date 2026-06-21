using System;
using System.Web;
using System.Web.UI;

namespace Desi_Bite.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }
    }
}