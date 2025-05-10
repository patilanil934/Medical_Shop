using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class Adminmasterpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPendingOrderCount();
                LoadPendingPrescriptionCount();
            }
        }

        private void LoadPendingOrderCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM orders WHERE status = 'Pending'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    litPendingOrders.Text = $"<span class='badge bg-danger ms-2'>{count}</span>";
                }
                else
                {
                    litPendingOrders.Text = "";
                }
            }
        }

        private void LoadPendingPrescriptionCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM prescription_order WHERE status = 'Pending'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    litPendingPrescriptions.Text = $"<span class='badge bg-warning text-dark ms-2'>{count}</span>";
                }
                else
                {
                    litPendingPrescriptions.Text = "";
                }
            }

        }
    }
}