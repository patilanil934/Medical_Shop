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
    public partial class Orderlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT o.id, o.order_date, o.status, o.total_amount, u.name 
                                 FROM orders o 
                                 JOIN users u ON o.user_id = u.id 
                                 ORDER BY o.order_date DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptOrders.DataSource = dt;
                        rptOrders.DataBind();
                    }
                }
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                string orderID = e.CommandArgument.ToString();
                DropDownList ddlStatus = (DropDownList)e.Item.FindControl("ddlStatus");
                string newStatus = ddlStatus.SelectedValue;

                UpdateOrderStatus(orderID, newStatus);
            }
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DropDownList ddlStatus = (DropDownList)e.Item.FindControl("ddlStatus");
                string status = DataBinder.Eval(e.Item.DataItem, "status").ToString();

                if (ddlStatus != null)
                {
                    ListItem selectedItem = ddlStatus.Items.FindByValue(status);
                    if (selectedItem != null)
                    {
                        selectedItem.Selected = true;
                    }
                }
            }
        }

        private void UpdateOrderStatus(string orderID, string status)
        {
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE orders SET status = @Status WHERE id = @OrderID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@OrderID", orderID);

                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "updateSuccess", @"
                            Swal.fire({
                                title: 'Success!',
                                text: 'Order updated successfully!',
                                icon: 'success'
                            }).then(() => {
                                window.location='Orderlist.aspx';
                            });
                        ", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "updateFail", @"
                            Swal.fire({
                                title: 'Error!',
                                text: 'Failed to update order.',
                                icon: 'error'
                            });
                        ", true);
                    }
                }
            }
        }

    }
}