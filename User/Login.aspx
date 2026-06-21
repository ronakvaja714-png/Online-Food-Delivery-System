<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Desi_Bite.User.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        .hero-banner {
    height: 300px;
    background-image: url('../Images/web-banner.jpg');
    background-size: cover;
    background-position: center;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
    <div class="row align-items-center">

        <div class="hero-banner d-flex align-items-center">
    <h1 class="text-white ms-5">Welcome to Foodie</h1>
</div>


        <div class="col-md-6 text-center">
            <img src="../Images/newbg.jpg" class="img-fluid" alt="Login Image" />
        </div>

        
        <div class="col-md-6">
            <h3 class="mb-4">Login</h3>

            <asp:TextBox ID="txtUsername" runat="server"
                CssClass="form-control mb-3"
                Placeholder="Enter Username" />

            <asp:TextBox ID="txtPassword" runat="server"
                CssClass="form-control mb-3"
                TextMode="Password"
                Placeholder="Enter Password" />

            <asp:Button ID="btnLogin" runat="server"
                Text="Login"
                CssClass="btn btn-success px-4"
                OnClick="btnLogin_Click" />

            <span class="ms-3">
                New User?
                <a href="Register.aspx">Register here</a>
            </span>

            <br /><br />

            <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>
        </div>

    </div>
</div>
    </form>
</body>
</html>
