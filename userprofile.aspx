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
    margin: 80px auto 50px;
    
    border: 1.5px solid #343a40; /* Added normal dark border */
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
        <h4 class="text-center"><b>My Profile</b></h4>

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

        <div class="row mb-3">
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

        <div class="mb-4">
            <label class="form-label"><b>Security Answer</b></label>
            <asp:TextBox ID="txtSecurityAnswer" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="d-flex justify-content-between">
            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary" Text="Cancel" OnClick="btnCancel_Click" />
        </div>
    </div>
</div>

<script>
    document.getElementById('<%= btnUpdate.ClientID %>').addEventListener("click", function (e) {
        let isValid = true;

        // Validate Name
        const name = document.getElementById('<%= txtName.ClientID %>').value.trim();
        if (name.length < 3) {
            alert("Name must be at least 3 characters.");
            isValid = false;
        }

        // Validate Phone Number (10 digits)
        const phone = document.getElementById('<%= txtPhone.ClientID %>').value.trim();
        if (!/^\d{10}$/.test(phone)) {
            alert("Phone number must be exactly 10 digits.");
            isValid = false;
        }

        // Validate Password (if provided, check its length)
        const password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
        console.log("Password entered:", password);  // Debugging line to log password
        if (password !== "" && password.length < 6) { // If password is provided, check length
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
