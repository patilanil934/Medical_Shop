using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class prescriptionorders : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPrescriptionOrders();
            }
        }

        private void LoadPrescriptionOrders()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM prescription_order WHERE user_id = @user_id ORDER BY created_at DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@user_id", Session["UserID"]);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptPrescriptionOrders.DataSource = dt;
                        rptPrescriptionOrders.DataBind();
                    }
                    else
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "No prescription orders found.";
                    }
                }
            }
        }
    }
}