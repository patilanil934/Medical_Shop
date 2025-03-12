using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class Brandlist : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBrands();
            }
        }

        private void LoadBrands()
        {
            try
            {
                con.Open();
                string query = "SELECT id, brandname FROM brands";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvBrands.DataSource = dt;
                gvBrands.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }

        // Handle Delete button click
        protected void gvBrands_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteBrand")
            {
                int brandId = Convert.ToInt32(e.CommandArgument);
                DeleteBrand(brandId);
                LoadBrands(); // Refresh GridView
            }
        }

        private void DeleteBrand(int id)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM brands WHERE id = @id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }

        // Enable edit mode
        protected void gvBrands_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBrands.EditIndex = e.NewEditIndex;
            LoadBrands();
        }

        // Update brand name
        protected void gvBrands_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int brandId = Convert.ToInt32(gvBrands.DataKeys[e.RowIndex].Value);
            TextBox txtEditBrandName = (TextBox)gvBrands.Rows[e.RowIndex].FindControl("txtEditBrandName");

            if (txtEditBrandName != null)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE brands SET brandname = @brandname WHERE id = @id", con);
                cmd.Parameters.AddWithValue("@brandname", txtEditBrandName.Text.Trim());
                cmd.Parameters.AddWithValue("@id", brandId);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            gvBrands.EditIndex = -1;
            LoadBrands();
        }

        // Cancel edit mode
        protected void gvBrands_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBrands.EditIndex = -1;
            LoadBrands();
        }
    }
}