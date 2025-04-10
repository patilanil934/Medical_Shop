using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.pdf;
using iTextSharp.text;
using OfficeOpenXml;

namespace MedicalShop.Adminpanel
{
    public partial class MonthlyReport : System.Web.UI.Page
    {
        int totalOrders = 0;
        decimal totalSales = 0;
        int totalCustomers = 0;
        string bestSellingProduct = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-01");
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            LoadReportData();
        }

        private void LoadReportData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string fromDate = txtFromDate.Text;
                string toDate = txtToDate.Text;

                // Total Orders
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM orders WHERE CAST(order_date AS DATE) BETWEEN @from AND @to", conn))
                {
                    cmd.Parameters.AddWithValue("@from", fromDate);
                    cmd.Parameters.AddWithValue("@to", toDate);
                    totalOrders = (int)cmd.ExecuteScalar();
                }

                // Total Sales
                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(total_amount), 0) FROM orders WHERE CAST(order_date AS DATE) BETWEEN @from AND @to", conn))
                {
                    cmd.Parameters.AddWithValue("@from", fromDate);
                    cmd.Parameters.AddWithValue("@to", toDate);
                    totalSales = Convert.ToDecimal(cmd.ExecuteScalar());
                }

                // Total Customers
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(DISTINCT user_id) FROM orders WHERE CAST(order_date AS DATE) BETWEEN @from AND @to", conn))
                {
                    cmd.Parameters.AddWithValue("@from", fromDate);
                    cmd.Parameters.AddWithValue("@to", toDate);
                    totalCustomers = (int)cmd.ExecuteScalar();
                }

                // Best Selling Product
                using (SqlCommand cmd = new SqlCommand(@"
                SELECT TOP 1 p.productname 
                FROM order_items oi
                JOIN products p ON oi.product_id = p.id
                JOIN orders o ON oi.order_id = o.id
                WHERE CAST(o.order_date AS DATE) BETWEEN @from AND @to
                GROUP BY p.productname
                ORDER BY SUM(oi.quantity) DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@from", fromDate);
                    cmd.Parameters.AddWithValue("@to", toDate);
                    object result = cmd.ExecuteScalar();
                    bestSellingProduct = result != null ? result.ToString() : "No Sales";
                }

                // Update UI
                lblTotalOrders.Text = totalOrders.ToString();
                lblTotalSales.Text = totalSales.ToString("C");
                lblTotalCustomers.Text = totalCustomers.ToString();
                lblBestSellingProduct.Text = bestSellingProduct;
            }
        }

        protected void btnExportPdf_Click(object sender, EventArgs e)
        {
            LoadReportData();

            Document doc = new Document();
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(doc, ms);
            doc.Open();

            doc.Add(new Paragraph("Monthly Sales Report"));
            doc.Add(new Paragraph("Date Range: " + txtFromDate.Text + " to " + txtToDate.Text));
            doc.Add(new Paragraph("Total Orders: " + totalOrders));
            doc.Add(new Paragraph("Total Sales: " + totalSales.ToString("C")));
            doc.Add(new Paragraph("Total Customers: " + totalCustomers));
            doc.Add(new Paragraph("Best Selling Product: " + bestSellingProduct));

            doc.Close();

            byte[] pdf = ms.ToArray();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=MonthlyReport.pdf");
            Response.BinaryWrite(pdf);
            Response.End();
        }

        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            LoadReportData();

            using (ExcelPackage excel = new ExcelPackage())
            {
                var ws = excel.Workbook.Worksheets.Add("Monthly Report");

                ws.Cells["A1"].Value = "Monthly Sales Report";
                ws.Cells["A2"].Value = "Date Range:";
                ws.Cells["B2"].Value = txtFromDate.Text + " to " + txtToDate.Text;
                ws.Cells["A4"].Value = "Total Orders";
                ws.Cells["B4"].Value = totalOrders;
                ws.Cells["A5"].Value = "Total Sales";
                ws.Cells["B5"].Value = totalSales.ToString("C");
                ws.Cells["A6"].Value = "Total Customers";
                ws.Cells["B6"].Value = totalCustomers;
                ws.Cells["A7"].Value = "Best Selling Product";
                ws.Cells["B7"].Value = bestSellingProduct;

                byte[] excelData = excel.GetAsByteArray();
                Response.Clear();
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment; filename=MonthlyReport.xlsx");
                Response.BinaryWrite(excelData);
                Response.End();
            }
        }
    }
}