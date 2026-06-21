using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Desi_Bite.Admin
{
    public partial class UpdateStatus : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrderGrid();
            }
        }

        private void BindOrderGrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT OrderDetailsId, OrderNo, Status, OrderDate FROM Orders WHERE Status != 'Delivered' ORDER BY OrderDate DESC";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowOptions")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                Panel pnl = (Panel)gvOrders.Rows[index].FindControl("pnlOptions");
                LinkButton btnMain = (LinkButton)gvOrders.Rows[index].FindControl("btnShowOptions");

                if (pnl != null && btnMain != null)
                {
                    pnl.Visible = true;
                    btnMain.Visible = false;
                }
            }
            else if (e.CommandName == "ChangeStatus")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                if (args.Length == 2)
                {
                    int orderId = Convert.ToInt32(args[0]);
                    string statusValue = args[1];

                    UpdateStatusInDatabase(orderId, statusValue);
                    BindOrderGrid();
                }
            }
        }

        private void UpdateStatusInDatabase(int id, string nextStatus)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "UPDATE Orders SET Status = @status WHERE OrderDetailsId = @id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@status", nextStatus);
                        cmd.Parameters.AddWithValue("@id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception)
            {
                // Handle or log exception
            }
        }
    }
}