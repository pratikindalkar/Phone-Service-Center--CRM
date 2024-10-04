<%@ Page Title="Generate Tickets" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GenerateTickets.aspx.cs" Inherits="Phone_Service_Center.GenerateTickets" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Generate Ticket</h2>

        <script type="text/javascript">
            function allowOnlyLetters(event) {
                var charCode = event.which ? event.which : event.keyCode;
                if ([8, 9, 27, 13].indexOf(charCode) !== -1 ||
                    (charCode === 65 && (event.ctrlKey === true || event.metaKey === true)) ||
                    (charCode === 67 && (event.ctrlKey === true || event.metaKey === true)) ||
                    (charCode === 88 && (event.ctrlKey === true || event.metaKey === true)) ||
                    (charCode === 86 && (event.ctrlKey === true || event.metaKey === true)) ||
                    (charCode >= 35 && charCode <= 39)) {
                    return true;
                }
                return charCode >= 65 && charCode <= 90 || charCode >= 97 && charCode <= 122;
            }
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                return (charCode >= 48 && charCode <= 57) || charCode === 8 || charCode === 46;
            }

            function openTab(evt, tabName) {
                var i, tabcontent, tablinks;

                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }

                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }

                document.getElementById(tabName).style.display = "block";
                evt.currentTarget.className += " active";
            }

            window.onload = function () {
                document.getElementsByClassName("tablinks")[0].click();
                //document.getElementsByClassName("tablinks")[0].className += " active";
            };
            function toggleDropdown() {
                var dropdownContent = document.getElementById("DropdownContent");
                dropdownContent.classList.toggle("show");
            }

            //window.onclick = function (event) {
            //    if (!event.target.matches('.dropdown-button')) {
            //        var dropdowns = document.getElementsByClassName("dropdown-content");
            //        for (var i = 0; i < dropdowns.length; i++) {
            //            var openDropdown = dropdowns[i];
            //            if (openDropdown.classList.contains('show')) {
            //                openDropdown.classList.remove('show');
            //            }
            //        }
            //    }
            //}
        </script>
        <style>
            .text-center {
                text-align: center;
            }

            .btn-custom {
                background-color: red;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
            }

            .row {
                margin-bottom: 5px;
            }

            .tab {
                overflow: hidden;
            }

                .tab button {
                    background-color: transparent;
                    border: none;
                    outline: none;
                    cursor: pointer;
                    padding: 10px 15px;
                    font-size: 16px;
                    margin-right: 5px;
                    transition: border-bottom 0.3s;
                }

            .tabcontent {
                display: none;
                padding: 20px;
            }

            .tab button.active {
                font-weight: bold;
                border-bottom: 2px solid black;
            }

            .dropdown {
                position: relative;
                display: inline-block;
                width: 100%;
            }

            .dropdown-button {
                cursor: pointer;
                border: 1px solid #ced4da;
                padding: 10px;
                background-color: #f8f9fa;
                border-radius: 0.25rem;
                width: 100%;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: white;
                border: 1px solid #ced4da;
                border-radius: 0.25rem;
                z-index: 1;
                width: 100%;
                max-height: 150px;
                overflow-y: auto;
                padding: 10px;
            }

                .dropdown-content.show {
                    display: block;
                }

            .text-danger {
                font-size: 0.9em;
            }
        </style>
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

        <div class="tab">
            <button type="button" class="tablinks" onclick="openTab(event, 'FormTab')">Ticket Form</button>
            <button type="button" class="tablinks" onclick="openTab(event, 'GridTab')">Ticket Grid</button>
        </div>

        <div id="FormTab" class="tabcontent">
            <div class="mb-3">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lblCustomerName" runat="server" Text="Customer Name:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" Placeholder="Enter Customer Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerName" runat="server" ControlToValidate="txtCustomerName" ErrorMessage="Customer Name is required" ValidationGroup="vgSubmit" CssClass="text-danger" />
                    </div>
                    <div class="col-sm-4">
                        <asp:Label ID="lblCustomerContactNo" runat="server" Text="Customer Contact No.:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtCustomerContactNo" runat="server" onkeypress="return isNumberKey(event)" MaxLength="10" CssClass="form-control" Placeholder="Enter Customer Contact No."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerContactNo" runat="server" ControlToValidate="txtCustomerContactNo" ErrorMessage="Customer Contact No. is required" CssClass="text-danger" ValidationGroup="vgSubmit" />
                        <asp:RegularExpressionValidator ID="revCustomerContactNo" runat="server" ControlToValidate="txtCustomerContactNo" ErrorMessage="Invalid Contact No." CssClass="text-danger" ValidationExpression="\d{10}" />
                    </div>
                    <div class="col-sm-4">
                        <asp:Label ID="lblCustomerEmail" runat="server" Text="Customer Email:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtCustomerEmail" runat="server" CssClass="form-control" Placeholder="Enter Customer Email" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCustomerEmail" runat="server" ControlToValidate="txtCustomerEmail" ErrorMessage="Customer Email is required" ValidationGroup="vgSubmit" CssClass="text-danger" />
                        <asp:RegularExpressionValidator ID="revCustomerEmail" runat="server" ControlToValidate="txtCustomerEmail" ErrorMessage="Invalid Email Address" CssClass="text-danger" ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" />
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lblState" runat="server" Text="State:" CssClass="form-label"></asp:Label>
                        <asp:DropDownList ID="ddlState" runat="server" DataTextField="StateName" DataValueField="StateID" AppendDataBoundItems="true" CssClass="form-control">
                            <asp:ListItem Text="--Select State--" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState" ValidationGroup="vgSubmit" InitialValue="0" ErrorMessage="Please select a State" CssClass="text-danger" />
                    </div>
                    <div class="col-sm-4">
                        <asp:Label ID="lblPincode" runat="server" Text="Pincode:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="form-control" MaxLength="6"
                            onkeypress="return isNumberKey(event)" Placeholder="Enter Customer Pincode"
                            AutoPostBack="true" OnTextChanged="txtPincode_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorPincode" runat="server" ValidationGroup="vgSubmit" ControlToValidate="txtPincode" ErrorMessage="Please enter a Pincode" CssClass="text-danger" />
                        <asp:RegularExpressionValidator ID="RegexValidatorPincode" runat="server" ControlToValidate="txtPincode" ErrorMessage="Invalid pincode, must be 6 digits." ValidationExpression="^\d{6}$" CssClass="text-danger" ValidationGroup="vgCheck" />
                    </div>

                    <div class="col-sm-4">
                        <asp:Label ID="lblAssignProduct" runat="server" Text="Product Name:" CssClass="form-label"></asp:Label>
                        <asp:DropDownList ID="ddlAssignProduct" runat="server" DataTextField="ProductName" DataValueField="SlNo" AppendDataBoundItems="true" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlAssignProduct_SelectedIndexChanged">
                            <asp:ListItem Text="--Select Product Name--" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Provide a product Name" InitialValue="0" ValidationGroup="vgSubmit" ControlToValidate="ddlAssignProduct" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lblPurchaseDate" runat="server" Text="Purchase Date:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-control" OnTextChanged="txtPurchaseDate_TextChanged" AutoPostBack="true" TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPurchaseDate" runat="server" ValidationGroup="vgSubmit" ControlToValidate="txtPurchaseDate" ErrorMessage="Purchase Date is required" CssClass="text-danger" />
                    </div>

                    <div class="col-sm-4">
                        <asp:Label ID="lblServiceCenter" runat="server" Text="Service Center:" CssClass="form-label"></asp:Label>
                        <asp:DropDownList ID="ddlServiceCenter" runat="server" CssClass="form-control" AutoPostBack="True">
                            <asp:ListItem Text="Select Service Center" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a Service Center" InitialValue="0" ControlToValidate="ddlServiceCenter" ValidationGroup="vgSubmit" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    </div>

                    <div class="col-sm-4">
                        <asp:Label ID="lblItemSerialNo" runat="server" Text="Item Serial No.:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtItemSerialNo" runat="server" CssClass="form-control" Placeholder="Enter Item Serial No." MaxLength="16" MinLength="10" onkeypress="return isNumberKey(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemSerialNo" runat="server" ValidationGroup="vgSubmit" ControlToValidate="txtItemSerialNo" ErrorMessage="Item Serial No. is required" CssClass="text-danger" />
                        <asp:RegularExpressionValidator ID="revItemSerialNo" runat="server" ControlToValidate="txtItemSerialNo" ErrorMessage="Item Serial No. must be between 10 and 16 characters" CssClass="text-danger" ValidationExpression=".{10,16}" />
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <div class="row">
                    <div class="col-sm-4">
                        <asp:Label ID="lblWarrantyDate" runat="server" Text="Warranty Date:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtWarrantyDate" runat="server" TextMode="Date" ReadOnly="true" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvWarrantyDate" ValidationGroup="vgSubmit" runat="server" ControlToValidate="txtWarrantyDate" ErrorMessage="Warranty Date is required" CssClass="text-danger" />
                    </div>
                    <div class="col-sm-4">
                        <asp:Label ID="lblProductIssues" runat="server" Text="Select Product Issues:" CssClass="form-label"></asp:Label>
                        <div class="dropdown" onclick="toggleDropdown()">
                            <div class="dropdown-button">Select Issues</div>
                            <div id="DropdownContent" class="dropdown-content">
                                <asp:CheckBoxList ID="chkProductIssues" runat="server">
                                    <asp:ListItem Text="Unresponsive buttons"></asp:ListItem>
                                    <asp:ListItem Text="Charging problems"></asp:ListItem>
                                    <asp:ListItem Text="Software issues"></asp:ListItem>
                                    <asp:ListItem Text="Battery replacement"></asp:ListItem>
                                    <asp:ListItem Text="Screen replacement"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4">
                        <asp:Label ID="lblIssueDescription" runat="server" Text="Issue Description:" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtIssueDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="3" Placeholder="Describe the issue..."></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvIssueDescription" runat="server" ValidationGroup="vgSubmit" ControlToValidate="txtIssueDescription" ErrorMessage="Issue Description is required" CssClass="text-danger" />
                    </div>
                </div>
            </div>

            <div class="text-center">
                
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-danger btn-sm" ValidationGroup="vgSubmit" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-danger btn-sm" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-warning btn-sm" OnClick="btnCancel_Click1" />
                

            </div>
            <div>
                <div class="col-sm-12 text-center">
                    <asp:Label ID="lblResult" runat="server" Text="" Visible="False"></asp:Label>
                </div>
            </div>
        </div>


        <div id="GridTab" class="tabcontent">
            <div class="table-responsive">
                <asp:GridView ID="GridViewTickets" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="TicketID" CssClass="table table-striped table-responsive custom-grid" OnRowCommand="onRowCommand1" OnRowEditing="GridView1_RowEditing" OnRowDeleting="OnRowDeleting1">
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
                        <asp:TemplateField HeaderText="Created Date" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <asp:Label ID="lblCreateDate" runat="server" Text='<%# Eval("CreatedAt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Updated Date" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <asp:Label ID="lblUpdatedDate" runat="server" Text='<%# Eval("UpdatedAt") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("TicketID") %>' CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                                <asp:Button ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("TicketID") %>' CssClass="btn btn-danger btn-sm" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
</asp:Content>
