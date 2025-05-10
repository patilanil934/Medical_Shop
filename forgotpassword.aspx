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

    <script>
    document.getElementById('<%= btnResetPassword.ClientID %>').addEventListener("click", function (e) {
        let isValid = true;

        // Validate Email (basic format check)
        const email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (email === "" || !emailPattern.test(email)) {
            alert("Please enter a valid email address.");
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

        // Validate New Password (minimum length check)
        const newPassword = document.getElementById('<%= txtNewPassword.ClientID %>').value.trim();
        if (newPassword === "") {
            alert("New password is required.");
            isValid = false;
        } else if (newPassword.length < 6) {
            alert("New password must be at least 6 characters.");
            isValid = false;
        }

        // Validate Confirm Password (check if it matches New Password)
        const confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>').value.trim();
        if (confirmPassword === "") {
            alert("Please confirm your new password.");
            isValid = false;
        } else if (newPassword !== confirmPassword) {
            alert("Passwords do not match.");
            isValid = false;
        }

        // Prevent form submission if validation fails
        if (!isValid) {
            e.preventDefault(); // Prevents server-side click if validation fails
        }
    });
    </script>


</asp:Content>
