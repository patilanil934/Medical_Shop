<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="ordermedicine.aspx.cs" Inherits="MedicalShop.ordermedicine" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .hero {
            height: 60vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('images/ordermedicine.jpg') no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .hero h1 {
            color: white;
            font-size: 3.5rem;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
            text-align: center;
        }

        .order-section {
            padding: 60px 0;
            background-color: #f8f9fa;
        }

        .order-section h2 {
            font-size: 2.5rem;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 30px;
        }

        .form-control {
            border-radius: 8px;
        }

        .custom-file-input {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <header class="hero">
        <h1>Order Medicine</h1>
    </header>

    <section class="order-section">
        <div class="container">
            <h2 class="text-center">Place Your Order</h2>
            
            
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="txtName" class="form-label">Your Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtPhone" class="form-label">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number" ></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtDoctor" class="form-label">Doctor's Name</label>
                            <asp:TextBox ID="txtDoctor" runat="server" CssClass="form-control" placeholder="Enter the doctor's name" ></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="fuPrescription" class="form-label">Upload Prescription</label>
                            <asp:FileUpload ID="fuPrescription" CssClass="form-control custom-file-input" runat="server"  />
                        </div>
                    </div>
                    <div class="col-md-6">

                        <div class="mb-3">
                            <label class="form-label">Do you need this medicine repeatedly?</label><br />
                            <asp:RadioButtonList ID="rblReminder" runat="server" RepeatDirection="Horizontal" CssClass="form-check">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>

                        <div class="mb-3" id="reminderDaysDiv" style="display:none;">
                            <label for="txtReminderDays" class="form-label">Enter reminder days (e.g. 5, 10)</label>
                            <asp:TextBox ID="txtReminderDays" runat="server" CssClass="form-control" placeholder="Reminder days"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label for="txtDescription" class="form-label">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter details about the medicine"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtAddress" class="form-label">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter your delivery address" required></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <asp:Button ID="btnSubmitOrder" CssClass="btn btn-primary" runat="server" Text="Submit Order" OnClick="btnSubmitOrder_Click" />
                </div>
            
        </div>
    </section>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const radioList = document.querySelectorAll("input[name*='rblReminder']");
        const reminderDiv = document.getElementById("reminderDaysDiv");

        radioList.forEach(radio => {
            radio.addEventListener("change", () => {
                reminderDiv.style.display = (radio.value === "Yes" && radio.checked) ? "block" : "none";
            });
        });
    });
    </script>

    <script>
        document.getElementById('<%= btnSubmitOrder.ClientID %>').addEventListener("click", function (e) {
            let isValid = true;

            const name = document.getElementById('<%= txtName.ClientID %>').value.trim();
        const phone = document.getElementById('<%= txtPhone.ClientID %>').value.trim();
        const doctor = document.getElementById('<%= txtDoctor.ClientID %>').value.trim();
        const fileUpload = document.getElementById('<%= fuPrescription.ClientID %>').value;
        const reminderYes = document.querySelector("input[id*='rblReminder']:checked").value === "Yes";
        const reminderDays = document.getElementById('<%= txtReminderDays.ClientID %>').value.trim();
        const address = document.getElementById('<%= txtAddress.ClientID %>').value.trim();

        if (name.length < 3) {
            alert("Name must be at least 3 characters.");
            isValid = false;
        } else if (!/^\d{10}$/.test(phone)) {
            alert("Phone number must be exactly 10 digits.");
            isValid = false;
        } else if (doctor === "") {
            alert("Doctor's name is required.");
            isValid = false;
        } else if (fileUpload === "") {
            alert("Please upload a prescription.");
            isValid = false;
        } else if (reminderYes && (!/^\d+$/.test(reminderDays) || parseInt(reminderDays) <= 0)) {
            alert("Enter valid reminder days (positive number).");
            isValid = false;
        } else if (address === "") {
            alert("Delivery address is required.");
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault(); // Prevents server-side click if validation fails
        }
    });

        // Show/hide reminderDays textbox based on radio selection
        document.querySelectorAll("input[id*='rblReminder']").forEach(function (radio) {
            radio.addEventListener("change", function () {
                const reminderDiv = document.getElementById("reminderDaysDiv");
                reminderDiv.style.display = this.value === "Yes" ? "block" : "none";
            });
        });
    </script>


</asp:Content>
