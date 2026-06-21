<%@ Page Title="Selling Report | Desi_Bite" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="SellingReport.aspx.cs" Inherits="Desi_Bite.Admin.SellingReport" %>

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

        .summary-box {
            background: #ffffff;
            color: #000000;
            padding: 15px 30px;
            border-radius: 12px;
            text-align: center;
            border: 1px solid #dee2e6;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .summary-box h4 {
            margin: 0;
            font-size: 14px;
            text-transform: uppercase;
            color: #555555;
            font-weight: 600;
        }

        .summary-box .count-text {
            margin: 5px 0 0;
            font-size: 24px;
            font-weight: bold;
            color: #000000;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="glass-card shadow-lg p-4 mt-4" style="background: rgba(255, 255, 255, 0.85); border-radius: 20px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 style="color: #333; font-weight: bold; margin: 0;">Order Dashboard</h3>
            <div class="summary-box">
                <h4>Completed Orders</h4>
                <div class="count-text">
                    <asp:Literal ID="litTotalOrders" runat="server" Text="0"></asp:Literal>
                </div>
            </div>
        </div>

        <div class="table-container">
            <asp:GridView ID="gvSellingReport" runat="server" AutoGenerateColumns="False" CssClass="table custom-grid" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="OrderNo" HeaderText="Order Number" />
                    <asp:BoundField DataField="UserId" HeaderText="Customer ID" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Completion Date" DataFormatString="{0:dd MMM yyyy}" />
                    
                    <asp:TemplateField HeaderText="Payment">
                        <ItemTemplate>
                            <span style="color: #2ecc71; font-weight: 600;">Received</span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span style="color: #27ae60; font-weight: bold;">✔ Delivered</span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="text-align: center; padding: 30px; color: #999;">No delivered orders found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>