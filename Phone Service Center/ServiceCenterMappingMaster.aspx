<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ServiceCenterMappingMaster.aspx.cs" Inherits="Phone_Service_Center.ServiceCenterMappingMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
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

        .dropdown-container {
            display: flex;
            align-items: center;
            width: 100%;
        }

        .dropdown-button {
            cursor: pointer;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
            text-align: left;
            margin-left: 10px;
            flex: 1;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            z-index: 1;
            width: 100%;
            max-height: 150px;
            overflow-y: auto;
            padding: 10px;
        }

        .show {
            display: block;
        }

        .form-label {
            padding-right: 10px;
        }

        .row {
            margin-bottom: 5px;
        }

        .mb-3 {
            margin-bottom: 0.5rem;
        }
    </style>

    <script type="text/javascript">
        function togglePincodeDropdown() {
            var dropdownContent = document.getElementById("pincodeDropdownContent");
            dropdownContent.classList.toggle("show");
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
            document.getElementsByClassName("tablinks")[0].click(); // Automatically open the first tab
        };
    </script>

    <div class="tab">
        <button type="button" class="tablinks" onclick="openTab(event, 'FormTab')">Service Center Mapping Form</button>
        <button type="button" class="tablinks" onclick="openTab(event, 'GridTab')">Service Center Mapping Grid</button>
    </div>

    <div id="FormTab" class="tabcontent">
        <div class="container mt-4">
            <div class="form-group row mb-1">
                <label for="ddlServiceCenter" class="col-sm-3 col-form-label form-label">Service Center:</label>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlServiceCenter" runat="server" CssClass="form-control">
                        <asp:ListItem Value="0">Select Service Center</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a Service Center" InitialValue="0" ControlToValidate="ddlServiceCenter" ValidationGroup="vgSubmit" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="form-group row mb-1">
                <label for="chkPincodeList" class="col-sm-3 col-form-label form-label">Pincode:</label>
                <div class="col-sm-9">
                    <div class="dropdown-container">
                        <div class="dropdown">
                            <div class="dropdown-button" id="pincodeDropdownButton" onclick="togglePincodeDropdown()">
                                Select Pincode
                            </div>
                            <div id="pincodeDropdownContent" class="dropdown-content">
                                <asp:CheckBoxList ID="chkPincodeList" runat="server">
                                    <asp:ListItem Text="100001" Value="100001"></asp:ListItem>
                                    <asp:ListItem Text="100002" Value="100002"></asp:ListItem>
                                    <asp:ListItem Text="100003" Value="100003"></asp:ListItem>
                                    <asp:ListItem Text="100004" Value="100004"></asp:ListItem>
                                    <asp:ListItem Text="100005" Value="100005"></asp:ListItem>
                                    <asp:ListItem Text="100006" Value="100006"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-sm-12 text-center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="vgSubmit" Style="background-color: red; color: white; border: none; padding: 10px 20px; font-size: 16px; cursor: pointer;" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="GridTab" class="tabcontent">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MappingID" CssClass="table table-striped">
            <Columns>
                <asp:TemplateField HeaderText="Service Center">
                    <ItemTemplate>
                        <asp:Label ID="lblServiceCenterName" runat="server" Text='<%# Eval("ServiceCenter") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pincode">
                    <ItemTemplate>
                        <asp:Label ID="lblPincode" runat="server" Text='<%# Eval("Pincode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
