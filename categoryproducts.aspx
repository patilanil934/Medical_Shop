<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="categoryproducts.aspx.cs" Inherits="MedicalShop.categoryproducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <h2 class="text-center">Products</h2>
        <div class="row">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="col-md-4">
                        <div class="card">
<img src='<%# ResolveUrl(Eval("resized_image").ToString().Replace("~", "")) %>' class="card-img-top" alt='<%# Eval("productname") %>'>

                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("productname") %></h5>
                                <p class="card-text"><%# Eval("description") %></p>
                                <p class="card-text"><strong>Price: ₹<%# Eval("price") %></strong></p>
                            </div>
                        </div>
                        <br />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</asp:Content>
