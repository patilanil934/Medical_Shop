<%@ Page Title="" Language="C#" MasterPageFile="~/Mainpage.Master" AutoEventWireup="true" CodeBehind="prescriptionorders.aspx.cs" Inherits="MedicalShop.prescriptionorders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
    <h2 class="text-center mb-4">My Prescription Orders</h2>

    <asp:Repeater ID="rptPrescriptionOrders" runat="server">
        <HeaderTemplate>
            <div class="table-responsive">
                <table class="table table-hover table-bordered text-center align-middle shadow-sm">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>User Name</th>
                            <th>Doctor Name</th>
                            <th>Status</th>
                            <th>Total Amount</th>
                            <th>Admin Note</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Container.ItemIndex + 1 %></td>
                <td><%# Eval("name") %></td>
                <td><%# Eval("doctor_name") %></td>
                <td>
                    <%# 
                        Eval("status").ToString() == "Pending" ? "<span class='badge bg-warning text-dark'>Pending</span>" :
                        Eval("status").ToString() == "Approved" ? "<span class='badge bg-primary'>Approved</span>" :
                        Eval("status").ToString() == "Rejected" ? "<span class='badge bg-danger'>Rejected</span>" :
                        Eval("status").ToString() == "Deliverd" ? "<span class='badge bg-success'>Deliverd</span>" :
                        "<span class='badge bg-secondary'>Unknown</span>"
                    %>
                </td>
                <td>₹ <%# Eval("total_amount") %></td>
                <td><%# Eval("admin_note") %></td>
                <td>
                    <button type="button" class="btn btn-primary btn-sm" onclick="viewPrescription('<%# Eval("prescription_image") %>')">
                        View
                    </button>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
                    </tbody>
                </table>
            </div>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger text-center d-block mt-3" Visible="false"></asp:Label>
</div>

<!-- Modal for Prescription Image -->
<div class="modal fade" id="prescriptionModal" tabindex="-1" aria-labelledby="prescriptionModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content shadow">
      <div class="modal-header">
        <h5 class="modal-title" id="prescriptionModalLabel">Prescription Image</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">
        <img id="prescriptionImage" src="images/no-image.png" alt="Prescription Image" class="img-fluid rounded shadow" style="max-height: 500px;" />
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // JavaScript function to open the modal and show prescription image
    function viewPrescription(imagePath) {
        var img = document.getElementById('prescriptionImage');

        // Ensure the path is correct: prepend the folder path if the image exists
        if (imagePath && imagePath.trim() !== "") {
            img.src = '/' + imagePath;  // Prepend to the relative image path from the database
        } else {
            img.src = '/images/no-image.png'; // Fallback image if the image is missing or empty
        }

        var modal = new bootstrap.Modal(document.getElementById('prescriptionModal'));
        modal.show();
    }
</script>



</asp:Content>
