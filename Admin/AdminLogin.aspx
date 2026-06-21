<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="Desi_Bite.Admin.AdminLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Access | BigBite</title>
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { background: #2d3436; font-family: 'Segoe UI', sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 20px; box-shadow: 0 15px 30px rgba(0,0,0,0.5); width: 350px; border-top: 10px solid #d63031; }
        .logo { text-align: center; color: #d63031; font-size: 24px; font-weight: bold; margin-bottom: 30px; }
        .logo span { color: #feca57; }
        .input-label { display: block; margin-bottom: 5px; font-size: 13px; font-weight: 600; color: #636e72; }
        .input-field { width: 100%; padding: 12px; margin-bottom: 20px; border: 2px solid #dfe6e9; border-radius: 8px; box-sizing: border-box; transition: 0.3s; }
        .input-field:focus { border-color: #d63031; outline: none; }
        .btn-login { width: 100%; padding: 12px; background: #d63031; color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: bold; cursor: pointer; transition: 0.3s; }
        .btn-login:hover { background: #b71c1c; transform: translateY(-2px); }
        .error-label { color: #d63031; font-size: 12px; margin-top: -15px; margin-bottom: 15px; display: block; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="logo">Desi Bites <span>Admin</span></div>
            
            <label class="input-label">Admin Name</label>
            <asp:TextBox ID="txtAdminName" runat="server" CssClass="input-field" placeholder="Enter Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txtAdminName" ErrorMessage="Name required" CssClass="error-label" Display="Dynamic" />

            <label class="input-label">Security Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password required" CssClass="error-label" Display="Dynamic" />

            <asp:Button ID="btnLogin" runat="server" Text="Log In to Dashboard" CssClass="btn-login" OnClick="btnLogin_Click" />
        </div>
    </form>
</body>
</html>