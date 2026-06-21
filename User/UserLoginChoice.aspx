<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLoginChoice.aspx.cs" Inherits="Desi_Bite.User.UserLoginChoice" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Desi Bite - Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        body {
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
            letter-spacing: 1px;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            color: #9b59b6;
            font-size: 1.1rem;
        }

        .input-field {
            width: 100%;
            padding: 12px 12px 12px 45px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            font-size: 1rem;
            outline: none;
            transition: 0.3s;
        }

        .input-field:focus {
            border-color: #9b59b6;
            box-shadow: 0 0 5px rgba(155, 89, 182, 0.2);
        }

        .btn-login {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: 0.3s;
            width: 100%;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(155, 89, 182, 0.4);
        }

        .btn-guest {
            background: #6c757d;
            border: none;
            color: white;
            padding: 10px;
            border-radius: 8px;
            font-weight: 500;
            transition: 0.3s;
            width: 100%;
            cursor: pointer;
            margin-top: 15px;
        }

        .btn-guest:hover {
            background: #5a6268;
        }

        .signup-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.95rem;
            color: #555;
        }

        .signup-link a {
            color: #9b59b6;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="form-title">Desi Bite Login</div>

            <div class="input-wrapper">
                <i class="fas fa-envelope input-icon"></i>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" Placeholder="Email Address"></asp:TextBox>
            </div>

            <div class="input-wrapper">
                <i class="fas fa-lock input-icon"></i>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" Placeholder="Password"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn-login" OnClick="btnLogin_Click" />

            <asp:Button ID="btnGuest" runat="server" Text="Continue as Guest" CssClass="btn-guest" 
                OnClick="btnGuest_Click" CausesValidation="false" />

            <div class="signup-link">
                Don't have an account? <a href="UserSignUp.aspx">Join Desi Bite</a>
            </div>
        </div>
    </form>
</body>
</html>