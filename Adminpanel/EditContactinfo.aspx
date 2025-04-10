<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="EditContactinfo.aspx.cs" Inherits="MedicalShop.Adminpanel.EditContactinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <h2 class="text-center mb-4">Update Contact Information</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="txtAddress" class="form-label">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Address" />
                </div>
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email" TextMode="Email" />
                </div>
                <div class="mb-3">
                    <label for="txtPhone" class="form-label">Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter Phone" />
                </div>
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
            </div>
        </div>
    </div>
</asp:Content>
