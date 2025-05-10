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
                LoadSalesDataForChart();
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

        private void LoadSalesDataForChart()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            List<object> salesData = new List<object>();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = @"SELECT 
                            FORMAT(order_date, 'MMM') AS [Month], 
                            SUM(total_amount) AS Total 
                         FROM orders 
                         WHERE status = 'Delivered'
                         GROUP BY FORMAT(order_date, 'MMM'), MONTH(order_date)
                         ORDER BY MONTH(order_date)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        salesData.Add(new
                        {
                            month = reader["Month"].ToString(),
                            total = Convert.ToDecimal(reader["Total"])
                        });
                    }
                }
            }

            // Serialize to JSON and assign to hidden field
            hfSalesData.Value = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(salesData);
        }

    }
}