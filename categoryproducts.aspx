<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="categoryproducts.aspx.cs" Inherits="MedicalShop.categoryproducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 <div class="container mt-5">
    <h2 class="text-center">Products</h2>
    <div class="row g-4">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="col-md-3 d-flex align-items-stretch">
                    <div class="card shadow-sm w-100 position-relative" style="min-height: 450px;">
                        <img src='<%# ResolveUrl(Eval("resized_image").ToString()) %>' class="card-img-top" style="height: 200px; object-fit: cover;" />
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%# Eval("productname") %></h5>

                            <!-- Short description -->
                            <p class="card-text short-description" style="overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical;">
                                <%# Eval("description") %>
                            </p>

                            <!-- Full description (hidden initially) -->
                            <p class="card-text full-description d-none">
                                <%# Eval("description") %>
                            </p>

                            <p class="card-text mt-auto"><strong>Price: ₹ <%# Eval("price") %></strong></p>

                            <asp:Button ID="btnAddToCart" runat="server"
                                CommandArgument='<%# Eval("id") %>'
                                CommandName="AddToCart"
                                OnCommand="btnAddToCart_Command"
                                Text="Add to Cart" CssClass="btn btn-primary w-100 mb-2" />

                            <button type="button" class="btn btn-link btn-sm p-0 see-more-btn" style="font-size: 12px;">See More</button>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        const seeMoreButtons = document.querySelectorAll('.see-more-btn');

        seeMoreButtons.forEach(function (btn) {
            btn.addEventListener('click', function () {
                const cardBody = btn.closest('.card-body');
                const shortDesc = cardBody.querySelector('.short-description');
                const fullDesc = cardBody.querySelector('.full-description');

                shortDesc.classList.add('d-none'); // Hide short description
                fullDesc.classList.remove('d-none'); // Show full description
                btn.style.display = 'none'; // Hide "See More" button
            });
        });
    });
</script>



</asp:Content>
