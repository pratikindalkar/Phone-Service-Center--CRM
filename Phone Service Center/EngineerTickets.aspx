<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EngineerTickets.aspx.cs" Inherits="Phone_Service_Center.EngineerTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <title>Engineer Tickets</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    </head>

    <h2>Engineer Tickets</h2>

    <div class="table-responsive">
        <asp:GridView ID="GridViewEngineerTickets" runat="server" AutoGenerateColumns="False" DataKeyNames="AssignmentID" CssClass="table table-bordered table-hover table-striped" OnRowCommand="GridViewEngineerTickets_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Assignment ID">
                    <ItemTemplate>
                        <asp:Label ID="lblAssignmentID" runat="server" Text='<%# Eval("AssignmentID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ticket ID">
                    <ItemTemplate>
                        <asp:Label ID="lblTicketID" runat="server" Text='<%# Eval("TicketID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ticket No">
                    <ItemTemplate>
                        <asp:Label ID="lblTicketNo" runat="server" Text='<%# Eval("TicketNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Customer Name" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contact No." ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Label ID="lblContactNo" runat="server" Text='<%# Eval("CustomerContactNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("CustomerEmail") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Label ID="lblState" runat="server" Text='<%# Eval("StateName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pincode" ItemStyle-Width="80px">
                    <ItemTemplate>
                        <asp:Label ID="lblPincode" runat="server" Text='<%# Eval("Pincode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product" ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="lblProduct" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Item Serial No." ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="lblItemSerialNo" runat="server" Text='<%# Eval("ItemSerialNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Service Center" ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="lblServiceCenter" runat="server" Text='<%# Eval("ServiceCenterName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Purchase Date" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Label ID="lblPurchaseDate" runat="server" Text='<%# Eval("PurchaseDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Warranty Date" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Label ID="lblWarrantyDate" runat="server" Text='<%# Eval("WarrantyDate", "{0:yyyy-MM-dd}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Issue Description" ItemStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Label ID="lblIssueDescription" runat="server" Text='<%# Eval("IssueDescription") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Issues" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblProductIssues" runat="server" Text='<%# Eval("ProductIssues") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Create Date" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblCreateDate" runat="server" Text='<%# Eval("CreatedDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update Date" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblUpdateDate" runat="server" Text='<%# Eval("UpdatedDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Button ID="btnView" runat="server" Text="View"
                            CommandName="ShowDetails" CommandArgument='<%# Eval("AssignmentID") %>' CssClass="btn btn-primary btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div class="modal fade" id="viewTicketModal" tabindex="-1" role="dialog" aria-labelledby="viewTicketModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewTicketModalLabel">Engineer Ticket Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <asp:Label ID="lblDetailTicketNo" runat="server" Text="Ticket No: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailCustomerName" runat="server" Text="Customer Name: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailContactNo" runat="server" Text="Contact No.: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailEmail" runat="server" Text="Email: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailState" runat="server" Text="State: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailPincode" runat="server" Text="Pincode: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailProduct" runat="server" Text="Product: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailItemSerialNo" runat="server" Text="ItemSerialNo: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailServiceCenter" runat="server" Text="Service Center: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblPurchaseDate" runat="server" Text="Purchase Date: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailWarrentyDate" runat="server" Text="Warranty Date: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailProductIssue" runat="server" Text="Product Issue: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailIssue" runat="server" Text="Issue Description: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailAppointmentDate" runat="server" Text="Appointment Date: " CssClass="form-label"></asp:Label><br />
                            <asp:Label ID="lblDetailInstructions" runat="server" Text="Instructions: " CssClass="form-label"></asp:Label><br />
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="ddlModalTicketStatus">Status:</label>
                                <asp:DropDownList ID="ddlModalTicketStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="--Select Status--" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Close" Value="Close"></asp:ListItem>
                                    <asp:ListItem Text="Reject" Value="Reject"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form-group">
                                <label for="txtModalTicketRemark">Remark:</label>
                                <asp:TextBox ID="txtModalTicketRemark" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Add remark here..."></asp:TextBox>
                            </div>
                            <asp:HiddenField ID="hfAssignmentID" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnModalUpdateStatus" runat="server" Text="Update Status" CssClass="btn btn-primary" OnClick="btnModalUpdateStatus_Click" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
