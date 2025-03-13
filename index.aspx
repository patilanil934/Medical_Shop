<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="MedicalShop.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
     .hero {
            height: 100vh;
            background: url('https://via.placeholder.com/1500x800') no-repeat center center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .hero h1 {
            color: white;
            font-size: 4rem;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .features {
           
            padding: 40px 0;
            background-color: #f8f9fa;
        }

        .features h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .features .icon {
            font-size: 3rem;
            color: #007bff;
        }

        .stats {
            padding: 40px 0;
            text-align: center;
            background-color: #e9ecef;
        }

        .stats h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        .stats .number {
            font-size: 3rem;
            font-weight: bold;
            color: #007bff;
        }

        footer {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        .carousel-item img {
            height: 500px;
            object-fit: cover;
        }

</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="carsoull">
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/carsoul11.jpg" class="d-block w-100" alt="Slide 1">
                <div class="carousel-caption d-none d-md-block">
                    <h5>High Quality Medicines</h5>
                    <p>Ensuring the best products for your health.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/carsoul2.jpg" class="d-block w-100" alt="Slide 2">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Fast Delivery</h5>
                    <p>Get your orders delivered quickly to your doorstep.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="images/carsoul3.webp" class="d-block w-100" alt="Slide 3">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Trusted by Thousands</h5>
                    <p>Join our growing list of satisfied customers.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>
    <!-- About Our Medical Shop Section -->
<section class="about-medical-shop py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2>About Our Medical Shop</h2>
                <ul class="list-unstyled">
                    <li>✔ Providing high-quality and affordable medicines.</li>
                    <li>✔ 24/7 availability for your health needs.</li>
                    <li>✔ Certified and trusted pharmaceutical products.</li>
                    <li>✔ Easy online ordering with fast delivery.</li>
                    <li>✔ Customer satisfaction is our priority.</li>
                </ul>
            </div>
            <div class="col-md-6 text-center">
                <img src="images/shivdatta.jpg" style="width:300px;height:200px" class="img-fluid rounded" alt="About Our Medical Shop">
            </div>
        </div>
    </div>
</section>

<section class="stats">
    <div class="container">
        <h2>Our Achievements</h2>
        <div class="row">
            <div class="col-md-4">
                <p class="number" id="customers">0</p>
                <p>Happy Customers</p>
            </div>
            <div class="col-md-4">
                <p class="number" id="products">0</p>
                <p>Products Available</p>
            </div>
            <div class="col-md-4">
                <p class="number" id="orders">0</p>
                <p>Orders Delivered</p>
            </div>
        </div>
    </div>
</section>

    <section class="features">
        <div class="container">
            <h2 class="text-center">Why Choose Us?</h2>
            <div class="row mt-4">
                <div class="col-md-4 text-center">
                    <div class="icon mb-3">💊</div>
                    <h4>Wide Range of Products</h4>
                    <p>We offer a vast selection of medicines and healthcare products to meet all your needs.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="icon mb-3">🚚</div>
                    <h4>Fast Delivery</h4>
                    <p>Get your medicines delivered quickly and safely right to your doorstep.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="icon mb-3">👍</div>
                    <h4>Trusted Service</h4>
                    <p>Experience quality service and reliable healthcare solutions with every order.</p>
                </div>
            </div>
        </div>
    </section>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const animateValue = (id, start, end, duration) => {
                const obj = document.getElementById(id);
                let startTime = null;

                const step = (timestamp) => {
                    if (!startTime) startTime = timestamp;
                    const progress = Math.min((timestamp - startTime) / duration, 1);
                    obj.innerText = Math.floor(progress * (end - start) + start);
                    if (progress < 1) {
                        window.requestAnimationFrame(step);
                    }
                };

                window.requestAnimationFrame(step);
            };

            animateValue("customers", 0, 1000 , 1000);
            animateValue("products", 0, 500, 1000);
            animateValue("orders", 0, 2000, 1000);
        });
    </script>


</asp:Content>
