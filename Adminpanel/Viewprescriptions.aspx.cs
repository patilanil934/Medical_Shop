using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net;

namespace MedicalShop.Adminpanel
{
    public partial class PrescriptionOrders : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindGrid(txtSearchName.Text.Trim(), txtSearchPhone.Text.Trim(), ddlStatusFilter.SelectedValue);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearchName.Text = "";
            txtSearchPhone.Text = "";
            ddlStatusFilter.SelectedIndex = 0;
            BindGrid();
        }

        private void BindGrid(string name = "", string phone = "", string status = "")
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM prescription_order WHERE 1=1";

                if (!string.IsNullOrEmpty(name))
                {
                    query += " AND name LIKE @name";
                }
                if (!string.IsNullOrEmpty(phone))
                {
                    query += " AND phone LIKE @phone";
                }
                if (!string.IsNullOrEmpty(status))
                {
                    query += " AND status = @status";
                }

                query += " ORDER BY created_at DESC";

                SqlCommand cmd = new SqlCommand(query, conn);

                if (!string.IsNullOrEmpty(name))
                {
                    cmd.Parameters.AddWithValue("@name", "%" + name + "%");
                }
                if (!string.IsNullOrEmpty(phone))
                {
                    cmd.Parameters.AddWithValue("@phone", "%" + phone + "%");
                }
                if (!string.IsNullOrEmpty(status))
                {
                    cmd.Parameters.AddWithValue("@status", status);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewMessage")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM prescription_order WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        hfOrderId.Value = reader["id"].ToString();
                        lblName.Text = reader["name"].ToString();
                        lblPhone.Text = reader["phone"].ToString();
                        lblDoctor.Text = reader["doctor_name"].ToString();
                        lblDescription.Text = reader["description"].ToString();
                        lblAddress.Text = reader["address"].ToString();
                        imgPrescription.ImageUrl = "~/" + reader["prescription_image"].ToString();

                        ddlStatus.SelectedValue = reader["status"].ToString();
                        txtAmount.Text = reader["total_amount"].ToString();
                        txtNote.Text = reader["admin_note"].ToString();
                    }
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#prescriptionModal').modal('show');", true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string userEmail = ""; // Declare the variable to hold the user's email
            string name = "", phone = "", doctor = "", description = "", address = "", status = "", adminNote = "", totalAmount = "0.00";

            // Fetch the email and other order details
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Step 1: Get existing user/order info, including email
                string fetchQuery = @"
            SELECT u.email, p.name, p.phone, p.doctor_name, p.description, p.address, p.status, p.total_amount, p.admin_note
            FROM prescription_order p
            INNER JOIN users u ON p.user_id = u.id
            WHERE p.id = @id";

                SqlCommand fetchCmd = new SqlCommand(fetchQuery, conn);
                fetchCmd.Parameters.AddWithValue("@id", hfOrderId.Value);
                conn.Open();
                SqlDataReader reader = fetchCmd.ExecuteReader();
                if (reader.Read())
                {
                    userEmail = reader["email"].ToString();
                    name = reader["name"].ToString();
                    phone = reader["phone"].ToString();
                    doctor = reader["doctor_name"].ToString();
                    description = reader["description"].ToString();
                    address = reader["address"].ToString();
                    status = ddlStatus.SelectedValue;
                    totalAmount = string.IsNullOrEmpty(txtAmount.Text) ? "0.00" : txtAmount.Text;
                    adminNote = txtNote.Text.Trim();
                }
                reader.Close();

                // Step 2: Update the order
                string updateQuery = "UPDATE prescription_order SET status = @status, total_amount = @amount, admin_note = @note WHERE id = @id";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                updateCmd.Parameters.AddWithValue("@amount", string.IsNullOrEmpty(txtAmount.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtAmount.Text));
                updateCmd.Parameters.AddWithValue("@note", txtNote.Text.Trim());
                updateCmd.Parameters.AddWithValue("@id", hfOrderId.Value);
                updateCmd.ExecuteNonQuery();
            }

            // Step 3: Send the email to the user
            try
            {
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;
                string smtpUser = "patilanil9398@gmail.com"; // Replace with your email
                string smtpPass = "vqzk roio gema iatd";    // Replace with your app password

                // Create the email message
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(smtpUser, "Medical Shop");
                mail.To.Add(userEmail);
                mail.Subject = "Your Prescription Order Update - Medical Shop";
                mail.IsBodyHtml = true;

                // Construct the email body
                mail.Body = $@"
            <h3>Dear {name},</h3>
            <p>Your prescription order has been updated. Please find the details below:</p>
            <table border='1' cellpadding='8' cellspacing='0'>
                <tr><td><strong>Name:</strong></td><td>{name}</td></tr>
                <tr><td><strong>Phone:</strong></td><td>{phone}</td></tr>
                <tr><td><strong>Doctor:</strong></td><td>{doctor}</td></tr>
                <tr><td><strong>Description:</strong></td><td>{description}</td></tr>
                <tr><td><strong>Address:</strong></td><td>{address}</td></tr>
                <tr><td><strong>Status:</strong></td><td>{status}</td></tr>
                <tr><td><strong>Total Amount:</strong></td><td>₹{totalAmount}</td></tr>
                <tr><td><strong>Admin Note:</strong></td><td>{adminNote}</td></tr>
            </table>
            <br/><p>Thank you for choosing Medical Shop.</p>";

                // Send the email using SMTP client
                SmtpClient smtp = new SmtpClient(smtpServer, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpUser, smtpPass);
                smtp.EnableSsl = true;
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Email sending failed: " + ex.Message);
            }

            // Close the modal and refresh the grid
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#prescriptionModal').modal('hide');", true);
            BindGrid();
        }

    }
}