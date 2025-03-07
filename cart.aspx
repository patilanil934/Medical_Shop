<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="MedicalShop.cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
         .cart-container {
            padding: 40px 0;
        }

        .table th, .table td {
            text-align: center;
        }

        .checkout-btn {
            display: flex;
            justify-content: end;
            margin-top: 20px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="cart-container">
        <div class="container">
            <h2 class="text-center mb-4">Your Cart</h2>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>Medicine Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Paracetamol</td>
                            <td>$5</td>
                            <td><input type="number" value="1" min="1" class="form-control text-center"></td>
                            <td>$5</td>
                            <td><button class="btn btn-danger btn-sm">Remove</button></td>
                        </tr>
                        <tr>
                            <td>Cough Syrup</td>
                            <td>$10</td>
                            <td><input type="number" value="1" min="1" class="form-control text-center"></td>
                            <td>$10</td>
                            <td><button class="btn btn-danger btn-sm">Remove</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="checkout-btn">
                <button class="btn btn-primary">Proceed to Checkout</button>
            </div>
        </div>
    </section>

</asp:Content>
