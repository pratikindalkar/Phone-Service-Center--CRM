<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserMaster.aspx.cs" Inherits="Phone_Service_Center.UserMaster" %>

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
    </style>

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

        function limitLength(input, maxLength) {
            if (input.value.length > maxLength) {
                input.value = input.value.slice(0, maxLength);
            }
        }
        function prefillExpiryDate() {
            var today = new Date();
            today.setFullYear(today.getFullYear() + 1); // 1 year from now
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            var yyyy = today.getFullYear();
            document.getElementById('<%= txtExpiry.ClientID %>').value = yyyy + '-' + mm + '-' + dd;
        }
        window.onload = prefillExpiryDate

        window.onload = function () {
            prefillExpiryDate();
        };

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
            prefillExpiryDate();
            document.getElementsByClassName("tablinks")[0].click(); 
        };
    </script>

    <div class="tab">
        <button type="button" class="tablinks" onclick="openTab(event, 'FormTab')">User Form</button>
        <button type="button" class="tablinks" onclick="openTab(event, 'GridTab')">User Grid</button>
    </div>

    <div id="FormTab" class="tabcontent">
        <div class="container">
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl1" runat="server" Text="User Name:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtUName" runat="server" onkeypress="return allowOnlyLetters(event)" MaxLength="50" CssClass="form-control" Placeholder="Enter User Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter User Name" ValidationGroup="vgSubmit" ControlToValidate="txtUName" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorUName" runat="server" ControlToValidate="txtUName" ErrorMessage="Only letters allowed, minimum 3 characters." ValidationExpression="^[a-zA-Z]{3,50}$" CssClass="text-danger"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl2" runat="server" Text="Mobile No.:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtMob" runat="server" onkeypress="return isNumberKey(event)" MaxLength="10" CssClass="form-control" Placeholder="Enter Mobile No."></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorMob" runat="server" ErrorMessage="Please enter Mobile No." ValidationGroup="vgSubmit" ControlToValidate="txtMob" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorMob" runat="server" ControlToValidate="txtMob" ErrorMessage="Invalid mobile number, must be 10 digits." ValidationExpression="^\d{10}$" CssClass="text-danger"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl3" runat="server" Text="E-mail:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="Please enter E-mail" ValidationGroup="vgSubmit" ControlToValidate="txtEmail" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl4" runat="server" Text="Address:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" MaxLength="400" CssClass="form-control" Placeholder="Enter Address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAddress" runat="server" ErrorMessage="Please enter Address" ValidationGroup="vgSubmit" ControlToValidate="txtAddress" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl5" runat="server" Text="Pincode:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPincode" runat="server" MaxLength="6" onkeypress="return isNumberKey(event)" CssClass="form-control" Placeholder="Enter Pin Code"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPincode" runat="server" ErrorMessage="Please enter Pincode" ValidationGroup="vgSubmit" ControlToValidate="txtPincode" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorPincode" runat="server" ControlToValidate="txtPincode" ErrorMessage="Invalid pincode, must be 6 digits." ValidationExpression="^\d{6}$" CssClass="text-danger"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl6" runat="server" Text="State:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlState" runat="server" DataTextField="StateName" DataValueField="StateID" AppendDataBoundItems="true" CssClass="form-control">
                        <asp:ListItem Text="--Select State--" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorState" runat="server" ControlToValidate="ddlState" InitialValue="0" ErrorMessage="Please select a State" ValidationGroup="vgSubmit" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl7" runat="server" Text="User Category:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlUserCategory" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Select Category">Select Category</asp:ListItem>
                        <asp:ListItem Value="Admin">Admin</asp:ListItem>
                        <asp:ListItem Value="Engineer">Engineer</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategory" runat="server" ControlToValidate="ddlUserCategory" InitialValue="0" ErrorMessage="Please select a Category" ValidationGroup="vgSubmit" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl8" runat="server" Text="Password:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Enter Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ErrorMessage="Please enter Password" ValidationGroup="vgSubmit" ControlToValidate="txtPassword" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password must be 8-20 characters, include at least one uppercase letter, one number, and one special character." ValidationExpression="^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).{8,20}$" CssClass="text-danger"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl9" runat="server" Text="Password Expiry Date:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtExpiry" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorExpiry" runat="server" ErrorMessage="Please enter the Password Expiry Date" ValidationGroup="vgSubmit" ControlToValidate="txtExpiry" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl10" runat="server" Text="Password Question:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlPasswordQuestion" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Select a Security Question">Select a Security Question</asp:ListItem>
                        <asp:ListItem Value="What was your first pet's name?">What was your first pet's name?</asp:ListItem>
                        <asp:ListItem Value="What was the name of your first school?">What was the name of your first school?</asp:ListItem>
                        <asp:ListItem Value="What city were you born in?">What city were you born in?</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorQuestion" runat="server" ControlToValidate="ddlPasswordQuestion" InitialValue="0" ErrorMessage="Please select a Password Question" ValidationGroup="vgSubmit" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl11" runat="server" Text="Password Answer:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPasswordAnswer" runat="server" MaxLength="50" CssClass="form-control" Placeholder="Enter Answer"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorAnswer" runat="server" ErrorMessage="Please provide an answer to your Password Question" ValidationGroup="vgSubmit" ControlToValidate="txtPasswordAnswer" CssClass="text-danger">Required</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl12" runat="server" Text="Status:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:CheckBox ID="chkIsActive" runat="server" Text=" Is Active" />
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-sm-3">
                    <asp:Label ID="lbl13" runat="server" Text="Profile Picture:" CssClass="form-label"></asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:Image ID="imgProfilePicture" runat="server" CssClass="profile-img" Width="100px" Height="100px" />
                    <asp:FileUpload ID="fileUploadImage" runat="server" />
                    <asp:CustomValidator ID="CustomValidatorFileUpload" runat="server"
                        ClientValidationFunction="validateFile"
                        ErrorMessage="Please upload a valid image file (.jpg, .jpeg, .png)"
                        ValidationGroup="vgSubmit"
                        CssClass="text-danger" />
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
            <div>
                <div class="col-sm-12 text-center">
                    <asp:Label ID="lblResult" runat="server" Text="" Visible="False"></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <div id="GridTab" class="tabcontent">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID" CssClass="table table-striped" OnRowCommand="onRowCommand1" OnRowEditing="GridView1_RowEditing" OnRowDeleting="OnRowDeleting1">
            <Columns>
                <asp:TemplateField HeaderText="User Name">
                    <ItemTemplate>
                        <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Mobile No.">
                    <ItemTemplate>
                        <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
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

                <asp:TemplateField HeaderText="User Category">
                    <ItemTemplate>
                        <asp:Label ID="lblUserCategory" runat="server" Text='<%# Eval("UserCategory") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Profile Image">
                    <ItemTemplate>
                        <asp:Literal ID="litProfileImage" runat="server" Text='<%# BindImages(Container.DataItem) %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-warning btn-sm">Edit</asp:LinkButton>
                        <asp:Button ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-danger btn-sm" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
