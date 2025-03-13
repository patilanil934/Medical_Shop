using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop.Adminpanel
{
    public partial class Editproduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBrands();
                LoadCategories();

                if (Request.QueryString["id"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadProductDetails(productId);
                }
                else
                {
                    Response.Redirect("ProductList.aspx");
                    return;
                }
            }
        }

        private void LoadProductDetails(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM products WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", productId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hfProductId.Value = reader["id"].ToString();
                        txtProductName.Text = reader["productname"].ToString();
                        txtDescription.Text = reader["description"].ToString();
                        txtPrice.Text = reader["price"].ToString();
                        txtStock.Text = reader["stock"].ToString();

                        if (!DBNull.Value.Equals(reader["expiry_date"]))
                        {
                            txtExpiryDate.Text = Convert.ToDateTime(reader["expiry_date"]).ToString("yyyy-MM-dd");
                        }

                        // Set Brand & Category
                        if (ddlBrand.Items.FindByValue(reader["brand_id"].ToString()) != null)
                        {
                            ddlBrand.SelectedValue = reader["brand_id"].ToString();
                        }

                        if (ddlCategory.Items.FindByValue(reader["category_id"].ToString()) != null)
                        {
                            ddlCategory.SelectedValue = reader["category_id"].ToString();
                        }

                        // Fix image display
                        string imageName = reader["image"] != DBNull.Value ? reader["image"].ToString() : "";
                        if (!string.IsNullOrEmpty(imageName))
                        {
                            imgCurrent.ImageUrl = ResolveUrl("~/uploads/products/" + imageName);
                            imgCurrent.Visible = true;
                        }
                        else
                        {
                            imgCurrent.Visible = false;
                        }
                    }

                    else
                    {
                        Response.Redirect("ProductList.aspx");
                        return;
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32(hfProductId.Value);
            string productName = txtProductName.Text.Trim();
            string brandId = ddlBrand.SelectedValue;
            string categoryId = ddlCategory.SelectedValue;
            string description = txtDescription.Text.Trim();
            decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
            int stock = Convert.ToInt32(txtStock.Text.Trim());
            DateTime? expiryDate = string.IsNullOrEmpty(txtExpiryDate.Text) ? (DateTime?)null : Convert.ToDateTime(txtExpiryDate.Text.Trim());

            string newImageName = "";
            string oldImagePath = "";

            // Prevent null reference error
            if (!string.IsNullOrEmpty(imgCurrent.ImageUrl))
            {
                oldImagePath = Server.MapPath(imgCurrent.ImageUrl);
            }

            // Image Upload Handling
            if (fuImage.HasFile)
            {
                string ext = Path.GetExtension(fuImage.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                {
                    newImageName = Guid.NewGuid().ToString() + ext;
                    string newImagePath = Server.MapPath("~/uploads/products/") + newImageName;
                    fuImage.SaveAs(newImagePath);

                    // Delete old image if new image is uploaded
                    if (!string.IsNullOrEmpty(oldImagePath) && File.Exists(oldImagePath))
                    {
                        File.Delete(oldImagePath);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "Swal.fire('Error!', 'Only JPG, JPEG, and PNG files are allowed.', 'error');", true);
                    return;
                }
            }

            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE products SET productname=@name, brand_id=@brand, category_id=@category, description=@description, " +
                               "price=@price, stock=@stock, expiry_date=@expiry_date" +
                               (newImageName != "" ? ", image=@image" : "") + " WHERE id=@id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@name", productName);
                    cmd.Parameters.AddWithValue("@brand", brandId);
                    cmd.Parameters.AddWithValue("@category", categoryId);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@stock", stock);

                    if (expiryDate.HasValue)
                    {
                        cmd.Parameters.AddWithValue("@expiry_date", expiryDate);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@expiry_date", DBNull.Value);
                    }

                    cmd.Parameters.AddWithValue("@id", productId);

                    if (newImageName != "")
                    {
                        cmd.Parameters.AddWithValue("@image", newImageName);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                "Swal.fire('Updated!', 'Product has been updated successfully.', 'success').then(() => { window.location='ProductList.aspx'; });", true);
        }

        private void LoadBrands()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT id, brandname FROM brands ORDER BY brandname";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlBrand.DataSource = reader;
                    ddlBrand.DataTextField = "brandname";
                    ddlBrand.DataValueField = "id";
                    ddlBrand.DataBind();
                }
            }
            ddlBrand.Items.Insert(0, new ListItem("-- Select Brand --", ""));
        }

        private void LoadCategories()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT id, catname FROM categories ORDER BY catname";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    ddlCategory.DataSource = reader;
                    ddlCategory.DataTextField = "catname"; // Fixed column name
                    ddlCategory.DataValueField = "id";
                    ddlCategory.DataBind();
                }
            }
            ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", ""));
        }
    }
}