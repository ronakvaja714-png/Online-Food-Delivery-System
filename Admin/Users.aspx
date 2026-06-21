<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Desi_Bite.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 10px;
        }

        .custom-grid {
            border: none !important;
            margin-bottom: 0;
        }

        .custom-grid th {
            background-color: transparent !important;
            color: #333 !important;
            font-weight: 700;
            text-transform: none;
            border: none !important;
            padding: 20px !important;
            font-size: 15px;
        }

        .custom-grid td {
            background-color: transparent !important;
            border: none !important;
            padding: 15px 20px !important;
            color: #444;
            vertical-align: middle;
            border-bottom: 1px solid #eee !important;
        }

        .custom-grid tr:hover {
            background-color: rgba(0, 0, 0, 0.02);
            transition: 0.3s;
        }

        .user-img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #d63031;
        }

        .user-name {
            font-weight: bold;
            color: #d63031;
            font-size: 16px;
        }

        .contact-info {
            font-size: 13px;
            color: #636e72;
        }

        .badge-zip {
            background: #dfe6e9;
            color: #2d3436;
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 11px;
            display: inline-block;
            margin-top: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="glass-card shadow-lg p-4 mt-4" style="background: rgba(255, 255, 255, 0.85); border-radius: 20px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 style="color: #333; font-weight: bold; margin: 0;">User Dashboard</h3>
        </div>

        <div class="table-container">
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table custom-grid" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Full Name">
                        <ItemTemplate>
                            <div class="user-name"><%# Eval("Name") %></div>
                            <div class="contact-info">@<%# Eval("Username") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Contact Details">
                        <ItemTemplate>
                            <div><strong>📞</strong> <%# Eval("Mobile") %></div>
                            <div class="contact-info"><strong>📧</strong> <%# Eval("Email") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <div style="max-width: 250px; font-size: 13px;"><%# Eval("Address") %></div>
                            <span class="badge-zip">PostCode: <%# Eval("PostCode") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="CreatedDate" HeaderText="Joined Date" DataFormatString="{0:dd MMM yyyy}" />
                </Columns>
                <EmptyDataTemplate>
                    <div style="text-align: center; padding: 40px; color: #b2bec3;">
                        <h4>No Registered Users Found</h4>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>