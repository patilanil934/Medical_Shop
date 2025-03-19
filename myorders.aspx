<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="myorders.aspx.cs" Inherits="MedicalShop.myorders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
    <h2 class="text-center mb-4">My Orders</h2>
    
    <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound">
        <HeaderTemplate>
            <div class="table-responsive">
                <table class="table table-hover table-bordered text-center align-middle shadow-sm">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Order ID</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Container.ItemIndex + 1 %></td>
                <td><%# Eval("id") %></td>
                <td><strong>₹ <%# Eval("total_amount") %></strong></td>
                <td><%# Eval("order_date", "{0:dd/MM/yyyy}") %></td>
                <td>
                    <%# Eval("status").ToString() == "Pending" ? "<span class='badge bg-warning text-dark'>Pending</span>" :
                        Eval("status").ToString() == "Completed" ? "<span class='badge bg-success'>Completed</span>" :
                        "<span class='badge bg-danger'>Cancelled</span>" %>
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <div class="card p-3 bg-light">
                        <h6 class="text-muted">Order Items</h6>
                        <asp:Repeater ID="rptOrderItems" runat="server">
                            <HeaderTemplate>
                                <table class="table table-sm table-striped table-bordered mt-2">
                                    <thead class="table-secondary">
                                        <tr>
                                            <th>Product ID</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("product_id") %></td>
                                    <td><%# Eval("quantity") %></td>
                                    <td>₹ <%# Eval("price") %></td>
                                    <td>₹ <%# Eval("total") %></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                    </tbody>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
                    </tbody>
                </table>
            </div>
        </FooterTemplate>
    </asp:Repeater>
    
    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger text-center d-block mt-3" Visible="false"></asp:Label>
</div>


</asp:Content>
