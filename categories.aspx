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
            padding-bottom:10px;
           
        }

        .category-card:hover {
            transform: scale(1.05);
        }

        .category-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .p-3 h5{
            color:black;
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
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="col-md-4">
                        <a href='categoryproducts.aspx?category_id=<%# Eval("id") %>' class="text-decoration-none">
                            <div class="category-card">
                                <div class="p-3">
                                    <h5><%# Eval("catname") %></h5>
                                    <p><%# Eval("catdescription") %></p>
                                </div>
                            </div>
                        </a>
                        <br />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</section>



</asp:Content>
