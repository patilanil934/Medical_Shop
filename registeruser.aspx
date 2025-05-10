<%@ Page Title="Register" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="registeruser.aspx.cs" Inherits="MedicalShop.registeruser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
        /* Center form properly */
        .register-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 50px auto; /* Centered without affecting master page */
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="register-container">
        <h4 class="text-center text-dark"><b>Welcome To Medical Shop</b></h4>

        <asp:ScriptManager runat="server"></asp:ScriptManager>

        <div class="mb-3">
            <label class="form-label"><b>Enter Your Name</b></label>
            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" Placeholder="Enter First Name"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Email</b></label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Placeholder="Enter Email"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Phone Number</b></label>
            <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" Placeholder="Enter Phone Number"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Password</b></label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter Password"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label"><b>Address</b></label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Enter Address"></asp:TextBox>
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

        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary" Text="Join Now" Onclick="btnRegister_Click" />
    </div>

    <script>
    document.getElementById('<%= btnRegister.ClientID %>').addEventListener("click", function (e) {
        let isValid = true;

        // Validate First Name
        const firstName = document.getElementById('<%= txtFirstName.ClientID %>').value.trim();
        if (firstName.length < 3) {
            alert("First name must be at least 3 characters.");
            isValid = false;
        }

        // Validate Email for @gmail.com
        const email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
        const emailPattern = /^[a-zA-Z0-9._-]+@gmail\.com$/;
        if (!emailPattern.test(email)) {
            alert("Please enter a valid Gmail address.");
            isValid = false;
        }

        // Validate Phone Number (10 digits)
        const phoneNumber = document.getElementById('<%= txtPhoneNumber.ClientID %>').value.trim();
        if (!/^\d{10}$/.test(phoneNumber)) {
            alert("Phone number must be exactly 10 digits.");
            isValid = false;
        }

        // Validate Password (minimum 6 characters)
        const password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
        if (password.length < 6) {
            alert("Password must be at least 6 characters.");
            isValid = false;
        }

        // Validate Address
        const address = document.getElementById('<%= txtAddress.ClientID %>').value.trim();
        if (address === "") {
            alert("Address is required.");
            isValid = false;
        }

        // Validate City
        const city = document.getElementById('<%= txtCity.ClientID %>').value.trim();
        if (city === "") {
            alert("City is required.");
            isValid = false;
        }

        // Validate Pin Code (6 digits)
        const pinCode = document.getElementById('<%= txtPinCode.ClientID %>').value.trim();
        if (!/^\d{6}$/.test(pinCode)) {
            alert("Pin code must be exactly 6 digits.");
            isValid = false;
        }

        // Validate Security Question
        const securityQuestion = document.getElementById('<%= ddlSecurityQuestion.ClientID %>').value;
        if (securityQuestion === "") {
            alert("Please select a security question.");
            isValid = false;
        }

        // Validate Security Answer
        const securityAnswer = document.getElementById('<%= txtSecurityAnswer.ClientID %>').value.trim();
        if (securityAnswer === "") {
            alert("Security answer is required.");
            isValid = false;
        }

        // Prevent form submission if validation fails
        if (!isValid) {
            e.preventDefault(); // Prevents server-side click if validation fails
        }
    });
    </script>


</asp:Content>
