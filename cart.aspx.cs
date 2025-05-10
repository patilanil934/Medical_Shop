using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class cart : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            if (Session["cart"] != null)
            {
                DataTable cart = (DataTable)Session["cart"];
                rptCart.DataSource = cart;
                rptCart.DataBind();

                decimal totalAmount = cart.AsEnumerable().Sum(row => Convert.ToDecimal(row["total"]));
                lblTotalAmount.Text = totalAmount.ToString("0.00");

                // ✅ Generate QR Code
                string upiId = "7798349398@ybl"; // Replace with your UPI ID
                string customerName = "MedicalShop Customer"; // Replace with actual user name if available
                string upiUrl = $"upi://pay?pa={upiId}&pn={HttpUtility.UrlEncode(customerName)}&am={totalAmount}&cu=INR";
                string qrCodeUrl = "https://api.qrserver.com/v1/create-qr-code/?data=" + HttpUtility.UrlEncode(upiUrl) + "&size=250x250";

                imgQRCode.ImageUrl = qrCodeUrl;
                imgQRCode.Visible = true;
                lblQRNote.Visible = true;
            }
            else
            {
                lblTotalAmount.Text = "0.00";
                imgQRCode.Visible = false;
                lblQRNote.Visible = false;
            }
        }

        protected void IncreaseQuantity(object sender, EventArgs e)
        {
            Button btnPlus = (Button)sender;
            int productId = Convert.ToInt32(btnPlus.CommandArgument);

            DataTable cart = (DataTable)Session["cart"];
            DataRow row = cart.AsEnumerable().FirstOrDefault(r => Convert.ToInt32(r["product_id"]) == productId);

            if (row != null)
            {
                int newQuantity = Convert.ToInt32(row["quantity"]) + 1;
                row["quantity"] = newQuantity;
                row["total"] = Convert.ToDecimal(row["price"]) * newQuantity;
                Session["cart"] = cart;
            }

            LoadCart();
        }

        protected void DecreaseQuantity(object sender, EventArgs e)
        {
            Button btnMinus = (Button)sender;
            int productId = Convert.ToInt32(btnMinus.CommandArgument);

            DataTable cart = (DataTable)Session["cart"];
            DataRow row = cart.AsEnumerable().FirstOrDefault(r => Convert.ToInt32(r["product_id"]) == productId);

            if (row != null && Convert.ToInt32(row["quantity"]) > 1)
            {
                int newQuantity = Convert.ToInt32(row["quantity"]) - 1;
                row["quantity"] = newQuantity;
                row["total"] = Convert.ToDecimal(row["price"]) * newQuantity;
                Session["cart"] = cart;
            }

            LoadCart();
        }

        protected void RemoveFromCart(object sender, EventArgs e)
        {
            Button btnRemove = (Button)sender;
            int productId = Convert.ToInt32(btnRemove.CommandArgument);

            DataTable cart = (DataTable)Session["cart"];
            DataRow row = cart.AsEnumerable().FirstOrDefault(r => Convert.ToInt32(r["product_id"]) == productId);

            if (row != null)
            {
                cart.Rows.Remove(row);
                Session["cart"] = cart;
            }

            LoadCart();
        }

        protected void ProceedToCheckout(object sender, EventArgs e)
        {
            if (Session["cart"] == null || ((DataTable)Session["cart"]).Rows.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Oops!', 'Your cart is empty!', 'warning');", true);
                return;
            }

            if (Session["UserID"] == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire({ title: 'Warning', text: 'Please login first.', icon: 'warning' }).then(() => { window.location='loginuser.aspx'; });", true);
                return;
            }

            // ✅ Corrected User ID retrieval
            int userId = Convert.ToInt32(Session["UserID"]);
            DataTable cart = (DataTable)Session["cart"];
            decimal totalAmount = cart.AsEnumerable().Sum(row => Convert.ToDecimal(row["total"]));

            try
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                string insertOrderQuery = "INSERT INTO orders (user_id, total_amount, order_date, status) OUTPUT INSERTED.id VALUES (@user_id, @total_amount, GETDATE(), 'Pending')";
                SqlCommand orderCmd = new SqlCommand(insertOrderQuery, con, transaction);
                orderCmd.Parameters.AddWithValue("@user_id", userId);
                orderCmd.Parameters.AddWithValue("@total_amount", totalAmount);
                int orderId = Convert.ToInt32(orderCmd.ExecuteScalar());

                string insertOrderItemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price, total) VALUES (@order_id, @product_id, @quantity, @price, @total)";
                foreach (DataRow row in cart.Rows)
                {
                    SqlCommand orderItemCmd = new SqlCommand(insertOrderItemQuery, con, transaction);
                    orderItemCmd.Parameters.AddWithValue("@order_id", orderId);
                    orderItemCmd.Parameters.AddWithValue("@product_id", row["product_id"]);
                    orderItemCmd.Parameters.AddWithValue("@quantity", row["quantity"]);
                    orderItemCmd.Parameters.AddWithValue("@price", row["price"]);
                    orderItemCmd.Parameters.AddWithValue("@total", row["total"]);
                    orderItemCmd.ExecuteNonQuery();
                }

                transaction.Commit();
                Session["cart"] = null;

                ClientScript.RegisterStartupScript(this.GetType(), "redirect", $@"
    Swal.fire({{
        title: 'Success!',
        text: 'Your order has been placed successfully.',
        icon: 'success'
    }}).then(() => {{
        window.location = 'Invoice.aspx?orderid={orderId}';
    }});", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"Swal.fire('Error!', 'Error placing order: {ex.Message}', 'error');", true);
            }
            finally
            {
                con.Close();
            }
        }

    }
}
