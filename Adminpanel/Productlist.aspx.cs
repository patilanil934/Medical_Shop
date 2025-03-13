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
    public partial class Productlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT p.id, p.created_at, p.resized_image, b.brandname, p.productname, p.price 
            FROM products p  
            JOIN brands b ON p.brand_id = b.id  
            ORDER BY p.created_at DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    rptProducts.DataSource = reader;
                    rptProducts.DataBind();
                }
            }
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string productId = (sender as System.Web.UI.WebControls.Button).CommandArgument;

            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM products WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", productId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "Swal.fire('Deleted!', 'Product has been deleted.', 'success');", true);
            }

            

            LoadProducts();
        }
    }
}