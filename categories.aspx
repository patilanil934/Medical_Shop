<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="categories.aspx.cs" Inherits="MedicalShop.categories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
         .hero {
            height: 60vh;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('images/categories2.jpg') no-repeat center center/cover;
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

        .categories-section {
            padding: 60px 0;
            background-color: #f8f9fa;
        }

        .categories-section h2 {
            font-size: 2.5rem;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 30px;
        }

        .category-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .category-card:hover {
            transform: scale(1.05);
        }

        .category-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <header class="hero">
        <h1>Categories</h1>
    </header>

    <section class="categories-section">
        <div class="container">
            <h2 class="text-center">Explore Our Categories</h2>
            <div class="row mt-5">
                <div class="col-md-4">
                    <div class="category-card">
                        <img src="https://via.placeholder.com/400" alt="Category 1">
                        <div class="p-3">
                            <h5>Prescription Medicines</h5>
                            <p>Wide range of prescription medicines to cater to all your healthcare needs.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-card">
                        <img src="https://via.placeholder.com/400" alt="Category 2">
                        <div class="p-3">
                            <h5>Health Supplements</h5>
                            <p>Boost your well-being with our curated health supplements and vitamins.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-card">
                        <img src="https://via.placeholder.com/400" alt="Category 3">
                        <div class="p-3">
                            <h5>Personal Care</h5>
                            <p>Explore personal care products for daily hygiene and wellness.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="category-card">
                        <img src="https://via.placeholder.com/400" alt="Category 4">
                        <div class="p-3">
                            <h5>Medical Equipment</h5>
                            <p>High-quality medical devices and equipment for your healthcare needs.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-card">
                        <img src="https://via.placeholder.com/400" alt="Category 5">
                        <div class="p-3">
                            <h5>Over-the-Counter Drugs</h5>
                            <p>Find effective OTC medicines for common ailments and symptoms.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="category-card">
                        <img src="https://via.placeholder.com/400" alt="Category 6">
                        <div class="p-3">
                            <h5>Baby Care</h5>
                            <p>Essential products for your baby's health, safety, and comfort.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
