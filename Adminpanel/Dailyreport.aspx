<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Dailyreport.aspx.cs" Inherits="MedicalShop.Adminpanel.Dailyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
            <h2 class="text-center">Daily Sales Report</h2>
    <div class="row">
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>Total Orders</h5>
                <asp:Label ID="lblTotalOrders" runat="server" CssClass="fw-bold fs-4"></asp:Label>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>Total Sales</h5>
                <asp:Label ID="lblTotalSales" runat="server" CssClass="fw-bold fs-4"></asp:Label>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>Total Customers</h5>
                <asp:Label ID="lblTotalCustomers" runat="server" CssClass="fw-bold fs-4"></asp:Label>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-center">
                <h5>Best Selling Product</h5>
                <asp:Label ID="lblBestSellingProduct" runat="server" CssClass="fw-bold fs-4"></asp:Label>
            </div>
        </div>
    </div>

    <!-- Hidden Fields to store values -->
    <asp:HiddenField ID="hfTotalOrders" runat="server" Value="<%= totalOrders %>" />
    <asp:HiddenField ID="hfTotalSales" runat="server" Value="<%= totalSales %>" />
    <asp:HiddenField ID="hfTotalCustomers" runat="server" Value="<%= totalCustomers %>" />

    <!-- Pie Chart/Doughnut -->
    <div class="text-center mb-5">
        <h5>Today's Summary Overview</h5>
        <canvas id="reportChart" style="max-width: 250px; max-height: 250px;" class="mx-auto"></canvas>
    </div>

    <div class="mt-4 text-center">
        <asp:Button ID="btnExportPDF" runat="server" CssClass="btn btn-danger" Text="Download PDF" OnClick="ExportToPDF" />
        <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-success" Text="Download Excel" OnClick="ExportToExcel" />
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    var totalOrders = document.getElementById('<%= hfTotalOrders.ClientID %>').value;
    var totalSales = document.getElementById('<%= hfTotalSales.ClientID %>').value;
    var totalCustomers = document.getElementById('<%= hfTotalCustomers.ClientID %>').value;

    var ctx = document.getElementById('reportChart').getContext('2d');
    var reportChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Total Orders', 'Total Sales', 'Total Customers'],
            datasets: [{
                label: 'Daily Report',
                data: [totalOrders, totalSales, totalCustomers],
                backgroundColor: ['#FF6347', '#4CAF50', '#FFD700'],
                borderColor: ['#FF6347', '#4CAF50', '#FFD700'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    callbacks: {
                        label: function (tooltipItem) {
                            return tooltipItem.label + ': ' + tooltipItem.raw;
                        }
                    }
                }
            },
            layout: {
                padding: {
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 10
                }
            }
        }
    });
</script>
       

</asp:Content>
