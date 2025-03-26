using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop.Adminpanel
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardCounts();
            }
        }

        private void LoadDashboardCounts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Fetch counts
                int categoryCount = GetCount(conn, "SELECT COUNT(*) FROM categories");
                int productCount = GetCount(conn, "SELECT COUNT(*) FROM products");
                int pendingOrders = GetCount(conn, "SELECT COUNT(*) FROM orders WHERE status = 'Pending'");
                int completedOrders = GetCount(conn, "SELECT COUNT(*) FROM orders WHERE status = 'Delivered'");

                // Assign to labels
                lblCategories.InnerText = categoryCount.ToString();
                lblProducts.InnerText = productCount.ToString();
                lblPendingOrders.InnerText = pendingOrders.ToString();
                lblCompletedOrders.InnerText = completedOrders.ToString();
            }
        }

        private int GetCount(SqlConnection conn, string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                return (int)cmd.ExecuteScalar();
            }
        }
    }
}