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
                            <label for="name" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="name" placeholder="Enter your name" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" placeholder="Enter your phone number" required>
                        </div>
                        <div class="mb-3">
                            <label for="doctor" class="form-label">Doctor's Name</label>
                            <input type="text" class="form-control" id="doctor" placeholder="Enter the doctor's name" required>
                        </div>
                        <div class="mb-3">
                            <label for="prescription" class="form-label">Upload Prescription</label>
                            <asp:FileUpload ID="prescription" CssClass="form-control custom-file-input" runat="server" required />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Medicine Quantity</label>
                            <input type="number" class="form-control" id="quantity" placeholder="Enter quantity" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" rows="3" placeholder="Enter details about the medicine" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <asp:TextBox ID="address" CssClass="form-control" runat="server" TextMode="MultiLine" Rows="3" placeholder="Enter your delivery address" required></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="text-center">
                    <asp:Button ID="submitOrder" CssClass="btn btn-primary" runat="server" Text="Submit Order"  />
                </div>
            </form>
        </div>
    </section>
</asp:Content>
