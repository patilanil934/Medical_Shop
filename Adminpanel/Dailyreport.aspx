<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Dailyreport.aspx.cs" Inherits="MedicalShop.Adminpanel.Dailyreport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

            <div class="mt-4 text-center">
                <asp:Button ID="btnExportPDF" runat="server" CssClass="btn btn-danger" Text="Download PDF" OnClick="ExportToPDF" />
                <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-success" Text="Download Excel" OnClick="ExportToExcel" />
            </div>
        </div>

</asp:Content>
