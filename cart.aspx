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
                    <asp:Repeater ID="rptCart" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("productname") %></td>
                                <td>₹<%# Eval("price") %></td>
                                <td>
                                    <asp:Button ID="btnMinus" runat="server" CssClass="btn btn-sm btn-outline-secondary" Text="-" CommandArgument='<%# Eval("product_id") %>' OnClick="DecreaseQuantity"/>
                                    <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control text-center d-inline w-25" 
                                        Text='<%# Eval("quantity") %>' ReadOnly="true"></asp:TextBox>
                                    <asp:Button ID="btnPlus" runat="server" CssClass="btn btn-sm btn-outline-secondary" Text="+" CommandArgument='<%# Eval("product_id") %>' OnClick="IncreaseQuantity"/>
                                </td>
                                <td>₹<%# Eval("total") %></td>
                                <td>
                                    <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-danger btn-sm" 
                                        Text="Remove" CommandArgument='<%# Eval("product_id") %>' 
                                        OnClick="RemoveFromCart"/>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
                <tfoot>
                    <tr class="table-dark">
                        <td colspan="3" class="text-end fw-bold">Total Amount:</td>
                        <td colspan="2" class="fw-bold">₹<asp:Label ID="lblTotalAmount" runat="server" Text="0"></asp:Label></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="text-center mt-4">
    <asp:Image ID="imgQRCode" runat="server" Width="250px" Height="250px" Visible="false" />
    <br />
    <asp:Label ID="lblQRNote" runat="server" Text="Scan to pay using UPI" CssClass="fw-bold" Visible="false"></asp:Label>
</div>

        <div class="checkout-btn text-center">
            <asp:Button ID="btnCheckout" runat="server" CssClass="btn btn-primary" 
                Text="Proceed to Checkout" OnClick="ProceedToCheckout"/>
        </div>
    </div>
</section>

</asp:Content>
