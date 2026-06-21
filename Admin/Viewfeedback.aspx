<%@ Page Title="Feedback Management" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Viewfeedback.aspx.cs" Inherits="Desi_Bite.Admin.Viewfeedback" %>

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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="glass-card shadow-lg p-4 mt-4" style="background: rgba(255, 255, 255, 0.85); border-radius: 20px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 style="color: #333; font-weight: bold; margin: 0;">Feedback Dashboard</h3>
        </div>

        <div class="table-container">
            <asp:GridView ID="gvFeedback" runat="server" CssClass="table custom-grid" AutoGenerateColumns="false" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="feedback_id" HeaderText="ID" />
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="phone" HeaderText="Phone" />
                    <asp:BoundField DataField="msg" HeaderText="Message" />
                    <asp:BoundField DataField="rating" HeaderText="Rating" />
                    <asp:BoundField DataField="created_at" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                </Columns>
                <EmptyDataTemplate>
                    <div style="text-align: center; padding: 30px; color: #999;">No feedback received yet.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>