<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="loginuser.aspx.cs" Inherits="MedicalShop.loginuser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
   <style>
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            background: white;
        }
        .login-title {
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 5px;
        }
        .btn-login {
            background-color: hotpink;
            color: blueviolet;
            width: 100%;
        }
        .text-center a {
            text-decoration: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <div class="container">
            <div class="login-container">
                <h3 class="login-title">Login Into Medical Shop</h3>

                <div class="mb-3">
                    <label class="form-label"><b>Email</b></label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label class="form-label"><b>Password</b></label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-login"
    Text="Login" OnClientClick="return validateLoginForm();" OnClick="btnLogin_Click" />
                </div>

                <div class="text-center">
                    <a href="forgotpassword.aspx">Forgot Password?</a>
                </div>

                <div class="text-center mt-2">
                    Not registered? <a href="registeruser.aspx">Register here</a>
                </div>
            </div>
        </div>

    <script>
    function validateLoginForm() {
        var email = document.getElementById("<%= txtEmail.ClientID %>").value.trim();
        var password = document.getElementById("<%= txtPassword.ClientID %>").value.trim();

        if (email === "" || password === "") {
            alert("Both Email and Password are required.");
            return false;
        }

        if (!email.endsWith("@gmail.com")) {
            alert("Email must be a Gmail address (e.g., example@gmail.com).");
            return false;
        }

        return true; // allow form submission
    }
    </script>

    
</asp:Content>
