using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using OfficeOpenXml;
using OfficeOpenXml.Style;

namespace MedicalShop.Adminpanel
{
    public partial class Dailyreport : System.Web.UI.Page
    {
        protected int totalOrders;
        protected decimal totalSales;
        protected int totalCustomers;
        protected string bestSellingProduct;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReportData();
            }
        }

        private void LoadReportData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["connstr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Total Orders
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM orders WHERE CAST(order_date AS DATE) = CAST(GETDATE() AS DATE)", conn))
                {
                    totalOrders = (int)cmd.ExecuteScalar();
                }

                // Total Sales
                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(total_amount), 0) FROM orders WHERE CAST(order_date AS DATE) = CAST(GETDATE() AS DATE)", conn))
                {
                    totalSales = Convert.ToDecimal(cmd.ExecuteScalar());
                }

                // Total Customers
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(DISTINCT user_id) FROM orders WHERE CAST(order_date AS DATE) = CAST(GETDATE() AS DATE)", conn))
                {
                    totalCustomers = (int)cmd.ExecuteScalar();
                }

                // Best Selling Product
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT TOP 1 p.productname 
            FROM order_items oi
            JOIN products p ON oi.product_id = p.id
            JOIN orders o ON oi.order_id = o.id
            WHERE CAST(o.order_date AS DATE) = CAST(GETDATE() AS DATE)
            GROUP BY p.productname
            ORDER BY SUM(oi.quantity) DESC", conn))
                {
                    object result = cmd.ExecuteScalar();
                    bestSellingProduct = result != null ? result.ToString() : "No Sales";
                }

                // Debug Output
                Console.WriteLine($"Orders: {totalOrders}, Sales: {totalSales}, Customers: {totalCustomers}, Best Product: {bestSellingProduct}");

                // Update Labels
                lblTotalOrders.Text = totalOrders.ToString();
                lblTotalSales.Text = totalSales.ToString("0.00"); // Show decimal instead of ₹
                lblTotalCustomers.Text = totalCustomers.ToString();
                lblBestSellingProduct.Text = bestSellingProduct;
            }
        }


        protected void ExportToPDF(object sender, EventArgs e)
        {
            LoadReportData(); // <-- Reload data

            Document doc = new Document();
            MemoryStream ms = new MemoryStream();
            PdfWriter.GetInstance(doc, ms);
            doc.Open();

            doc.Add(new Paragraph("Daily Sales Report\n\n"));
            doc.Add(new Paragraph("Total Orders: " + totalOrders));
            doc.Add(new Paragraph("Total Sales: " + totalSales.ToString("C")));
            doc.Add(new Paragraph("Total Customers: " + totalCustomers));
            doc.Add(new Paragraph("Best Selling Product: " + bestSellingProduct));

            doc.Close();

            byte[] bytes = ms.ToArray();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=DailyReport.pdf");
            Response.BinaryWrite(bytes);
            Response.End();
        }

        protected void ExportToExcel(object sender, EventArgs e)
        {
            LoadReportData(); // <-- Reload data

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            using (ExcelPackage excel = new ExcelPackage())
            {
                ExcelWorksheet sheet = excel.Workbook.Worksheets.Add("Daily Report");
                sheet.Cells["A1"].Value = "Daily Sales Report";
                sheet.Cells["A1:E1"].Merge = true;
                sheet.Cells["A1"].Style.Font.Bold = true;

                sheet.Cells["A2"].Value = "Total Orders:";
                sheet.Cells["B2"].Value = totalOrders;
                sheet.Cells["A3"].Value = "Total Sales:";
                sheet.Cells["B3"].Value = totalSales.ToString("C");
                sheet.Cells["A4"].Value = "Total Customers:";
                sheet.Cells["B4"].Value = totalCustomers;
                sheet.Cells["A5"].Value = "Best Selling Product:";
                sheet.Cells["B5"].Value = bestSellingProduct;

                MemoryStream ms = new MemoryStream();
                excel.SaveAs(ms);
                byte[] bytes = ms.ToArray();

                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment; filename=DailyReport.xlsx");
                Response.BinaryWrite(bytes);
                Response.End();
            }
        }
    }
}