<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRestaurant.aspx.cs" Inherits="Desi_Bite.Admin.AddRestaurant" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Restaurant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.2)), url('<%= ResolveUrl("~/Image/finalbackground.jpg") %>');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
            padding: 20px;
        }

        .main-wrapper {
            width: 100%;
            max-width: 800px;
        }

        .glass-card {
            background: rgba(0, 0, 0, 0.5); 
            backdrop-filter: blur(15px); 
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.5);
            color: white;
        }

        .form-label {
            font-weight: 600;
            color: #ffffff;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.6);
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

        .btn-save {
            background-color: #28a745;
            border: none;
            padding: 12px 40px;
            font-weight: bold;
            border-radius: 10px;
            transition: 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-save:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-wrapper">
            
            <div class="glass-card">
                <h2 class="text-center mb-5">RESTAURANT MANAGEMENT</h2>
                
                <asp:HiddenField ID="hfId" runat="server" />

                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label">Restaurant Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="e.g. Desi Delight" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Contact No." />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="info@restaurant.com" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Location</label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Enter Address" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Open Hours</label>
                        <asp:TextBox ID="txtOpenHours" runat="server" CssClass="form-control" placeholder="10:00 AM - 11:00 PM" />
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Upload Photo</label>
                        <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="text-center mt-5">
                    <asp:Button ID="btnSave" runat="server" Text="Add Restaurant"
                        CssClass="btn btn-success btn-save" OnClick="btnSave_Click" />
                    
                    <asp:Button ID="btnUpdate" runat="server" Text="Update Details"
                        CssClass="btn btn-warning btn-save ms-2" Visible="false" OnClick="btnUpdate_Click" />
                </div>
            </div>

        </div>
    </form>
</body>
</html>