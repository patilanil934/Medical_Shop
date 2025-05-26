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
                LoadContactInfo();

                if (Request.QueryString["logout"] == "true")
                {
                    LogoutUser();
                }

                if (Session["UserID"] != null)
                {
                    LoadReminders();
                }
            }
        }

        private void LoadContactInfo()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT TOP 1 * FROM contactinfo";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                // Set text
                                litAddress.Text = dr["address"]?.ToString();
                                litEmail.Text = dr["email"]?.ToString();
                                litPhone.Text = dr["phone"]?.ToString();

                                // Set hrefs dynamically
                                emailLink.HRef = "mailto:" + dr["email"]?.ToString();
                                phoneLink.HRef = "tel:" + dr["phone"]?.ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Optional: log the error to the console or file
                System.Diagnostics.Debug.WriteLine("Contact Info Error: " + ex.Message);
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