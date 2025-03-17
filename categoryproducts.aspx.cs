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
    public partial class categoryproducts : System.Web.UI.Page
    {
        
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["category_id"] != null)
                    {
                        int categoryId;
                        if (int.TryParse(Request.QueryString["category_id"], out categoryId))
                        {
                            LoadProductsByCategory(categoryId);
                        }
                        else
                        {
                            Response.Redirect("categories.aspx"); // Redirect if invalid category ID
                        }
                    }
                    else
                    {
                        Response.Redirect("categories.aspx"); // Redirect if no category ID provided
                    }
                }
            }

            private void LoadProductsByCategory(int categoryId)
            {
                string query = "SELECT productname, description, price, resized_image FROM products WHERE category_id = @category_id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@category_id", categoryId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                    con.Close();
                }
            }
        }
}