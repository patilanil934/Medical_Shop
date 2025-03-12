using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class AddBrand : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddBrand_Click(object sender, EventArgs e)
        {

            con.Close();
            SqlCommand cmd = new SqlCommand("insert into brands values (@brandname)", con);
            cmd.Parameters.AddWithValue("@brandname", txtBrandName.Text);
            con.Open();
            cmd.ExecuteNonQuery();

            txtBrandName.Text = "";
           

            this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Brand added Successfully..!','','success');", true);

        }
    }
}