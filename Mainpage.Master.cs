using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MedicalShop
{
    public partial class Mainpage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if logout is requested via URL query
                if (Request.QueryString["logout"] == "true")
                {
                    LogoutUser();
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            LogoutUser();
        }

        private void LogoutUser()
        {
            Session.Clear();  // Clears all session variables
            Session.Abandon();  // Destroys the session
            Response.Redirect("loginuser.aspx", true); // Redirect to login page
        }

    }
}