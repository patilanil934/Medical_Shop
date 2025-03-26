<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="MedicalShop.Adminpanel.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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



</asp:Content>
