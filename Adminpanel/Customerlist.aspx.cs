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
    public partial class Customerlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCustomers();
            }
        }

        private void LoadCustomers()
        {
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT id, name, email, phone, address FROM users ORDER BY created_at DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptCustomers.DataSource = dt;
                        rptCustomers.DataBind();
                    }
                }
            }
        }

        protected void rptCustomers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCustomer")
            {
                string customerId = e.CommandArgument.ToString();
                DeleteCustomer(customerId);
            }
        }

        private void DeleteCustomer(string customerId)
        {
            string connString = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM users WHERE id = @CustomerId";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CustomerId", customerId);
                    conn.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowsAffected > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "deleteSuccess", @"
                            Swal.fire({
                                title: 'Deleted!',
                                text: 'Customer has been deleted.',
                                icon: 'success'
                            }).then(() => {
                                window.location='Customerlist.aspx';
                            });
                        ", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "deleteFail", @"
                            Swal.fire({
                                title: 'Error!',
                                text: 'Failed to delete customer.',
                                icon: 'error'
                            });
                        ", true);
                    }
                }
            }
        }
    }
}