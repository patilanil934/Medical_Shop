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

                if (fuPrescription.HasFile)
                {
                    string uploadFolder = Server.MapPath("~/uploads/prescriptions/");
                    if (!Directory.Exists(uploadFolder))
                    {
                        Directory.CreateDirectory(uploadFolder);
                    }

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
                                      (name, phone, doctor_name, prescription_image, description, address, status, admin_note, total_amount) 
                                      VALUES 
                                      (@name, @phone, @doctorName, @prescriptionImage, @description, @address, @status, @adminNote, @totalAmount)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@doctorName", doctorName);
                        cmd.Parameters.AddWithValue("@prescriptionImage", prescriptionImage);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@address", address);

                        // Default Values for New Columns
                        cmd.Parameters.AddWithValue("@status", "Pending");
                        cmd.Parameters.AddWithValue("@adminNote", DBNull.Value);
                        cmd.Parameters.AddWithValue("@totalAmount", DBNull.Value);

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
