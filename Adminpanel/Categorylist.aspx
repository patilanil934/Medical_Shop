<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Categorylist.aspx.cs" Inherits="MedicalShop.Categorylist1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
      .btn-primary {
             float: right;
              margin-bottom: 10px;
         }
   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div class="container mt-4">
    <div class="dashboard-header">
        <h2>Category List</h2>
    </div>
    <a href="Addcategory.aspx" class="btn btn-primary">Add Category</a>
    
    <asp:GridView ID="gvCategories" runat="server" CssClass="table table-bordered table-striped" 
    AutoGenerateColumns="False" DataKeyNames="ID" 
    OnRowDeleting="gvCategories_RowDeleting" OnRowEditing="gvCategories_RowEditing" 
    OnRowUpdating="gvCategories_RowUpdating" OnRowCancelingEdit="gvCategories_RowCancelingEdit">
    
    <Columns>
        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
        <asp:BoundField DataField="catname" HeaderText="Category Name" ReadOnly="True" />
        
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-warning btn-sm" 
                    Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("id") %>' />

                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger btn-sm" 
                    Text="Delete" CommandName="DeleteCategory" CommandArgument='<%# Eval("id") %>' 
                    OnClientClick="return confirm('Are you sure you want to delete this category?');" />
            </ItemTemplate>

            <EditItemTemplate>
                <asp:TextBox ID="txtEditCategoryName" runat="server" CssClass="form-control" 
                    Text='<%# Bind("catname") %>'></asp:TextBox>
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success btn-sm" 
                    Text="Update" CommandName="Update" />
                <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-sm" 
                    Text="Cancel" CommandName="Cancel" />
            </EditItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

</div>
</asp:Content>
