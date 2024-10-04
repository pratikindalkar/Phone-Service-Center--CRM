<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="Phone_Service_Center.LoginPage" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .login-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container mt-5">
            <div class="login-header">
                <h2>Login</h2>
            </div>
            <div class="mb-3">
                <%--<asp:Label ID="lbl1" runat="server" Text="Email/Mobile No.: " CssClass="form-label"></asp:Label>--%>
                <asp:TextBox ID="txtUMob" runat="server" CssClass="form-control" placeholder="Enter your email or mobile number"></asp:TextBox>
            </div>
            <div class="mb-3">
                <%--<asp:Label ID="lbl2" runat="server" Text="Password: " CssClass="form-label"></asp:Label>--%>
                <asp:TextBox ID="txtLPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
            </div>
            <div class="mb-3 text-center">
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary" Style="background-color: red;" OnClick="btnLogin_Click" />
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-secondary" OnClick="btnRegister_Click" />
            </div>
            <div>
                <asp:Label ID="lblError" runat="server" CssClass="error-message" Text=""></asp:Label>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
