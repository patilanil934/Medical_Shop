<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="MedicalShop.Invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .invoice-box {
            padding: 30px;
            border: 1px solid #eee;
            font-size: 16px;
        }
        .invoice-title {
            margin-bottom: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container invoice-box">
        <div class="invoice-title text-center">
            <h2>Medical Shop Invoice</h2>
            <hr />
        </div>

        <asp:Label ID="lblOrderCode" runat="server" CssClass="fw-bold" />
        <br />
        <asp:Label ID="lblCustomer" runat="server" CssClass="fw-bold" />
        <br />
        <asp:Label ID="lblphn" runat="server" CssClass="fw-bold" />
        <br />
        <asp:Label ID="lbladdress" runat="server" CssClass="fw-bold" />
        <br />
        <asp:Label ID="lblOrderDate" runat="server" CssClass="fw-bold" />
        <br /><br />

        <asp:GridView ID="gvItems" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField HeaderText="Medicine" DataField="ProductName" />
                <asp:BoundField HeaderText="Price" DataField="Price" />
                <asp:BoundField HeaderText="Quantity" DataField="Quantity" />
                <asp:BoundField HeaderText="Total" DataField="Total" />
            </Columns>
        </asp:GridView>

        <div class="text-end fw-bold">
            Total Amount: ₹<asp:Label ID="lblTotal" runat="server" />
        </div>

        <div class="text-center mt-4">
            <asp:Button ID="btnDownloadPDF" runat="server" CssClass="btn btn-success" Text="Download Invoice as PDF" OnClick="btnDownloadPDF_Click" />
        </div>
    </div>
</asp:Content>
