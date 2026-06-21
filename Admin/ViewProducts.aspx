<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ViewProducts.aspx.cs" Inherits="Desi_Bite.Admin.ViewProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .item-img {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex justify-content-between align-items-center mb-4 px-3">

        <h3 class="ms-4" style="color: #333; font-weight: bold;">Restaurant Menu Items</h3>

        <asp:HyperLink ID="hlAddProduct" runat="server" CssClass="btn btn-primary me-4 shadow-sm" Style="border-radius: 10px; padding: 10px 20px;">
        <i class="fa-solid fa-plus me-1"></i> Add New Item
        </asp:HyperLink>

    </div>
    <div class="container mt-4">
        <div class="product-card">
            <h3 class="mb-4">Restaurant Menu Items</h3>
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" CssClass="table table-hover">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='<%# ResolveUrl("~/" + Eval("ImageUrl").ToString()) %>' class="item-img"
                                onerror="this.src='../Images/default.png';" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Item Name" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0}" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsActive")) ? "<span class='badge bg-success'>Available</span>" : "<span class='badge bg-danger'>Not Available</span>" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

          
            <asp:Label ID="lblMessage" runat="server" Text="No items found for this restaurant." Visible="false" CssClass="text-danger"></asp:Label>

            <div class="mt-3">
                <a href="Restaurent.aspx" class="btn btn-secondary">Back to Restaurants</a>
            </div>
        </div>
    </div>
</asp:Content>
