<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Viewprescriptions.aspx.cs" Inherits="MedicalShop.Adminpanel.PrescriptionOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <h3>Prescription Orders</h3>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
        OnRowCommand="GridView1_RowCommand">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="Order ID" />
            <asp:BoundField DataField="name" HeaderText="Name" />
            <asp:BoundField DataField="phone" HeaderText="Phone" />
            <asp:BoundField DataField="doctor_name" HeaderText="Doctor" />
            <asp:BoundField DataField="created_at" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy HH:mm}" />
            <asp:BoundField DataField="status" HeaderText="Status" />

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View" CommandName="ViewMessage"
                        CommandArgument='<%# Eval("id") %>' CssClass="btn btn-primary btn-sm" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Modal -->
    <div class="modal fade" id="prescriptionModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content p-3">
                <div class="modal-header">
                    <h5 class="modal-title">Prescription Details</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfOrderId" runat="server" />
                    <p><strong>Name:</strong> <asp:Label ID="lblName" runat="server" /></p>
                    <p><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server" /></p>
                    <p><strong>Doctor:</strong> <asp:Label ID="lblDoctor" runat="server" /></p>
                    <p><strong>Description:</strong> <asp:Label ID="lblDescription" runat="server" /></p>
                    <p><strong>Address:</strong> <asp:Label ID="lblAddress" runat="server" /></p>
                    <p><strong>Prescription:</strong> <br />
                        <asp:Image ID="imgPrescription" runat="server" Width="300px" />
                    </p>

                    <hr />
                    <div class="form-group">
                        <label>Status</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Pending" Value="Pending" />
                            <asp:ListItem Text="Approved" Value="Approved" />
                            <asp:ListItem Text="Rejected" Value="Rejected" />
                            asp:ListItem Text="Approved" Value="Deliverd" />
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label>Total Amount</label>
                        <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" TextMode="Number" />
                    </div>
                    <div class="form-group">
                        <label>Admin Note</label>
                        <asp:TextBox ID="txtNote" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</asp:Content>
