<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditRestaurant.aspx.cs" Inherits="Desi_Bite.Admin.EditRestaurant" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Restaurant Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('<%= ResolveUrl("~/Image/finalbackground.jpg") %>');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
            padding: 20px;
        }

        .glass-card {
            background: rgba(0, 0, 0, 0.6); 
            backdrop-filter: blur(15px); 
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            color: white;
            width: 100%;
            max-width: 850px;
        }

        .form-label {
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 8px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white !important;
            border-radius: 10px;
            padding: 12px;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: #ffc107;
            box-shadow: none;
        }

        .btn-update {
            background-color: #28a745;
            border: none;
            padding: 12px 40px;
            font-weight: bold;
            border-radius: 10px;
            transition: 0.3s;
            color: white;
        }

        .btn-update:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .btn-cancel {
            background-color: rgba(255, 255, 255, 0.2);
            border: 1px solid white;
            padding: 12px 40px;
            font-weight: bold;
            border-radius: 10px;
            color: white;
            text-decoration: none;
        }

        .preview-img {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            object-fit: cover;
            border: 2px solid #ffc107;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="glass-card">
            <h2 class="text-center mb-5" style="letter-spacing: 2px;">UPDATE RESTAURANT</h2>
            
            <div class="row g-4">
                <div class="col-md-6">
                    <label class="form-label">Restaurant Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Location</label>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Open Hours</label>
                    <asp:TextBox ID="txtOpenHours" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Update Photo</label>
                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                    <asp:Image ID="imgCurrent" runat="server" CssClass="preview-img" />
                    <asp:HiddenField ID="hfCurrentPhoto" runat="server" />
                </div>
            </div>

            <div class="text-center mt-5">
                <asp:Button ID="btnSubmitUpdate" runat="server" Text="Update Details"
                    CssClass="btn btn-update" OnClick="btnSubmitUpdate_Click" />
                
                <a href="Restaurent.aspx" class="btn btn-cancel ms-3">Cancel</a>
            </div>
        </div>
    </form>
</body>
</html>