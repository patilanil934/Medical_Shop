<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MedicalShop.Adminpanel.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
    <div class="col-md-3">
        <div class="card bg-light">
            <div class="card-icon">📂</div>
            <h5>Categories</h5>
            <p id="lblCategories" runat="server">0</p>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-light">
            <div class="card-icon">📦</div>
            <h5>Products</h5>
            <p id="lblProducts" runat="server">0</p>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-light">
            <div class="card-icon">🕒</div>
            <h5>Pending Orders</h5>
            <p id="lblPendingOrders" runat="server">0</p>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-light">
            <div class="card-icon">✅</div>
            <h5>Completed Orders</h5>
            <p id="lblCompletedOrders" runat="server">0</p>
        </div>
    </div>
</div>
<div class="container mt-5">
    <h4>Monthly Sales Overview</h4>
    <canvas id="salesChart" width="100%" height="40"></canvas>
    <asp:HiddenField ID="hfSalesData" runat="server" />
</div>

<script>
    window.onload = function () {
        const rawData = document.getElementById('<%= hfSalesData.ClientID %>').value;
        const sales = JSON.parse(rawData);

        const ctx = document.getElementById('salesChart').getContext('2d');
        const salesChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: sales.map(s => s.month),
                datasets: [{
                    label: 'Total Sales (₹)',
                    data: sales.map(s => s.total),
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
</script>


</asp:Content>
