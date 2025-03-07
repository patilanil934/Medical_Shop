<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="aboutus.aspx.cs" Inherits="MedicalShop.contactus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

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

        .about-section {
            padding: 60px 0;
            background-color: #f8f9fa;
        }

        .about-section h2 {
            font-size: 2.5rem;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 30px;
        }

        .about-content {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .about-text {
            flex: 1;
            color: #555;
        }

        .about-text h3 {
            font-size: 1.8rem;
            margin-bottom: 15px;
        }

        .about-image {
            flex: 1;
        }

        .about-image img {
            width: 100%;
            border-radius: 10px;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <header class="hero">
        <h1>About Us</h1>
    </header>

    <section class="about-section">
        <div class="container">
            <h2 class="text-center">We Care About Your Health</h2>
            <div class="about-content">
                <div class="about-text">
                    <h3>Our Mission</h3>
                    <p>We aim to make healthcare accessible, affordable, and convenient for everyone. With a focus on providing high-quality products and exceptional customer service, we strive to become a trusted partner in your health journey.</p>

                    <h3>Our Vision</h3>
                    <p>We envision a world where every individual has access to the medicines and healthcare products they need, delivered with care and professionalism. Our goal is to set new standards in the medical retail industry.</p>
                </div>
                <div class="about-image">
                    <img src="images/Online-Medicine-Store.png" alt="About Us">
                </div>
            </div>
        </div>
    </section>

    <section class="about-section">
        <div class="container">
            <h2 class="text-center">Why Choose Us?</h2>
            <div class="row mt-5">
                <div class="col-md-4 text-center">
                    <h3>Quality Medicines</h3>
                    <p>We ensure that every product meets the highest standards of quality and safety, providing you with peace of mind.</p>
                </div>
                <div class="col-md-4 text-center">
                    <h3>Fast Delivery</h3>
                    <p>Our efficient delivery network ensures that your medicines reach your doorstep quickly and safely.</p>
                </div>
                <div class="col-md-4 text-center">
                    <h3>Expert Support</h3>
                    <p>Our team of healthcare professionals is here to answer your questions and guide you every step of the way.</p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
