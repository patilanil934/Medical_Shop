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
    public partial class registeruser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtFirstName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhoneNumber.Text.Trim();
            string password = txtPassword.Text.Trim();
            string address = txtAddress.Text.Trim();
            string city = txtCity.Text.Trim();
            string pinCode = txtPinCode.Text.Trim();
            int securityQuestion = Convert.ToInt32(ddlSecurityQuestion.SelectedValue);
            string securityAnswer = txtSecurityAnswer.Text.Trim();

            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(phone) ||
                string.IsNullOrWhiteSpace(password) || securityQuestion == 0 || string.IsNullOrWhiteSpace(securityAnswer))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Error!', 'All fields are required!', 'error');", true);
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "INSERT INTO users (name, email, phone, password, address, city, pin_code, security_question, security_answer) " +
                               "VALUES (@name, @email, @phone, @password, @address, @city, @pin_code, @security_question, @security_answer)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@phone", phone);
                    cmd.Parameters.AddWithValue("@password", password); // Hash the password in real implementation
                    cmd.Parameters.AddWithValue("@address", address);
                    cmd.Parameters.AddWithValue("@city", city);
                    cmd.Parameters.AddWithValue("@pin_code", pinCode);
                    cmd.Parameters.AddWithValue("@security_question", securityQuestion);
                    cmd.Parameters.AddWithValue("@security_answer", securityAnswer);

                    conn.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                            "Swal.fire('Success!', 'Registration successful! Redirecting to login...', 'success').then(() => { window.location='loginuser.aspx'; });",
                            true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                            "Swal.fire('Error!', 'Something went wrong. Please try again.', 'error');", true);
                    }
                }
            }
        }
    }
}