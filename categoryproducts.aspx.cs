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
                string query = "SELECT id, productname, description, price, resized_image FROM products WHERE category_id = @category_id";

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

        protected void btnAddToCart_Command(object sender, CommandEventArgs e)
        {
            Button btn = (Button)sender;

            if (!string.IsNullOrEmpty(btn.CommandArgument) && int.TryParse(btn.CommandArgument, out int productId))
            {
                string query = "SELECT productname, price FROM products WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@id", SqlDbType.Int).Value = productId; // ✅ Correct way to add parameter

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // ✅ Using GetX() methods instead of Convert.ToX()
                            string productName = reader.GetString(reader.GetOrdinal("productname"));
                            decimal price = reader.GetDecimal(reader.GetOrdinal("price"));

                            // ✅ Initialize cart if empty
                            DataTable cart = Session["cart"] as DataTable ?? new DataTable();
                            if (cart.Columns.Count == 0)
                            {
                                cart.Columns.Add("product_id", typeof(int));
                                cart.Columns.Add("productname", typeof(string));
                                cart.Columns.Add("price", typeof(decimal));
                                cart.Columns.Add("quantity", typeof(int));
                                cart.Columns.Add("total", typeof(decimal));
                            }

                            // ✅ Check if product already exists in cart
                            DataRow existingRow = cart.AsEnumerable().FirstOrDefault(r => (int)r["product_id"] == productId);
                            if (existingRow != null)
                            {
                                // If product exists, increase quantity and update total
                                int newQuantity = Convert.ToInt32(existingRow["quantity"]) + 1;
                                existingRow["quantity"] = newQuantity;
                                existingRow["total"] = newQuantity * price;
                            }
                            else
                            {
                                // If product does not exist, add new row
                                DataRow row = cart.NewRow();
                                row["product_id"] = productId;
                                row["productname"] = productName;
                                row["price"] = price;
                                row["quantity"] = 1;
                                row["total"] = price;
                                cart.Rows.Add(row);
                            }

                            // ✅ Save cart back to session
                            Session["cart"] = cart;

                            // ✅ Show success message using SweetAlert
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "Swal.fire('Success', 'Product added to cart!', 'success');", true);

                        }
                        else
                        {
                            // Product not found
                            Response.Write("<script>Swal.fire('Error', 'Product not found!', 'error');</script>");
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>Swal.fire('Error', 'Database error: {ex.Message}', 'error');</script>");
                    }
                    finally
                    {
                        con.Close(); // ✅ Ensures connection is closed
                    }
                }
            }
            else
            {
                Response.Write("<script>Swal.fire('Error', 'Invalid Product ID', 'error');</script>");
            }
        }
    }
}