using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace Desi_Bite.User
{
    public partial class OrderSummary : System.Web.UI.Page
    {
        readonly string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ FIX: UserID session check (UserName ની જગ્યે)
            if (Session["UserID"] == null)
            {
                Response.Redirect("UserLoginChoice.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["ProdId"] != null)
                {
                    pnlSingleItem.Visible = true;
                    rptrOrderItems.Visible = false;
                    LoadProductDetails(Request.QueryString["ProdId"]);
                }
                else
                {
                    pnlSingleItem.Visible = false;
                    rptrOrderItems.Visible = true;
                    LoadCartDetails();
                }
                LoadUserDetails();
            }
        }

        // ✅ FIX: UserID વાપરો, UserName નહીં
        private void LoadCartDetails()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT p.Name, c.Quantity, (c.Price * c.Quantity) as Total 
                                FROM Carts c 
                                INNER JOIN Products p ON c.ProductId = p.ProductId 
                                WHERE c.UserId = @UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                con.Open();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptrOrderItems.DataSource = dt;
                    rptrOrderItems.DataBind();

                    decimal grandTotal = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        grandTotal += Convert.ToDecimal(row["Total"]);
                    }
                    lblGrandTotal.Text = grandTotal.ToString("N2");
                    lblSubTotal.Text = grandTotal.ToString("N2");
                }
                else
                {
                    // Cart ખાલી છે તો home redirect
                    ScriptManager.RegisterStartupScript(this, GetType(), "empty",
                        "alert('Your cart is empty!'); window.location='Default.aspx';", true);
                }
            }
        }

        private void LoadProductDetails(string pid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT Name, Price FROM Products WHERE ProductId = @pid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@pid", pid);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblPName.Text = dr["Name"].ToString();
                    lblPrice.Text = dr["Price"].ToString();
                    lblSubTotal.Text = lblGrandTotal.Text = dr["Price"].ToString();
                }
            }
        }

        // ✅ FIX: UserID વાપરો
        private void LoadUserDetails()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT Address FROM Users WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());
                con.Open();
                object addr = cmd.ExecuteScalar();
                if (addr != null) lblAddress.Text = addr.ToString();
            }
        }

        protected void rblPayment_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlOnlinePayment.Visible = (rblPayment.SelectedValue == "Online");
            btnPlaceOrder.Text = (rblPayment.SelectedValue == "COD") ? "Confirm & Place Order" : "Pay & Place Order";
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string paymentMode = rblPayment.SelectedValue;
            string orderNo = "DB" + DateTime.Now.ToString("yyyyMMddHHmmss");
            decimal totalAmount = Convert.ToDecimal(lblGrandTotal.Text);

            // Reward Points Validation
            if (paymentMode == "Points")
            {
                int availablePoints = GetUserPoints();
                if ((availablePoints / 5.0m) < totalAmount)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Insufficient Points! You do not have enough points.');", true);
                    return;
                }
            }

            if (paymentMode == "Online")
            {
                if (string.IsNullOrEmpty(txtCardNo.Text) || txtCardNo.Text.Length < 16)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Enter valid 16-digit card number');", true);
                    return;
                }
            }

            // ✅ FIX: error visible કરો
            bool success = SaveOrderToDB(orderNo, paymentMode);

            if (!success) return;

            int rewardToAdd = Convert.ToInt32(totalAmount / 10);
            int pointsToDeduct = (paymentMode == "Points") ? Convert.ToInt32(totalAmount * 5) : 0;
            UpdateUserPoints(rewardToAdd, pointsToDeduct);

            if (paymentMode == "Online" || paymentMode == "Points")
            {
                GenerateInvoice(orderNo, paymentMode);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Order Placed Successfully!'); window.location='Default.aspx';", true);
            }
        }

        // ✅ FIX: UserID વાપરો
        private int GetUserPoints()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT ISNULL(TotalPoints, 0) FROM Users WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        // ✅ FIX: UserID વાપરો
        private void UpdateUserPoints(int add, int deduct)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "UPDATE Users SET TotalPoints = ISNULL(TotalPoints, 0) + @add - @deduct WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@add", add);
                cmd.Parameters.AddWithValue("@deduct", deduct);
                cmd.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // ✅ MAIN FIX: Cart orders હવે save થશે + bool return કરે છે
        private bool SaveOrderToDB(string orderNo, string mode)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();
                try
                {
                    string payId = "0";

                    // Payment record insert
                    if (mode != "COD")
                    {
                        string payQuery = @"INSERT INTO Payment (Name, CardNo, ExpiryDate, CvvNo, Address, PaymentMode) 
                                           OUTPUT INSERTED.PaymentId 
                                           VALUES (@n, @c, @e, @cv, @a, @m)";
                        SqlCommand cmdPay = new SqlCommand(payQuery, con, trans);

                        // ✅ FIX: UserID থেকে Name load করুন
                        string userName = GetUserName();
                        cmdPay.Parameters.AddWithValue("@n", userName);
                        cmdPay.Parameters.AddWithValue("@c", mode == "Online" ? txtCardNo.Text : "POINTS_PAY");
                        cmdPay.Parameters.AddWithValue("@e", mode == "Online" ? txtExpiry.Text : "N/A");
                        cmdPay.Parameters.AddWithValue("@cv", mode == "Online" ? txtCVV.Text : "000");
                        cmdPay.Parameters.AddWithValue("@a", lblAddress.Text);
                        cmdPay.Parameters.AddWithValue("@m", mode);
                        payId = cmdPay.ExecuteScalar().ToString();
                    }

                    string insOrder = @"INSERT INTO Orders (OrderNo, ProductId, Quantity, UserId, Status, PaymentId, OrderDate) 
                                       VALUES (@ono, @pid, @qty, @uid, 'Pending', @payid, GETDATE())";

                    if (Request.QueryString["ProdId"] != null)
                    {
                        // Single item order
                        SqlCommand cmd = new SqlCommand(insOrder, con, trans);
                        cmd.Parameters.AddWithValue("@ono", orderNo);
                        cmd.Parameters.AddWithValue("@pid", Request.QueryString["ProdId"]);
                        cmd.Parameters.AddWithValue("@qty", lblQty.Text);
                        cmd.Parameters.AddWithValue("@uid", Session["UserID"].ToString());
                        cmd.Parameters.AddWithValue("@payid", payId);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        // ✅ MAIN FIX: Cart items — database માંથી load કરો અને save કરો
                        string cartQuery = @"SELECT ProductId, Quantity 
                                            FROM Carts 
                                            WHERE UserId = @UserId";
                        SqlCommand cmdCart = new SqlCommand(cartQuery, con, trans);
                        cmdCart.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());

                        SqlDataReader reader = cmdCart.ExecuteReader();
                        DataTable cartItems = new DataTable();
                        cartItems.Load(reader);

                        if (cartItems.Rows.Count == 0)
                        {
                            trans.Rollback();
                            ScriptManager.RegisterStartupScript(this, GetType(), "err",
                                "alert('Cart is empty! Cannot place order.');", true);
                            return false;
                        }

                        foreach (DataRow row in cartItems.Rows)
                        {
                            SqlCommand cmd = new SqlCommand(insOrder, con, trans);
                            cmd.Parameters.AddWithValue("@ono", orderNo);
                            cmd.Parameters.AddWithValue("@pid", row["ProductId"]);
                            cmd.Parameters.AddWithValue("@qty", row["Quantity"]);
                            cmd.Parameters.AddWithValue("@uid", Session["UserID"].ToString());
                            cmd.Parameters.AddWithValue("@payid", payId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Cart clear કરો
                    string delCart = "DELETE FROM Carts WHERE UserId = @UserId";
                    SqlCommand cmdDel = new SqlCommand(delCart, con, trans);
                    cmdDel.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());
                    cmdDel.ExecuteNonQuery();

                    trans.Commit();
                    return true;
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    // ✅ FIX: Error visible કરો — silent નહીં
                    string errMsg = ex.Message.Replace("'", "").Replace("\r", "").Replace("\n", " ");
                    ScriptManager.RegisterStartupScript(this, GetType(), "err",
                        $"alert('Order Failed: {errMsg}');", true);
                    return false;
                }
            }
        }

        // ✅ Helper: UserID થી Name get કરો
        private string GetUserName()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT Name FROM Users WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserID"].ToString());
                con.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? result.ToString() : "";
            }
        }

        private void GenerateInvoice(string orderNo, string payMode)
        {
            Document pdfDoc = new Document(PageSize.A4, 50, 50, 25, 25);
            using (MemoryStream ms = new MemoryStream())
            {
                PdfWriter.GetInstance(pdfDoc, ms);
                pdfDoc.Open();
                pdfDoc.Add(new Paragraph("DESI BITE - INVOICE",
                    FontFactory.GetFont("Arial", 20, iTextSharp.text.Font.BOLD)));
                pdfDoc.Add(new Paragraph("Order No: " + orderNo));
                pdfDoc.Add(new Paragraph("Customer: " + GetUserName()));
                pdfDoc.Add(new Paragraph("Payment: " + payMode));
                pdfDoc.Add(new Paragraph("Total: Rs. " + lblGrandTotal.Text));
                pdfDoc.Close();

                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_" + orderNo + ".pdf");
                Response.BinaryWrite(ms.ToArray());
                Response.End();
            }
        }

        protected void btnPlus_Click(object sender, EventArgs e)
        {
            lblQty.Text = (Convert.ToInt32(lblQty.Text) + 1).ToString();
            UpdateTotals();
        }

        protected void btnMinus_Click(object sender, EventArgs e)
        {
            int q = Convert.ToInt32(lblQty.Text);
            if (q > 1) lblQty.Text = (q - 1).ToString();
            UpdateTotals();
        }

        private void UpdateTotals()
        {
            lblSubTotal.Text = lblGrandTotal.Text =
                (Convert.ToDouble(lblPrice.Text) * Convert.ToInt32(lblQty.Text)).ToString("0.00");
        }

        protected void btnEditAddress_Click(object sender, EventArgs e)
        {
            lblAddress.Visible = false;
            txtNewAddress.Visible = true;
            txtNewAddress.Text = lblAddress.Text;
            btnUpdateAddr.Visible = true;
            btnEditAddress.Visible = false;
        }

        protected void btnUpdateAddr_Click(object sender, EventArgs e)
        {
            lblAddress.Text = txtNewAddress.Text;
            lblAddress.Visible = true;
            txtNewAddress.Visible = false;
            btnUpdateAddr.Visible = false;
            btnEditAddress.Visible = true;
        }
    }
}