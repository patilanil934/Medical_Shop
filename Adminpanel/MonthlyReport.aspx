<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="MonthlyReport.aspx.cs" Inherits="MedicalShop.Adminpanel.MonthlyReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-4">
            <h2 class="text-center mb-4">Monthly Sales Report</h2>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label>From Date:</label>
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <label>To Date:</label>
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="col-md-4 d-flex align-items-end">
                    <asp:Button ID="btnGenerate" runat="server" Text="Generate Report" CssClass="btn btn-primary" OnClick="btnGenerate_Click" />
                </div>
            </div>

            <div class="row text-center border p-4 rounded shadow-sm bg-light">
                <div class="col-md-3">
                    <h5>Total Orders</h5>
                    <asp:Label ID="lblTotalOrders" runat="server" CssClass="fw-bold fs-4 text-primary"></asp:Label>
                </div>
                <div class="col-md-3">
                    <h5>Total Sales</h5>
                    <asp:Label ID="lblTotalSales" runat="server" CssClass="fw-bold fs-4 text-success"></asp:Label>
                </div>
                <div class="col-md-3">
                    <h5>Total Customers</h5>
                    <asp:Label ID="lblTotalCustomers" runat="server" CssClass="fw-bold fs-4 text-info"></asp:Label>
                </div>
                <div class="col-md-3">
                    <h5>Best Selling Product</h5>
                    <asp:Label ID="lblBestSellingProduct" runat="server" CssClass="fw-bold fs-4 text-danger"></asp:Label>
                </div>
            </div>

                <asp:HiddenField ID="hfTotalOrders" runat="server" />
                <asp:HiddenField ID="hfTotalSales" runat="server" />
                <asp:HiddenField ID="hfTotalCustomers" runat="server" />

                 <div class="row mt-4 justify-content-center">
            <div class="col-md-6">
                <h5 class="text-center mb-3">Report Summary</h5>
                <canvas id="monthlyChart"  style="max-width: 250px; max-height: 250px;" class="mx-auto"></canvas>
            </div>
        </div>

            <div class="row mt-4 text-center">
                <div class="col-md-6 text-center">
                    <asp:Button ID="btnExportPdf" runat="server" Text="Download PDF" CssClass="btn btn-danger" OnClick="btnExportPdf_Click" />
                </div>
                <div class="col-md-6 text-center">
                    <asp:Button ID="btnExportExcel" runat="server" Text="Download Excel" CssClass="btn btn-success" OnClick="btnExportExcel_Click" />
                </div>
            </div>
        

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const orders = parseInt(document.getElementById('<%= hfTotalOrders.ClientID %>').value) || 0;
        const sales = parseFloat(document.getElementById('<%= hfTotalSales.ClientID %>').value) || 0;
        const customers = parseInt(document.getElementById('<%= hfTotalCustomers.ClientID %>').value) || 0;

        const ctx = document.getElementById('monthlyChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Total Orders', 'Total Sales', 'Total Customers'],
                datasets: [{
                    label: 'Monthly Summary',
                    data: [orders, sales, customers],
                    backgroundColor: ['#007bff', '#28a745', '#17a2b8'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    });
    </script>
</asp:Content>
