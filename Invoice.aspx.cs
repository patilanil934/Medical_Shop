using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Data;


namespace MedicalShop
{
    public partial class Invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["orderid"]))
                {
                    LoadInvoice();
                }
                else
                {
                    Response.Write("<script>alert('Order ID missing!');</script>");
                }
            }
        }

        private void LoadInvoice()
        {
            string orderId = Request.QueryString["orderid"];
            if (string.IsNullOrEmpty(orderId)) return;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connstr"].ConnectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"SELECT o.order_date, u.name, u.email, u.phone, u.address, o.total_amount
                                                 FROM orders o
                                                 JOIN users u ON o.user_id = u.id
                                                 WHERE o.id = @id", conn);
                cmd.Parameters.AddWithValue("@id", orderId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblOrderDate.Text = "Date: " + Convert.ToDateTime(reader["order_date"]).ToString("dd MMM yyyy");
                        lblCustomer.Text = "Customer: " + reader["name"].ToString() + " (" + reader["email"].ToString() + ")";
                        lblphn.Text = "Phone: " + reader["phone"].ToString(); // Display Phone
                        lbladdress.Text = "Address: " + reader["address"].ToString(); // Display Address
                        lblTotal.Text = reader["total_amount"].ToString();
                    }
                }

                // Fetch items
                SqlDataAdapter da = new SqlDataAdapter(@"SELECT p.productname AS ProductName, oi.price AS Price, oi.quantity AS Quantity, oi.total AS Total
                                         FROM order_items oi
                                         INNER JOIN products p ON oi.product_id = p.id
                                         WHERE oi.order_id = @id", conn);
                da.SelectCommand.Parameters.AddWithValue("@id", orderId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvItems.DataSource = dt;
                gvItems.DataBind();
            }
        }

        protected void btnDownloadPDF_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=invoice.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Document doc = new Document(PageSize.A4, 30f, 30f, 30f, 30f);
            PdfWriter.GetInstance(doc, Response.OutputStream);
            doc.Open();

            doc.Add(new Paragraph("Medical Shop Invoice"));
            doc.Add(new Paragraph("\n"));
            doc.Add(new Paragraph(lblOrderCode.Text));
            doc.Add(new Paragraph(lblOrderDate.Text));
            doc.Add(new Paragraph(lblCustomer.Text));
            doc.Add(new Paragraph(lblphn.Text)); // Add Phone to PDF
            doc.Add(new Paragraph(lbladdress.Text)); // Add Address to PDF
            doc.Add(new Paragraph("\n"));

            PdfPTable table = new PdfPTable(4);
            table.AddCell("Medicine");
            table.AddCell("Price");
            table.AddCell("Quantity");
            table.AddCell("Total");

            foreach (GridViewRow row in gvItems.Rows)
            {
                for (int i = 0; i < 4; i++)
                {
                    table.AddCell(row.Cells[i].Text);
                }
            }

            doc.Add(table);
            doc.Add(new Paragraph("\nTotal Amount: ₹" + lblTotal.Text));
            doc.Close();

            Response.Write(doc);
            Response.End();
        }
    }
}