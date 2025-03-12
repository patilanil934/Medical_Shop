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
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Date Ordered</th>
                            <th>Code</th>
                            <th>Customer</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>2025-01-18 12:43</td>
                            <td>2025011800001</td>
                            <td>Anil Jotiram Patil</td>
                            <td>$40.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm">Update</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>2022-05-26 10:56</td>
                            <td>2022052600002</td>
                            <td>Samantha Jane C Miller</td>
                            <td>$105.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm">Update</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>2022-05-26 09:22</td>
                            <td>2022052600001</td>
                            <td>Mark D Cooper</td>
                            <td>$50.00</td>
                            <td><span class="status-pending">Pending</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm">Update</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>2022-05-25 16:36</td>
                            <td>20212165468</td>
                            <td>Mark D Cooper</td>
                            <td>$203.00</td>
                            <td><span class="status-paid">Paid</span></td>
                            <td>
                                <button class="btn btn-primary btn-sm">Update</button>
                                <button class="btn btn-danger btn-sm">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

</asp:Content>
