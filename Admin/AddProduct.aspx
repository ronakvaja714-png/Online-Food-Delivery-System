<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="Desi_Bite.Admin.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .add-container { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); max-width: 600px; margin: 40px auto; }
        .title { font-weight: bold; color: #333; text-align: center; margin-bottom: 25px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="add-container">
        <h2 class="title">Add New Item</h2>
        
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Dish name"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Price (₹)</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Quantity</label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="1"></asp:TextBox>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload Image</label>
            <asp:FileUpload ID="fuProductImg" runat="server" CssClass="form-control" />
        </div>

        <div class="mb-4">
            <asp:CheckBox ID="chkIsActive" runat="server" Text="&nbsp;Available?" Checked="true" />
        </div>

        <div class="d-grid">
            <asp:Button ID="btnSave" runat="server" Text="Add Product" CssClass="btn btn-primary btn-lg" OnClick="btnSave_Click" />
        </div>
    </div>
</asp:Content>