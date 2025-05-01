<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Viewprescriptions.aspx.cs" Inherits="MedicalShop.Adminpanel.PrescriptionOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
    .zoomed-image {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.8);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 2000; /* Higher than Bootstrap modal */
    }
    .zoomed-image img {
        max-width: 90%;
        max-height: 90%;
        cursor: zoom-out;
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <h3>Prescription Orders</h3>

<div class="row mb-3">
    <div class="col-md-3">
        <asp:TextBox ID="txtSearchName" runat="server" CssClass="form-control" placeholder="Search by Name"></asp:TextBox>
    </div>
    <div class="col-md-3">
        <asp:TextBox ID="txtSearchPhone" runat="server" CssClass="form-control" placeholder="Search by Phone"></asp:TextBox>
    </div>
    <div class="col-md-3">
        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control">
            <asp:ListItem Text="All Status" Value=""></asp:ListItem>
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
            <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
            <asp:ListItem Text="Deliverd" Value="Deliverd"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="col-md-3">
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary" OnClick="btnFilter_Click" />
        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary ml-2" OnClick="btnClear_Click" />
    </div>
</div>

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
                <p><strong>Prescription:</strong> <br />
                    <asp:Image ID="imgPrescription" runat="server" Width="300px" CssClass="img-fluid" />
                </p>

                <hr />
                <div class="form-group">
                    <label>Name</label>
                    <asp:Label ID="lblName" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <asp:Label ID="lblPhone" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Doctor</label>
                    <asp:Label ID="lblDoctor" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <asp:Label ID="lblDescription" runat="server" CssClass="form-control" />
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <asp:Label ID="lblAddress" runat="server" CssClass="form-control" />
                </div>

                <hr />
                <div class="form-group">
                    <label>Status</label>
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Pending" Value="Pending" />
                        <asp:ListItem Text="Approved" Value="Approved" />
                        <asp:ListItem Text="Rejected" Value="Rejected" />
                        <asp:ListItem Text="Deliverd" Value="Deliverd" />
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

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function () {
        var wasPrescriptionModalOpen = false;

        // Click on the prescription image
        $("#imgPrescription").on("click", function () {
            var imgSrc = $(this).attr("src");

            if ($('#prescriptionModal').hasClass('show')) {
                wasPrescriptionModalOpen = true;
                $('#prescriptionModal').modal('hide');
            }

            // Remove previous zoomed image if any
            $(".zoomed-image").remove();

            var zoomedImageHtml = `
                <div class="zoomed-image" style="position: fixed; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.9); display:flex; justify-content:center; align-items:center; z-index: 2000;">
                    <img src="${imgSrc}" class="img-fluid" style="max-height:90%; max-width:90%; cursor:pointer;">
                </div>`;

            $("body").append(zoomedImageHtml);

            // Clicking the zoomed image closes it
            $(".zoomed-image").on("click", function () {
                $(this).remove();

                if (wasPrescriptionModalOpen) {
                    $('#prescriptionModal').modal('show');
                    wasPrescriptionModalOpen = false;
                }
            });
        });

        // When prescription modal closes, if zoomed image is still open, clean it properly
        $('#prescriptionModal').on('hidden.bs.modal', function () {
            setTimeout(function () {
                if ($(".zoomed-image").length > 0) {
                    $("body").removeClass('modal-open');
                    $(".modal-backdrop").remove();
                    $(".zoomed-image").remove();
                }
            }, 300);
        });
    });
</script>


</asp:Content>
