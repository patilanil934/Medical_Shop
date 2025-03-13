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
                    <asp:Repeater ID="rptProducts" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("id") %></td>
                                <td><%# Eval("created_at", "{0:yyyy-MM-dd HH:mm}") %></td>
                               <td><img src='<%# ResolveUrl(Eval("resized_image").ToString().Replace("~", "")) + "?v=" + DateTime.Now.Ticks %>' 
     alt="Product Image" width="50" height="50"></td>

                                <td><%# Eval("brandname") %></td>
                                <td><%# Eval("productname") %></td>
                                <td>$<%# Eval("price") %></td>
                                <td>
                                    <a href='EditProduct.aspx?id=<%# Eval("id") %>' class="btn btn-warning btn-sm">Edit</a>
                                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm"
                                        Text="Delete" OnClick="btnDelete_Click" CommandArgument='<%# Eval("id") %>' 
                                        OnClientClick="return confirmDelete();" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this product?');
        }
    </script>
</asp:Content>
