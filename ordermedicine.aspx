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
            
            <form class="mt-4">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="txtName" class="form-label">Your Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name" required></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtPhone" class="form-label">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number" required></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtDoctor" class="form-label">Doctor's Name</label>
                            <asp:TextBox ID="txtDoctor" runat="server" CssClass="form-control" placeholder="Enter the doctor's name" required></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="fuPrescription" class="form-label">Upload Prescription</label>
                            <asp:FileUpload ID="fuPrescription" CssClass="form-control custom-file-input" runat="server" required />
                        </div>
                    </div>
                    <div class="col-md-6">
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
            </form>
        </div>
    </section>
</asp:Content>
