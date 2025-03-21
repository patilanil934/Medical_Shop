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
    public partial class userprofile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    LoadUserData();
                }
                else
                {
                    Response.Redirect("loginuser.aspx"); // Redirect to login if not logged in
                }
            }
        }

        private void LoadUserData()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT name, email, phone, password, address, city, pin_code, security_question, security_answer FROM users WHERE id = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtName.Text = reader["name"].ToString();
                    txtEmail.Text = reader["email"].ToString();
                    txtPhone.Text = reader["phone"].ToString();
                    txtPassword.Text = reader["password"].ToString();
                    txtAddress.Text = reader["address"].ToString();
                    txtCity.Text = reader["city"].ToString();
                    txtPinCode.Text = reader["pin_code"].ToString();
                    ddlSecurityQuestion.SelectedValue = reader["security_question"].ToString();
                    txtSecurityAnswer.Text = reader["security_answer"].ToString();
                }
                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"UPDATE users SET 
                                name = @Name, phone = @Phone, password = @Password, 
                                address = @Address, city = @City, pin_code = @PinCode, 
                                security_question = @SecurityQuestion, security_answer = @SecurityAnswer 
                                WHERE id = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@City", txtCity.Text);
                cmd.Parameters.AddWithValue("@PinCode", txtPinCode.Text);
                cmd.Parameters.AddWithValue("@SecurityQuestion", ddlSecurityQuestion.SelectedValue);
                cmd.Parameters.AddWithValue("@SecurityAnswer", txtSecurityAnswer.Text);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            Response.Write("<script>alert('Profile updated successfully!');</script>");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            LoadUserData(); // Reload original data
        }
    }
}