<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TicketReports.aspx.cs" Inherits="Phone_Service_Center.TicketReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .custom-grid {
            width: 100%;
            max-width: 900px;
            margin: auto;
            overflow-x: auto;
            border-collapse: collapse;
        }

            .custom-grid th, .custom-grid td {
                padding: 10px;
                font-size: 14px;
                text-align: left;
            }

            .custom-grid th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
            }

            .custom-grid td {
                border-bottom: 1px solid #dee2e6;
            }

            .custom-grid .btn {
                margin: 0 5px;
            }
    </style>
    <h2>Ticket Details</h2>

   <div class="table-responsive">
    <asp:GridView ID="GridViewTickets" runat="server" AutoGenerateColumns="False"
        DataKeyNames="TicketID" CssClass="table table-striped table-responsive custom-grid" >
        <Columns>
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
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
