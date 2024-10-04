<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ServiceCenterMaster.aspx.cs" Inherits="Phone_Service_Center.ServiceCenterMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .form-label {
            padding-right: 10px;
        }

        .mb-3 {
            margin-bottom: 0.5rem;
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
    </style>
    
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
        text-align: left; /* Align text to the left */
        font-size: 16px; /* Font size */
        transition: background-color 0.3s; /* Smooth background color transition */
    }

    .dropdown-button:hover {
        background-color: #e2e6ea; /* Change background on hover */
    }

    .dropdown-content {
        display: none; 
        position: absolute;
        background-color: white;
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
        z-index: 1;
        overflow-y: auto; 
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
        padding: 10px; 
    }

    .dropdown-content.show {
        display: block; 
    }

    .dropdown-content .form-check {
        display: flex; 
        align-items: center; 
        margin: 5px 0; 
    }

    .dropdown-content .form-check input[type="checkbox"] {
        margin-right: 10px; 
    }

    .text-danger {
        font-size: 0.9em;
        color: red; 
    }
</style>


    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            return (charCode >= 48 && charCode <= 57) || charCode === 8 || charCode === 46;
        }

        function limitLength(input, maxLength) {
            if (input.value.length > maxLength) {
                input.value = input.value.slice(0, maxLength);
            }
        }

        function openTab(evt, tabName) {
            var tabcontent = document.getElementsByClassName("tabcontent");
            for (var i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }

            var tablinks = document.getElementsByClassName("tablinks");
            for (var i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }

            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }

        window.onload = function () {
            document.getElementsByClassName("tablinks")[0].click();
        };
    </script>

    <script type="text/javascript">
        function toggleDropdown() {
            var dropdownContent = document.getElementById("DropdownContent");
            if (dropdownContent.style.display === "none" || dropdownContent.style.display === "") {
                dropdownContent.style.display = "block";
            } else {
                dropdownContent.style.display = "none";
            }
        }

        //window.onclick = function (event) {
        //    if (!event.target.matches('.dropdown-button')) {
        //        var dropdowns = document.getElementsByClassName("dropdown-content");
        //        for (var i = 0; i < dropdowns.length; i++) {
        //            var openDropdown = dropdowns[i];
        //            if (openDropdown.style.display === 'block') {
        //                openDropdown.style.display = 'none';
        //            }
        //        }
        //    }
        //}
</script>

    <div class="tab">
        <button type="button" class="tablinks" onclick="openTab(event, 'FormTab')">Service Center Form</button>
        <button type="button" class="tablinks" onclick="openTab(event, 'GridTab')">Service Center Grid</button>
    </div>

    <div id="FormTab" class="tabcontent">
        <div class="container">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblServiceCenterName" runat="server" Text="Service Center Name:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtServiceCenterName" runat="server" MaxLength="50" CssClass="form-control" Placeholder="Enter Service Center Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter Service Center Name" ValidationGroup="vgSubmit" ControlToValidate="txtServiceCenterName" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidator1" runat="server" ControlToValidate="txtServiceCenterName" ErrorMessage="Service Center Name must be between 3 and 50 characters" ValidationExpression="^[a-zA-Z\s]{3,50}$" CssClass="text-danger">Invalid</asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblAddress" runat="server" Text="Address:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" MaxLength="400" CssClass="form-control" Placeholder="Enter Address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter Address" ValidationGroup="vgSubmit" ControlToValidate="txtAddress" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblPincode" runat="server" Text="Pincode:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPincode" runat="server" MaxLength="6" onkeypress="return isNumberKey(event)" oninput="limitLength(this, 6)" CssClass="form-control" Placeholder="Enter Pincode"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter Pincode" ValidationGroup="vgSubmit" ControlToValidate="txtPincode" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidator2" runat="server" ControlToValidate="txtPincode" ErrorMessage="Pincode must be exactly 6 digits" ValidationExpression="^\d{6}$" CssClass="text-danger">Invalid</asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblState" runat="server" Text="State:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlState" runat="server" DataTextField="StateName" DataValueField="StateID" AppendDataBoundItems="true" CssClass="form-control">
                        <asp:ListItem Text="--Select State--" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please select a State" InitialValue="0" ValidationGroup="vgSubmit" ControlToValidate="ddlState" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" onkeypress="return isNumberKey(event)" oninput="limitLength(this, 10)" CssClass="form-control" Placeholder="Enter Mobile No"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please enter Mobile No." ValidationGroup="vgSubmit" ControlToValidate="txtMobileNo" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidator3" runat="server" ControlToValidate="txtMobileNo" ErrorMessage="Mobile number must be exactly 10 digits" ValidationExpression="^\d{10}$" CssClass="text-danger">Invalid</asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblAssignProduct" runat="server" Text="Assign Product:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlAssignProduct" runat="server" DataTextField="ProductName" DataValueField="SlNo" AppendDataBoundItems="true" CssClass="form-control">
                        <asp:ListItem Text="--Select Assign Product--" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please assign a product" InitialValue="0" ValidationGroup="vgSubmit" ControlToValidate="ddlAssignProduct" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="row mb-1">
                <div class="col-sm-3">
                    <asp:Label ID="lblAssignEngineer" runat="server" Text="Assign Engineer:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <div class="dropdown">
                        <div class="dropdown-button" onclick="toggleDropdown()">Select Engineers</div>
                        <div id="DropdownContent" class="dropdown-content" >
                            <asp:CheckBoxList ID="chkAssignEngineer" runat="server" CssClass="form-check">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                </div>
            </div>

            <div>
                <div class="col-sm-12 text-center">
                    <asp:Label ID="lblResult" runat="server" Text="" Visible="False"></asp:Label>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-sm-12 text-center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="vgSubmit" Style="background-color: red; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer;" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" Style="background-color: red; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer;" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" Style="background-color: red; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer;" OnClick="btnClear_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" Style="background-color: red; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer;" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="GridTab" class="tabcontent">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ServiceCenterID" CssClass="table table-striped" OnRowCommand="onRowCommand1" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting">
            <Columns>
                <asp:TemplateField HeaderText="Service Center Name">
                    <ItemTemplate>
                        <asp:Label ID="lblServiceCenterName" runat="server" Text='<%# Eval("ServiceCenterName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address">
                    <ItemTemplate>
                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pincode">
                    <ItemTemplate>
                        <asp:Label ID="lblPincode" runat="server" Text='<%# Eval("Pincode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State">
                    <ItemTemplate>
                        <asp:Label ID="lblState" runat="server" Text='<%# Eval("StateName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mobile No.">
                    <ItemTemplate>
                        <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assign Product">
                    <ItemTemplate>
                        <asp:Label ID="lblAssignProduct" runat="server" Text='<%# Eval("AssignProductName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assign Engineer">
                    <ItemTemplate>
                        <asp:Label ID="lblAssignEngineer" runat="server" Text='<%# Eval("AssignEngineer") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("ServiceCenterID") %>' CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ServiceCenterID") %>' CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Are you sure you want to delete this user?');">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>


