<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Customerlist.aspx.cs" Inherits="MedicalShop.Customerlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content2">
            <div class="dashboard-header">
                <h2>Customers List</h2>
            </div>
            <div class="container mt-4">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                   <tbody>
    <asp:Repeater ID="rptCustomers" runat="server" OnItemCommand="rptCustomers_ItemCommand">
        <ItemTemplate>
            <tr>
                <td><%# Container.ItemIndex + 1 %></td>
                <td><%# Eval("name") %></td>
                <td><%# Eval("email") %></td>
                <td><%# Eval("phone") %></td>
                <td><%# Eval("address") %></td>
                <td>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"
                        CommandName="DeleteCustomer" CommandArgument='<%# Eval("id") %>' 
                        OnClientClick="return confirmDelete();" />
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
</tbody>
                </table>
            </div>
        </div>
    <script>
        function confirmDelete() {
    return confirm('Are you sure you want to delete this customer?');
}

    </script>

</asp:Content>
