<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="forgotpassword.aspx.cs" Inherits="MedicalShop.forgotpassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex justify-content-center align-items-center " style=" margin-top:20px; margin-bottom:20px;">
    <div class="card shadow p-4" style="width: 100%; max-width: 400px;">
        <h3 class="text-center mb-4 fw-bold">Reset Your Password</h3>

        <div class="mb-3">
            <label for="txtEmail" class="form-label fw-bold">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
        </div>

        <div class="mb-3">
    <label for="ddlSecurityQuestion" class="form-label fw-bold">Security Question</label>
    <asp:DropDownList ID="ddlSecurityQuestion" runat="server" CssClass="form-control">
        <asp:ListItem Text="Select a question" Value="" />
        <asp:ListItem Text="What is your pet's name?" Value="1" />
        <asp:ListItem Text="What is your mother's maiden name?" Value="2" />
        <asp:ListItem Text="What is your favorite color?" Value="3" />
    </asp:DropDownList>
</div>

<div class="mb-3">
    <label for="txtSecurityAnswer" class="form-label fw-bold">Security Answer</label>
    <asp:TextBox ID="txtSecurityAnswer" runat="server" CssClass="form-control" placeholder="Enter your answer"></asp:TextBox>
</div>

        <div class="mb-3">
            <label for="txtNewPassword" class="form-label fw-bold">New Password</label>
            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter new password"></asp:TextBox>
        </div>

        <div class="mb-4">
            <label for="txtConfirmPassword" class="form-label fw-bold">Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm new password"></asp:TextBox>
        </div>

        <div class="d-grid">
            <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-primary btn-sm" Text="Reset Password" OnClick="btnResetPassword_Click" />
        </div>

        <div class="mt-3 text-center">
            <a href="loginuser.aspx" class="text-decoration-none">Back to Login</a>
        </div>
    </div>
</div>


</asp:Content>
