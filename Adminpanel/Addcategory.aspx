<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Addcategory.aspx.cs" Inherits="MedicalShop.Addcategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
            margin-top: 50px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="content2">
    <div class="dashboard-header">
        <h2>Add Category</h2>
    </div>
    <div class="container mt-4">
        <div class="form-container">
            <h4 class="text-center mb-3">New Category</h4>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

            <asp:Panel runat="server">
                <div class="mb-3">
                    <label for="txtCategoryName" class="form-label">Category Name</label>
                    <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" Placeholder="Enter category name"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label for="txtDescription" class="form-label">Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Placeholder="Enter category description" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
                <asp:Button ID="btnAddCategory" runat="server" CssClass="btn btn-primary w-100" Text="Add" OnClick="btnAddCategory_Click" />
            </asp:Panel>
        </div>
    </div>
</div>



</asp:Content>
