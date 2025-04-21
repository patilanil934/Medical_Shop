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
    public partial class Mainpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if logout is requested via URL query
                if (Request.QueryString["logout"] == "true")
                {
                    LogoutUser();
                }
            }
            if (!IsPostBack && Session["UserID"] != null)
            {
                LoadReminders();
            }
        }

        private void LoadReminders()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
        SELECT id, name, doctor_name, description 
        FROM prescription_order 
        WHERE reminder_days IS NOT NULL 
          AND DATEADD(DAY, reminder_days, created_at) <= GETDATE()
          AND user_id = @userId"; // ← THIS LINE was missing the ending quote

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userId", Session["UserID"]);
                conn.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptReminders.DataSource = dt;
                rptReminders.DataBind();

                // Show count
                ltlReminderCount.Text = dt.Rows.Count > 0
                    ? $"<span class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger'>{dt.Rows.Count}</span>"
                    : "";
            }
        }

        protected void btnReorder_Click(object sender, EventArgs e)
        {
            string id = ((Button)sender).CommandArgument;

            // You can redirect to prescription order page with prefilled data or just clone the old order
            Response.Redirect("ordermedicine.aspx?reorderId=" + id);
        }

        protected void btnNotRequired_Click(object sender, EventArgs e)
        {
            string id = ((Button)sender).CommandArgument;
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE prescription_order SET reminder_days = NULL WHERE id = @id AND user_id = @userId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@userId", Session["UserID"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadReminders(); // Refresh the dropdown
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            LogoutUser();
        }

        private void LogoutUser()
        {
            Session.Clear();  // Clears all session variables
            Session.Abandon();  // Destroys the session
            Response.Redirect("loginuser.aspx", true); // Redirect to login page
        }

    }
}