using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace MedicalShop
{
    public partial class Addcategory : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            con.Close();
            SqlCommand cmd = new SqlCommand("insert into categories values (@catname,@catdescription)", con);
            cmd.Parameters.AddWithValue("@catname", txtCategoryName.Text);
            cmd.Parameters.AddWithValue("@catdescription", txtDescription.Text);
            con.Open();
            cmd.ExecuteNonQuery();

            txtCategoryName.Text = "";
            txtDescription.Text = "";

            this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Category added Successfully..!','','success');", true);
            

        }
    }
}