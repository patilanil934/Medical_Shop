<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="contactus.aspx.cs" Inherits="MedicalShop.contactus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .hero {
            height: 60vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('images/aboutbg.png') no-repeat center center/cover;
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

        .contact-section {
            padding: 60px 0;
            background-color: #f8f9fa;
        }

        .contact-form label {
            font-weight: 600;
        }

        .contact-info {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 12px rgba(0,0,0,0.1);
        }

        .form-control, .btn {
            border-radius: 0.5rem;
        }

        .btn-primary {
            padding: 10px 25px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero Section (Keep the same) -->
    <header class="hero">
        <h1>Contact Us</h1>
    </header>

    <!-- Replaced Section: Contact Us Content -->
    <section class="contact-section">
    <div class="container">
        <div class="row">
            <!-- Contact Info (Left Side) -->
            <div class="col-md-6 contact-info">
                <h3 class="mb-4"><i class="bi bi-chat-left-text-fill me-2"></i>Get in Touch</h3>
                <p class="d-flex align-items-center">
                    <i class="bi bi-geo-alt-fill text-primary me-2"></i>
                    <span><strong>Address:</strong> <asp:Literal ID="litAddress" runat="server" /></span>
                </p>
                <p class="d-flex align-items-center">
                    <i class="bi bi-envelope-fill text-primary me-2"></i>
                    <a href="mailto:" class="text-decoration-none">
                        <strong>Email:</strong> <asp:Literal ID="litEmail" runat="server" />
                    </a>
                </p>
                <p class="d-flex align-items-center">
                    <i class="bi bi-telephone-fill text-primary me-2"></i>
                    <a href="tel:" class="text-decoration-none">
                        <strong>Phone:</strong> <asp:Literal ID="litPhone" runat="server" />
                    </a>
                </p>
            </div>

            <!-- Contact Form (Right Side) -->
            <div class="col-md-6">
                <h3>Send Us a Message</h3>
                <div class="contact-form">
                    <div class="mb-3">
                        <label for="txtName" class="form-label">Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name" />
                    </div>
                    <div class="mb-3">
                        <label for="txtEmail" class="form-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Your Email" />
                    </div>
                    <div class="mb-3">
                        <label for="txtMessage" class="form-label">Message</label>
                        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Your message" />
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary" OnClick="btnSubmit_Click"/>
                </div>
            </div>
        </div>
    </div>
</section>

</asp:Content>
