<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Orderlist.aspx.cs" Inherits="MedicalShop.Orderlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .status-paid {
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 14px;
        }
        .status-pending {
            background-color: #6c757d;
            color: white;
            padding: 5px 10px;
            border-radius: 12px;
            font-size: 14px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="content2">
    <div class="dashboard-header">
        <h2>Order List</h2>
    </div>

    <div class="container mt-4">
        <!-- Filters outside the table -->
        <asp:Panel ID="pnlFilters" runat="server" CssClass="row mb-3">
            <div class="col-md-3">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search by code, name, status"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
                    <asp:ListItem Text="All Statuses" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Out for Delivery" Value="Out for Delivery"></asp:ListItem>
                    <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnFilter" runat="server" CssClass="btn btn-success w-100" Text="Filter" OnClick="btnFilter_Click" />
            </div>
        </asp:Panel>

        <!-- Table starts after the filters -->
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Date Ordered</th>
                    <th>Code</th>
                    <th>Customer</th>
                    <th>Total Amount</th>
                    <th>Current Status</th>
                    <th>Select Status</th>  
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.ItemIndex + 1 %></td>
                            <td><%# Eval("order_date", "{0:yyyy-MM-dd HH:mm}") %></td>
                            <td><%# "ORD" + Eval("id") %></td>
                            <td><%# Eval("name") %></td>
                            <td>$<%# Eval("total_amount") %></td>
                            <td><strong><%# Eval("status") %></strong></td>
                            <td>
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem Text="Out for Delivery" Value="Out for Delivery"></asp:ListItem>
                                    <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="UpdateStatus" 
                                    CommandArgument='<%# Eval("id") %>' CssClass="btn btn-primary btn-sm" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
</div>


</asp:Content>
