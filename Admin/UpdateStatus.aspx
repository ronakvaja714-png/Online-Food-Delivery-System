<%@ Page Title="Update Delivery Status" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true"
    CodeBehind="UpdateStatus.aspx.cs" Inherits="Desi_Bite.Admin.UpdateStatus"
    EnableEventValidation="false" %>

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

        .badge {
            background-color: #ffeaa7;
            color: #d63031;
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 12px;
        }

        .status-placed {
            background-color: #ffeaa7;
            color: #d35400;
        }

        .status-preparing {
            background-color: #fab1a0;
            color: #d63031;
        }

        .status-outfordelivery {
            background-color: #81ecec;
            color: #008080;
        }

        .btn-next {
            background-color: #d63031;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 50px;
            font-size: 12px;
            text-decoration: none;
        }

        .btn-next:hover {
            background-color: #2d3436;
            color: #feca57;
        }

        .option-panel {
            margin-top: 10px;
            display: flex;
            gap: 8px;
            justify-content: center;
            background: #f1f1f1;
            padding: 10px;
            border-radius: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="glass-card shadow-lg p-4 mt-4" style="background: rgba(255, 255, 255, 0.85); border-radius: 20px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 style="color: #333; font-weight: bold; margin: 0;">Update Status</h3>
        </div>

        <div class="table-container">
            <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="table custom-grid"
                DataKeyNames="OrderDetailsId" OnRowCommand="gvOrders_RowCommand" GridLines="None" EnableViewState="true">
                <Columns>
                    <asp:BoundField DataField="OrderNo" HeaderText="Order ID" />

                    <asp:TemplateField HeaderText="Current Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'
                                CssClass='<%# "badge status-" + Eval("Status").ToString().ToLower().Replace(" ", "") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd-MM-yyyy HH:mm}" />

                    <asp:TemplateField HeaderText="Update Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnShowOptions" runat="server"
                                Text="Update Status"
                                CommandName="ShowOptions"
                                CommandArgument='<%# Container.DataItemIndex %>'
                                CssClass="btn-next" />

                            <asp:Panel ID="pnlOptions" runat="server" Visible="false" CssClass="option-panel">
                                <asp:LinkButton ID="lnkPrep" runat="server" Text="Preparing"
                                    CommandName="ChangeStatus" CommandArgument='<%# Eval("OrderDetailsId") + "|Preparing" %>'
                                    CssClass="badge status-placed" />

                                <asp:LinkButton ID="lnkOut" runat="server" Text="Out for Delivery"
                                    CommandName="ChangeStatus" CommandArgument='<%# Eval("OrderDetailsId") + "|Out for Delivery" %>'
                                    CssClass="badge status-preparing" />

                                <asp:LinkButton ID="lnkDel" runat="server" Text="Delivered"
                                    CommandName="ChangeStatus" CommandArgument='<%# Eval("OrderDetailsId") + "|Delivered" %>'
                                    CssClass="badge status-outfordelivery" />
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding: 30px; text-align: center; color: #666;">No active orders found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>