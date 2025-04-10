<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="MonthlyReport.aspx.cs" Inherits="MedicalShop.Adminpanel.MonthlyReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

            <div class="row mt-4">
                <div class="col-md-6 text-start">
                    <asp:Button ID="btnExportPdf" runat="server" Text="Download PDF" CssClass="btn btn-danger" OnClick="btnExportPdf_Click" />
                </div>
                <div class="col-md-6 text-end">
                    <asp:Button ID="btnExportExcel" runat="server" Text="Download Excel" CssClass="btn btn-success" OnClick="btnExportExcel_Click" />
                </div>
            </div>
        </div>
</asp:Content>
