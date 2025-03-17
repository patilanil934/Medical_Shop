<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Editproduct.aspx.cs" Inherits="MedicalShop.Adminpanel.Editproduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
      .form-container {
         background: #fff;
         padding: 30px;
         border-radius: 8px;
         box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
         max-width: 600px;
         margin: auto;
         margin-top: 50px;
     }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

       <div class="content2">
            <div class="dashboard-header">
                <h2>Edit Product</h2>
            </div>
            <div class="container mt-4">
                <div class="form-container">
                    <h4 class="text-center mb-3">Edit Product</h4>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                    <asp:HiddenField ID="hfProductId" runat="server" />
                    <asp:Panel ID="pnlForm" runat="server">
                        <div class="mb-3">
                            <label for="txtProductName" class="form-label">Product Name</label>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Enter product name" required></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="ddlBrand" class="form-label">Brand</label>
                            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control" required></asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label for="ddlCategory" class="form-label">Category</label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" required></asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label for="txtDescription" class="form-label">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter description"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtPrice" class="form-label">Price</label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" placeholder="Enter price" required></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtStock" class="form-label">Stock</label>
                            <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" placeholder="Enter stock quantity" required></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="txtExpiryDate" class="form-label">Expiry Date</label>
                            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" TextMode="Date" required></asp:TextBox>
                        </div>
                       
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary w-100" Text="Update Product" OnClick="btnUpdate_Click" />
                    </asp:Panel>
                </div>
            </div>
        </div>
    

    <script>
        function showSuccessMessage() {
            Swal.fire({
                title: 'Updated!',
                text: 'Product has been updated successfully.',
                icon: 'success'
            });
        }
    </script>

</asp:Content>
