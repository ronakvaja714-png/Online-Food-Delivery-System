<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Restaurent.aspx.cs" Inherits="Desi_Bite.Admin.Restaurent" %>

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

        .res-photo {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .action-btn {
            width: 35px;
            height: 35px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 14px;
            text-decoration: none !important;
            transition: all 0.3s ease;
        }

        .edit-link {
            background-color: #e3f9f1;
            color: #27ae60 !important;
        }

        .edit-link:hover {
            background-color: #27ae60;
            color: white !important;
        }

        .delete-link {
            background-color: #fdeaea;
            color: #eb5757 !important;
        }

        .delete-link:hover {
            background-color: #eb5757;
            color: white !important;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="glass-card shadow-lg p-4 mt-4" style="background: rgba(255, 255, 255, 0.85); border-radius: 20px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 style="color: #333; font-weight: bold; margin: 0;">Restaurant Dashboard</h3>
            <asp:LinkButton ID="btnAddRestaurant" runat="server" OnClick="btnAddRestaurant_Click"
                CssClass="btn btn-primary shadow-sm"
                Style="border-radius: 10px; padding: 10px 20px; background-color: #3498db; border: none; font-weight: 600;">
                <i class="fa-solid fa-plus me-2"></i> Add Restaurant
            </asp:LinkButton>
        </div>

        <div class="table-container">
            <asp:GridView ID="gvRestaurant" runat="server"
                AutoGenerateColumns="False"
                CssClass="table custom-grid"
                DataKeyNames="Restaurant_ID"
                OnRowEditing="gvRestaurant_RowEditing"
                OnRowDeleting="gvRestaurant_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="Photo">
                        <ItemTemplate>
                            <img src='<%# ResolveUrl(Eval("Photo").ToString()) %>' class="res-photo" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Restaurant Name">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlViewProducts" runat="server"
                                Text='<%# Eval("Restaurant_Name") %>'
                                NavigateUrl='<%# "ViewProducts.aspx?resId=" + Eval("Restaurant_ID") %>'
                                Font-Bold="true" Style="text-decoration: none; color: #3498db;">
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="Location" HeaderText="Location" />
                    <asp:BoundField DataField="Open_Hours" HeaderText="Timings" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CssClass="action-btn edit-link" ToolTip="Edit">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="action-btn delete-link ms-2"
                                ToolTip="Delete" OnClientClick="return confirm('Do you want to delete this restaurant?');">
                                <i class="fa-solid fa-trash-can"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>