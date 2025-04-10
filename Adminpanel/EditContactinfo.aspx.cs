using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop.Adminpanel
{
    public partial class EditContactinfo : System.Web.UI.Page
    {
        string connStr = WebConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadContactInfo();
            }
        }

        private void LoadContactInfo()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 1 Address, Email, Phone FROM contactinfo";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtAddress.Text = reader["Address"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtPhone.Text = reader["Phone"].ToString();
                }
                con.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string deleteOld = "DELETE FROM contactinfo";
                string insertNew = "INSERT INTO contactinfo (Address, Email, Phone) VALUES (@Address, @Email, @Phone)";
                SqlCommand cmd = new SqlCommand(deleteOld + ";" + insertNew, con);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                // SweetAlert Script
                string script = "Swal.fire({ icon: 'success', title: 'Updated', text: 'Contact info updated successfully!' });";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
        }
    }
}