using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class myorders : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("loginuser.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserOrders();
            }
        }

        private void LoadUserOrders()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = "SELECT id, total_amount, order_date, status FROM orders WHERE user_id = @userId ORDER BY order_date DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@userId", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                }
                else
                {
                    lblMessage.Text = "No orders found.";
                    lblMessage.Visible = true;
                }
            }
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int orderId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "id"));
                Repeater rptOrderItems = (Repeater)e.Item.FindControl("rptOrderItems");

                string query = "SELECT product_id, quantity, price, total FROM order_items WHERE order_id = @orderId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@orderId", orderId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptOrderItems.DataSource = dt;
                        rptOrderItems.DataBind();
                    }
                }
            }
        }
    }
}