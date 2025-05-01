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
    public partial class forgotpassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No code on page load
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string securityQuestion = ddlSecurityQuestion.SelectedValue; // Fix here
            string securityAnswer = txtSecurityAnswer.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(securityQuestion) ||
                string.IsNullOrWhiteSpace(securityAnswer) || string.IsNullOrWhiteSpace(newPassword))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "Swal.fire('Error!', 'All fields are required!', 'error');", true);
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM users WHERE email = @Email AND security_question = @SecurityQuestion AND security_answer = @SecurityAnswer";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@SecurityQuestion", securityQuestion);
                    cmd.Parameters.AddWithValue("@SecurityAnswer", securityAnswer);

                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();

                    if (count == 1)
                    {
                        // Update the password
                        string updateQuery = "UPDATE users SET password = @NewPassword WHERE email = @Email";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                        {
                            updateCmd.Parameters.AddWithValue("@NewPassword", newPassword);
                            updateCmd.Parameters.AddWithValue("@Email", email);

                            int rowsAffected = updateCmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                                    "Swal.fire('Success!', 'Password reset successful! Redirecting to login...', 'success').then(() => { window.location='loginuser.aspx'; });",
                                    true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                                    "Swal.fire('Error!', 'Failed to reset password. Try again.', 'error');", true);
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                            "Swal.fire('Error!', 'Invalid email, question, or answer.', 'error');", true);
                    }
                }
            }
        }

    }
}