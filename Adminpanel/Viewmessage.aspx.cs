using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace MedicalShop.Adminpanel
{
    public partial class Viewmessage : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMessages();
            }
        }

        private void BindMessages()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT id, name, email, submitted_at FROM contactmsg ORDER BY submitted_at DESC", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                GridView1.DataSource = dr;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewMessage")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT message FROM contactmsg WHERE id = @id", con);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblFullMessage.Text = reader["message"].ToString().Replace("\n", "<br/>"); // To preserve line breaks
                    }
                }

                // Show Bootstrap 5 Modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "var myModal = new bootstrap.Modal(document.getElementById('messageModal')); myModal.show();", true);
            }

            else if (e.CommandName == "DeleteMessage")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM contactmsg WHERE id = @id", con);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindMessages(); // Refresh grid
            }
        }
    }
}