<%@ Page Title="Assign Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AssignTickets.aspx.cs" Inherits="Phone_Service_Center.AssignTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        .custom-grid {
            width: 100%;
            margin: auto;
            overflow-x: auto;
            border-collapse: collapse;
        }

            .custom-grid th, .custom-grid td {
                padding: 10px;
                text-align: left;
            }

            .custom-grid th {
                background-color: #f8f9fa;
            }

            .custom-grid td {
                border-bottom: 1px solid #dee2e6;
            }

        .modalPopup {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 1000;
            overflow: auto;
            transition: opacity 0.3s ease;
        }

        .modalContent {
            margin: 10% auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.5);
            width: 80%;
            max-width: 90vw;
            max-height: 80vh;
            overflow-y: auto;
            overflow-x: auto;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }

            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>

    <script type="text/javascript">
        function showModal() {
            document.getElementById('<%= pnlTicketDetails.ClientID %>').style.display = 'block';
        }

        function hideModal() {
            document.getElementById('<%= pnlTicketDetails.ClientID %>').style.display = 'none';
        }
    </script>

    <h1>Assign Tickets</h1>

    <div class="table-responsive">
        <asp:GridView ID="GridViewTickets" runat="server" AutoGenerateColumns="False"
            DataKeyNames="TicketID" CssClass="table table-striped table-responsive custom-grid" OnRowCommand="GridViewTickets_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Ticket ID" ItemStyle-Width="60px">
                    <ItemTemplate>
                        <asp:Label ID="lblTicketID" runat="server" Text='<%# Eval("TicketID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Ticket No" ItemStyle-Width="60px">
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
                        <asp:Label ID="lblCreatedAt" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reject Remark" ItemStyle-Width="150px">
                    <ItemTemplate>
                        <asp:Label ID="lblRemark" runat="server" Text='<%# Eval("Remark") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="100px">
                    <ItemTemplate>
                        <asp:Button ID="btnView" runat="server" Text="View"
                            CommandName="ShowDetails" CommandArgument='<%# Eval("TicketID") %>' CssClass="btn btn-warning btn-sm"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="pnlTicketDetails" runat="server" CssClass="modalPopup" Style="display: none;">
        <div class="modalContent">
            <center><strong>Tickets Details</strong></center>
            <div class="row">
                <div class="col-md-6">
                    <h6>Ticket Information</h6>
                    <br />
                    <asp:Label ID="lblDetailTicketID" runat="server" Text="Ticket ID: " CssClass="form-label"></asp:Label><br />
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
                </div>
                <div class="col-md-6">
                    <h6>Assign Engineer</h6>
                    <div class="form-group">
                        <label for="ddlEngineer">Assign Engineer:</label>
                        <asp:DropDownList ID="ddlEngineer" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlEngineer" InitialValue="0"
                            ErrorMessage="Please select an Engineer" ValidationGroup="vgSubmit" CssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="appointmentDate">Appointment Date:</label>
                        <asp:TextBox ID="appointmentDate" runat="server" CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="appointmentDate"
                            ErrorMessage="Please select an Appointment Date" ValidationGroup="vgSubmit" CssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <label for="instructions">Instructions for Engineer:</label>
                        <asp:TextBox ID="instructions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                    </div>
                </div>
            </div>

            <div class="text-center mt-3">
                <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="hideModal(); return false;" CssClass="btn btn-secondary me-2" />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="vgSubmit"
                    CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </asp:Panel>
</asp:Content>
