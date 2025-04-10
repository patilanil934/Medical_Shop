<%@ Page Title="" Language="C#" MasterPageFile="~/Adminpanel/Adminmasterpage.Master" AutoEventWireup="true" CodeBehind="Viewmessage.aspx.cs" Inherits="MedicalShop.Adminpanel.Viewmessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <h3 class="mb-4">Contact Messages</h3>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
        OnRowCommand="GridView1_RowCommand">
        <Columns>
            <asp:BoundField DataField="name" HeaderText="Name" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="submitted_at" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy HH:mm}" />

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View" CommandName="ViewMessage"
                        CommandArgument='<%# Eval("id") %>' CssClass="btn btn-primary btn-sm me-1" />

                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteMessage"
                        CommandArgument='<%# Eval("id") %>' CssClass="btn btn-danger btn-sm" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <!-- Modal for Viewing Message -->
    <div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content p-3">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitle">Message Detail</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblFullMessage" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
