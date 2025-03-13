using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace MedicalShop
{
    public partial class Addproduct : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBrands();
                LoadCategories();
            }

        }

        private void LoadBrands()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT id, brandname FROM brands", con);
            ddlBrand.DataSource = cmd.ExecuteReader();
            ddlBrand.DataTextField = "brandname";
            ddlBrand.DataValueField = "id";
            ddlBrand.DataBind();
            con.Close();
        }

        private void LoadCategories()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT id, catname FROM categories", con);
            ddlCategory.DataSource = cmd.ExecuteReader();
            ddlCategory.DataTextField = "catname";
            ddlCategory.DataValueField = "id";
            ddlCategory.DataBind();
            con.Close();
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            string productName = txtProductName.Text.Trim();
            int brandId = Convert.ToInt32(ddlBrand.SelectedValue);
            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            string description = txtDescription.Text.Trim();
            decimal price = Convert.ToDecimal(txtPrice.Text);
            int stock = Convert.ToInt32(txtStock.Text);
            DateTime expiryDate = Convert.ToDateTime(txtExpiryDate.Text);

            string originalImagePath = "";
            string resizedImagePath = "";

            if (fuImage.HasFile)
            {
                string uploadPath = Server.MapPath("~/uploads/products/");
                string resizedPath = Server.MapPath("~/uploads/resizeimages/");

                if (!Directory.Exists(uploadPath)) Directory.CreateDirectory(uploadPath);
                if (!Directory.Exists(resizedPath)) Directory.CreateDirectory(resizedPath);

                // Generate a short, unique file name
                string fileExtension = Path.GetExtension(fuImage.FileName);
                string uniqueFileName = "P" + DateTime.Now.Ticks.ToString().Substring(8) + fileExtension;

                string savePath = Path.Combine(uploadPath, uniqueFileName);
                string resizeSavePath = Path.Combine(resizedPath, "Resized_" + uniqueFileName);

                fuImage.SaveAs(savePath);
                originalImagePath = "~/uploads/products/" + uniqueFileName;

                // Resize and save the image
                ResizeImage(fuImage.PostedFile.InputStream, resizeSavePath, 800, 600);
                resizedImagePath = "~/uploads/resizeimages/Resized_" + uniqueFileName;
            }


            con.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO products (productname, brand_id, category_id, description, price, stock, expiry_date, image, resized_image) " +
                                            "VALUES (@name, @brand_id, @category_id, @description, @price, @stock, @expiry_date, @image_path, @resized_image_path)", con);
            cmd.Parameters.AddWithValue("@name", productName);
            cmd.Parameters.AddWithValue("@brand_id", brandId);
            cmd.Parameters.AddWithValue("@category_id", categoryId);
            cmd.Parameters.AddWithValue("@description", description);
            cmd.Parameters.AddWithValue("@price", price);
            cmd.Parameters.AddWithValue("@stock", stock);
            cmd.Parameters.AddWithValue("@expiry_date", expiryDate);
            cmd.Parameters.AddWithValue("@image_path", originalImagePath);
            cmd.Parameters.AddWithValue("@resized_image_path", resizedImagePath);
            cmd.ExecuteNonQuery();
            con.Close();

            txtProductName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtStock.Text = "";
            txtExpiryDate.Text = "";


            ClientScript.RegisterStartupScript(this.GetType(), "alert",
    "Swal.fire({title: 'Success!', text: 'Product added successfully!', icon: 'success'});", true);

        }

        private void ResizeImage(Stream stream, string outputPath, int width, int height)
        {
            using (Bitmap originalImage = new Bitmap(stream))
            {
                using (Bitmap resizedImage = new Bitmap(width, height, PixelFormat.Format24bppRgb))
                {
                    using (Graphics graphics = Graphics.FromImage(resizedImage))
                    {
                        graphics.SmoothingMode = SmoothingMode.AntiAlias;
                        graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
                        graphics.CompositingQuality = CompositingQuality.HighSpeed;
                        graphics.CompositingMode = CompositingMode.SourceCopy;
                        graphics.DrawImage(originalImage, 0, 0, width, height);
                        resizedImage.Save(outputPath, ImageFormat.Jpeg);
                    }
                }
            }
        }
    }
}