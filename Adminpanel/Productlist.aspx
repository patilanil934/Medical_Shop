<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Productlist.aspx.cs" Inherits="MedicalShop.Productlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table img {
            width: 50px;
            height: 50px;
            border-radius: 5px;
        }
        .btn-action {
            margin-right: 5px;
        }
        .btn-add-product {
            float: right;
            margin-bottom: 10px;
        }
        .btn-primary {
            float: right;
             margin-bottom: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content2">
            <div class="dashboard-header">
                <h2>Product List</h2>
            </div>
            <div class="container mt-4">
                <a href="Addproduct.aspx" class="btn btn-primary">Add Product</a>
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Date Created</th>
                            <th>Image</th>
                            <th>Brand</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>2025-03-07 11:22</td>
                            <td><img src="image1.png" alt="Product"></td>
                            <td>Brand 101</td>
                            <td>Amoxicillin 250mg</td>
                            <td>$7.00</td>
                            <td>
                                <button class="btn btn-warning btn-sm btn-action">Edit</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        <!-- More rows can be added dynamically -->
                    </tbody>
                </table>
            </div>
        </div>

</asp:Content>
