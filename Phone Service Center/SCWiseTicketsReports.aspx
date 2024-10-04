<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SCWiseTicketsReports.aspx.cs" Inherits="Phone_Service_Center.SCWiseTicketsReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
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

        .btn {
            cursor: pointer;
            margin: 5px;
        }

        .serviceCenterName {
            white-space: normal; 
            overflow: visible; 
            display: block; 
            line-height: 1.2; 
            color: #333; 
        }

        @media (max-width: 768px) {
            .modalContent {
                width: 90%;
            }
        }
    </style>
    <script type="text/javascript">
        function hideModal() {
            document.getElementById('<%= pnlTicketDetails.ClientID %>').style.display = 'none';
        }
</script>

    <h2>Service Center Wise Ticket Reports</h2>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:TemplateField HeaderText="Service Center" ItemStyle-Width="180px"> 
                <ItemTemplate>
                    <asp:Label ID="lblServiceCenter" runat="server" CssClass="serviceCenterName" Text='<%# Eval("ServiceCenterName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Ticket Count">
                <ItemTemplate>
                    <asp:Label ID="lblTicketCount" runat="server" Text='<%# Eval("TicketCount") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="100px">
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View"
                        CommandName="ShowDetails" CommandArgument='<%# Eval("ServiceCenterID") %>' CssClass="btn btn-warning btn-sm" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:Panel ID="pnlTicketDetails" runat="server" CssClass="modalPopup" Style="display: none;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="modalContent">
                    <asp:GridView ID="GridViewTicketDetails" runat="server" AutoGenerateColumns="false" CssClass="table table-striped">
                        <Columns>
                            <asp:TemplateField HeaderText="Ticket ID" ItemStyle-Width="60px">
                                <ItemTemplate>
                                    <asp:Label ID="lblTicketID" runat="server" Text='<%# Eval("TicketID") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="Product Issues" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="lblProductIssues" runat="server" Text='<%# Eval("ProductIssues") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pincode" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblPincode" runat="server" Text='<%# Eval("Pincode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Created Date" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblCreateDate" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Issue Description" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="lblIssueDescription" runat="server" Text='<%# Eval("IssueDescription") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:Button ID="btnClosePopup" runat="server" Text="Close" CssClass="btn btn-warning btn-sm" OnClientClick="hideModal(); return false;" />                </div>
                <!-- End of modalContent -->
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

    <asp:HiddenField ID="hdnSelectedServiceCenter" runat="server" />
</asp:Content>
