<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="Desi_Bite.Admin.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
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

        .badge-pending {
            background-color: #ffeaa7;
            color: #d63031;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 12px;
        }

        .badge-success {
            background-color: #55efc4;
            color: #00b894;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 12px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="order-card">
        <div class="glass-card shadow-lg p-4 mt-4" style="background: rgba(255, 255, 255, 0.85); border-radius: 20px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 style="color: #333; font-weight: bold; margin: 0;">Order Dashboard</h3>
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh List" CssClass="btn btn-sm btn-secondary" OnClick="Page_Load" />
            </div>
            <div class="table-container">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False"
                    CssClass="table custom-grid" Width="100%"
                    EmptyDataText="No orders placed yet.">
                    <Columns>
                        <asp:BoundField DataField="OrderNo" HeaderText="Order ID" />
                        <asp:BoundField DataField="UserName" HeaderText="Customer" />
                        <asp:BoundField DataField="ProductName" HeaderText="Item Name" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" ItemStyle-HorizontalAlign="Center" />

                        <asp:TemplateField HeaderText="Total Price">
                            <ItemTemplate>
                                ₹<%# Eval("TotalPrice", "{0:N2}") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# Eval("Status").ToString() == "Confirmed" ? "badge-success" : "badge-pending" %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>