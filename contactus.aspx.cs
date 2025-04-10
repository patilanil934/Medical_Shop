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
    public partial class contactus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadContactInfo();
            }
        }

        private void LoadContactInfo()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 1 * FROM contactinfo";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    litAddress.Text = dr["address"].ToString();
                    litEmail.Text = dr["email"].ToString();
                    litPhone.Text = dr["phone"].ToString();
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(message))
            {
                // You can show an alert for empty fields if needed
                return;
            }

            string cs = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "INSERT INTO contactmsg (name, email, message) VALUES (@name, @email, @message)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@message", message);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            // Clear fields after successful submit
            txtName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";

            // Trigger SweetAlert
            string script = @"
                <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Message Sent!',
                        text: 'Thank you for contacting us.',
                        confirmButtonColor: '#3085d6'
                    });
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script);
        }
    }
}