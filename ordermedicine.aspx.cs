using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class ordermedicine : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if it's a reorder request
                if (Request.QueryString["reorderid"] != null)
                {
                    int reorderId;
                    if (int.TryParse(Request.QueryString["reorderid"], out reorderId))
                    {
                        PrefillReorderForm(reorderId);
                    }
                }
            }
        }

        private void PrefillReorderForm(int id)
        {
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT * FROM prescription_order WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtName.Text = reader["name"].ToString();
                            txtPhone.Text = reader["phone"].ToString();
                            txtDoctor.Text = reader["doctor_name"].ToString();
                            txtDescription.Text = reader["description"].ToString();
                            txtAddress.Text = reader["address"].ToString();

                            // Refill reminder if available
                            if (reader["reminder_days"] != DBNull.Value)
                            {
                                rblReminder.SelectedValue = "Yes";
                                txtReminderDays.Text = reader["reminder_days"].ToString();
                                txtReminderDays.Visible = true;
                            }
                            else
                            {
                                rblReminder.SelectedValue = "No";
                                txtReminderDays.Visible = false;
                            }
                        }
                    }
                    conn.Close();
                }
            }
        }


        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                string name = txtName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string doctorName = txtDoctor.Text.Trim();
                string description = txtDescription.Text.Trim();
                string address = txtAddress.Text.Trim();
                string prescriptionImage = "";
                int? reminderDays = null;

                if (rblReminder.SelectedValue == "Yes")
                {
                    if (int.TryParse(txtReminderDays.Text.Trim(), out int days))
                    {
                        reminderDays = days;
                    }
                }

                if (fuPrescription.HasFile)
                {
                    string uploadFolder = Server.MapPath("~/uploads/prescriptions/");
                    if (!Directory.Exists(uploadFolder))
                        Directory.CreateDirectory(uploadFolder);

                    string fileName = DateTime.Now.Ticks + Path.GetExtension(fuPrescription.FileName);
                    prescriptionImage = "uploads/prescriptions/" + fileName;
                    fuPrescription.SaveAs(Path.Combine(uploadFolder, fileName));
                }
                else
                {
                    ShowSweetAlert("Error", "Please upload a prescription image.", "error");
                    return;
                }

                string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO prescription_order 
        (name, phone, doctor_name, prescription_image, description, address, status, admin_note, total_amount, reminder_days, created_at, user_id) 
        VALUES 
        (@name, @phone, @doctorName, @prescriptionImage, @description, @address, @status, @adminNote, @totalAmount, @reminderDays, GETDATE(), @userId)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@doctorName", doctorName);
                        cmd.Parameters.AddWithValue("@prescriptionImage", prescriptionImage);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@address", address);
                        cmd.Parameters.AddWithValue("@status", "Pending");
                        cmd.Parameters.AddWithValue("@adminNote", DBNull.Value);
                        cmd.Parameters.AddWithValue("@totalAmount", DBNull.Value);
                        cmd.Parameters.AddWithValue("@reminderDays", (object)reminderDays ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@userId", Session["UserID"]); // 👈 add this line to store user ID

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }


                ShowSweetAlert("Success", "Order placed successfully!", "success");
                ClearFields();
            }
            else
            {
                string script = "Swal.fire({ " +
                                "title: 'Login Required', " +
                                "text: 'You must be logged in to place an order.', " +
                                "icon: 'warning', " +
                                "confirmButtonText: 'Login Now' " +
                                "}).then((result) => { if (result.isConfirmed) { window.location = 'loginuser.aspx'; }});";

                ClientScript.RegisterStartupScript(this.GetType(), "LoginAlert", script, true);
            }
        }


        private void ShowSweetAlert(string title, string message, string icon)
        {
            string script = $"Swal.fire('{title}', '{message}', '{icon}');";
            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
        }

        private void ClearFields()
        {
            txtName.Text = "";
            txtPhone.Text = "";
            txtDoctor.Text = "";
            txtDescription.Text = "";
            txtAddress.Text = "";
        }
    }
   
}
