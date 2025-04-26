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
                LoadBrands();
            }
        }

        private void LoadBrands()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT id, brandname FROM brands ORDER BY brandname ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlFilterBrand.DataSource = reader;
                    ddlFilterBrand.DataTextField = "brandname";
                    ddlFilterBrand.DataValueField = "id";
                    ddlFilterBrand.DataBind();
                }
            }

            ddlFilterBrand.Items.Insert(0, new ListItem("All Brands", ""));
        }
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim();
            string brand = ddlFilterBrand.SelectedValue;
            string start = txtStartDate.Text.Trim();
            string end = txtEndDate.Text.Trim();

            LoadProducts(search, brand, start, end);
        }

        private void LoadProducts(string searchText = "", string brandId = "", string startDate = "", string endDate = "")
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT p.id, p.created_at, p.resized_image, b.brandname, p.productname, p.price 
            FROM products p  
            JOIN brands b ON p.brand_id = b.id  
            WHERE 1=1"; // Always true - useful for dynamic conditions

                List<SqlParameter> parameters = new List<SqlParameter>();

                if (!string.IsNullOrEmpty(searchText))
                {
                    query += " AND (p.productname LIKE @search OR b.brandname LIKE @search)";
                    parameters.Add(new SqlParameter("@search", "%" + searchText + "%"));
                }

                if (!string.IsNullOrEmpty(brandId))
                {
                    query += " AND p.brand_id = @brandId";
                    parameters.Add(new SqlParameter("@brandId", brandId));
                }

                if (!string.IsNullOrEmpty(startDate))
                {
                    query += " AND CAST(p.created_at AS DATE) >= @startDate";
                    parameters.Add(new SqlParameter("@startDate", startDate));
                }

                if (!string.IsNullOrEmpty(endDate))
                {
                    query += " AND CAST(p.created_at AS DATE) <= @endDate";
                    parameters.Add(new SqlParameter("@endDate", endDate));
                }

                query += " ORDER BY p.created_at DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddRange(parameters.ToArray());
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