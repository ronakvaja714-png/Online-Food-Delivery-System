<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserSignUp.aspx.cs" Inherits="Desi_Bite.User.UserSignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account | Desi Bite</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style>
        body {
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 800px;
        }

        .form-title {
            font-weight: 700;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
            letter-spacing: 1px;
        }

        .input-group-text {
            background-color: transparent;
            border-right: none;
            color: #9b59b6;
        }

        .form-control {
            border-left: none;
            border-radius: 0 8px 8px 0;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #ced4da;
        }

        .btn-signup {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            border: none;
            color: white;
            padding: 12px;
            border-radius: 8px;
            font-weight: 600;
            transition: 0.3s;
            width: 100%;
            margin-top: 10px;
        }

        .btn-signup:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(155, 89, 182, 0.4);
            color: white;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <h2 class="form-title">Join Desi Bite</h2>
            
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Full Name" Required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-at"></i></span>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username" Required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email Address" TextMode="Email" Required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile Number" Required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="col-12">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Complete Address" TextMode="MultiLine" Rows="2" Required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-map-pin"></i></span>
                        <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Post Code" Required="true"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password" Required="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-signup" OnClick="btnRegister_Click" />

            <div class="login-link">
                Already have an account? <a href="UserLoginChoice.aspx" class="text-decoration-none" style="color: #9b59b6; font-weight:600;">Login here</a>
            </div>
        </div>
    </form>
</body>
</html>
