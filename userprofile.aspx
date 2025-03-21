<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="userprofile.aspx.cs" Inherits="MedicalShop.userprofile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       /* Profile Container */
.profile-container {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    max-width: 500px;
    margin: 80px auto 50px; /* Pushes it down from navbar and prevents footer overlap */
}

/* Page Background */
body {
    background-color: #f8f9fa;
}

/* Form Elements */
.form-label {
    font-weight: 600;
}

/* Buttons */
.btn {
    padding: 10px;
    font-size: 16px;
    border-radius: 5px;
}

/* Ensure proper spacing on small screens */
@media (max-width: 768px) {
    .profile-container {
        padding: 20px;
        max-width: 90%;
    }
}

</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   <div class="container">
    <div class="profile-container">
        <h4 class="text-center text-dark"><b>My Profile</b></h4>

        <div class="mb-3">
            <label class="form-label"><b>Name</b></label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Email</b></label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Phone Number</b></label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Password</b></label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Address</b></label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label class="form-label"><b>City</b></label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-6">
                <label class="form-label"><b>Pin Code</b></label>
                <asp:TextBox ID="txtPinCode" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Security Question</b></label>
            <asp:DropDownList ID="ddlSecurityQuestion" runat="server" CssClass="form-control">
                <asp:ListItem Text="Select a security question" Value=""></asp:ListItem>
                <asp:ListItem Text="What is your pet's name?" Value="1"></asp:ListItem>
                <asp:ListItem Text="What is your mother's name?" Value="2"></asp:ListItem>
                <asp:ListItem Text="What is your favorite game?" Value="3"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Security Answer</b></label>
            <asp:TextBox ID="txtSecurityAnswer" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="d-flex justify-content-between">
            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" OnClick="btnCancel_Click" />
        </div>
    </div>
</div>



</asp:Content>
