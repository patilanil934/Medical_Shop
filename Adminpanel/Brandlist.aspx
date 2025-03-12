<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Brandlist.aspx.cs" Inherits="MedicalShop.Brandlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .table-container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .action-buttons button {
            margin-right: 5px;
        }
        .btn-add {
            float: right;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content2">
    <div class="dashboard-header">
        <h2>Brand List</h2>
    </div>
    <div class="container mt-4">
        <div class="d-flex justify-content-between mb-3">
            <h4>All Brands</h4>
            <a href="AddBrand.aspx" class="btn btn-primary">Add Brand</a>
        </div>

        <asp:GridView ID="gvBrands" runat="server" CssClass="table table-striped" AutoGenerateColumns="False"
                 DataKeyNames="id" OnRowCommand="gvBrands_RowCommand" 
                 OnRowEditing="gvBrands_RowEditing" OnRowUpdating="gvBrands_RowUpdating" 
                 OnRowCancelingEdit="gvBrands_RowCancelingEdit">
    <Columns>
        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
        <asp:BoundField DataField="brandname" HeaderText="Brand Name" ReadOnly="True" />
        
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-warning btn-sm" Text="Edit"
                    CommandName="Edit" />

                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" 
                        Text="Delete" CommandName="DeleteBrand" CommandArgument='<%# Eval("id") %>' 
                        OnClientClick="return confirm('Are you sure you want to delete this brand?');" />
            </ItemTemplate>

            <EditItemTemplate>
                <asp:TextBox ID="txtEditBrandName" runat="server" CssClass="form-control" Text='<%# Bind("brandname") %>'></asp:TextBox>
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success btn-sm" Text="Update" CommandName="Update" />
                <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-sm" Text="Cancel" CommandName="Cancel" />
            </EditItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>


    </div>
</div>


</asp:Content>
