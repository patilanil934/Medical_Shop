using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE prescription_order SET status = @status, total_amount = @amount, admin_note = @note WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@amount", string.IsNullOrEmpty(txtAmount.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtAmount.Text));
                cmd.Parameters.AddWithValue("@note", txtNote.Text.Trim());
                cmd.Parameters.AddWithValue("@id", hfOrderId.Value);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "$('#prescriptionModal').modal('hide');", true);
            BindGrid();
        }
    }
}