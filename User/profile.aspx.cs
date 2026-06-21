using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Desi_Bite.User
{
    public partial class profile : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // ✅ FIX: UserID check કરો
                if (Session["UserID"] != null)
                {
                    LoadUserProfile();
                }
                else
                {
                    Response.Redirect("UserLoginChoice.aspx");
                }
            }
        }

        // ✅ FIX: UserID વાપરો Name નહીં
        private void LoadUserProfile()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                // ✅ We still SELECT Email to show in the sidebar (litEmailMenu)
                string query = "SELECT Name, Email, Address, TotalPoints FROM Users WHERE UserId = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", Session["UserID"].ToString());

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    // Sidebar display (These Literals must exist in your ASPX)
                    if (litNameMenu != null) litNameMenu.Text = dr["Name"].ToString();
                    if (litEmailMenu != null) litEmailMenu.Text = dr["Email"].ToString();

                    // Reward Points
                    string pts = dr["TotalPoints"].ToString();
                    if (lblUserPoints != null) lblUserPoints.Text = string.IsNullOrEmpty(pts) ? "0" : pts;

                    // Form Fields
                    if (txtName != null) txtName.Text = dr["Name"].ToString();
                    if (txtLocation != null) txtLocation.Text = dr["Address"].ToString();

                    // ✅ CRITICAL: Removed txtEmail.Text and txtMobile.Text assignments 
                    // because those controls were deleted from your HTML.
                }
            }
        }

        // ✅ FIX: UserID વાપરો
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null) return;
            string userId = Session["UserID"].ToString();

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // 1. First, check if the "Current Password" matches what is in the DB
                string checkQuery = "SELECT Password FROM Users WHERE UserId = @UserID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@UserID", userId);
                string dbPassword = checkCmd.ExecuteScalar()?.ToString();

                // Check if Current Password field is filled if they want to change it
                if (!string.IsNullOrEmpty(txtNewPassword.Text))
                {
                    if (txtCurrentPassword.Text != dbPassword)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Current password does not match!');", true);
                        return;
                    }
                    if (txtNewPassword.Text != txtConfirmPassword.Text)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('New passwords do not match!');", true);
                        return;
                    }
                }

                // 2. Prepare the Update Query
                // If New Password is empty, we keep the old one. If not, we use the new one.
                string updatedPassword = string.IsNullOrEmpty(txtNewPassword.Text) ? dbPassword : txtNewPassword.Text.Trim();

                string updateQuery = "UPDATE Users SET Name=@Name, Address=@Address, Password=@Pass WHERE UserId=@UserID";
                SqlCommand cmd = new SqlCommand(updateQuery, conn);
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtLocation.Text.Trim());
                cmd.Parameters.AddWithValue("@Pass", updatedPassword);
                cmd.Parameters.AddWithValue("@UserID", userId);

                cmd.ExecuteNonQuery();

                // Update Session name in case it changed
                Session["UserName"] = txtName.Text.Trim();

                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Profile and Password updated successfully!');", true);

                // Clear password fields for security
                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";

                LoadUserProfile();
            }
        }

        protected void lnkMyOrders_Click(object sender, EventArgs e)
        {
            orderHeader.InnerText = "My Order History";
            LoadOrders("History");
        }

        protected void lnkOrderStatus_Click(object sender, EventArgs e)
        {
            orderHeader.InnerText = "Current Order Status";
            LoadOrders("Status");
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("UserLoginChoice.aspx");
        }

        // ✅ FIX: UserID વાપરો
        private void LoadOrders(string type)
        {
            if (Session["UserID"] == null) return;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query;

                if (type == "History")
                {
                    // બધા orders — delivered અને cancelled સહિત
                    query = @"SELECT OrderNo, OrderDate, Status 
                              FROM Orders 
                              WHERE UserId = @UserId 
                              ORDER BY OrderDate DESC";
                }
                else
                {
                    // ફક્ત active orders — delivered અને cancelled નહીં
                    query = @"SELECT OrderNo, OrderDate, Status 
                              FROM Orders 
                              WHERE UserId = @UserId 
                              AND Status NOT IN ('Delivered', 'Cancelled')
                              ORDER BY OrderDate DESC";
                }

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvOrders.DataSource = dt;
                    gvOrders.DataBind();
                    pnlOrders.Visible = true;
                }
                else
                {
                    // ✅ FIX: કોઈ orders ન હોય તો message બતાવો
                    gvOrders.DataSource = dt;
                    gvOrders.DataBind();
                    pnlOrders.Visible = true;
                }
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string orderNo = e.CommandArgument.ToString();

            if (e.CommandName == "CancelOrder")
            {
                UpdateOrderStatus(orderNo, "Cancelled");
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Order cancelled successfully!');", true);
                LoadOrders("History");
            }
            else if (e.CommandName == "Reorder")
            {
                ProcessReorder(orderNo);
            }
        }

        // ✅ FIX: UserID વાપરો
        private void ProcessReorder(string orderNo)
        {
            if (Session["UserID"] == null) return;
            string userId = Session["UserID"].ToString();

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // Cart clear કરો
                string clearCart = "DELETE FROM Carts WHERE UserId = @UserId";
                SqlCommand cmdClear = new SqlCommand(clearCart, conn);
                cmdClear.Parameters.AddWithValue("@UserId", userId);
                cmdClear.ExecuteNonQuery();

                // ✅ FIX: Previous order items cart માં ઉમેરો
                string reorderQuery = @"INSERT INTO Carts (UserId, ProductId, Quantity, Price) 
                                        SELECT @UserId, o.ProductId, o.Quantity, p.Price 
                                        FROM Orders o
                                        INNER JOIN Products p ON o.ProductId = p.ProductId
                                        WHERE o.OrderNo = @OrderNo";

                SqlCommand cmdReorder = new SqlCommand(reorderQuery, conn);
                cmdReorder.Parameters.AddWithValue("@UserId", userId);
                cmdReorder.Parameters.AddWithValue("@OrderNo", orderNo);

                int rows = cmdReorder.ExecuteNonQuery();

                if (rows > 0)
                {
                    Response.Redirect("OrderSummary.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Reorder failed. Order items not found.');", true);
                }
            }
        }

        private void UpdateOrderStatus(string orderNo, string newStatus)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "UPDATE Orders SET Status = @Status WHERE OrderNo = @OrderNo";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@OrderNo", orderNo);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}