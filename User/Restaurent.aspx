<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Restaurent.aspx.cs" Inherits="Desi_Bite.User.Restaurent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .restaurant-card {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        .restaurant-card:hover {
            transform: translateY(-5  px);
        }
        .res-image {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        .res-title { font-weight: bold; color: #333; font-size: 1.25rem; }
        .res-meta { font-size: 0.9rem; color: #666; }
        .btn-view-menu {
            background: linear-gradient(135deg, #ff9900 0%, #ff6600 100%);
            color: white;
            border-radius: 25px;
            border: none;
            padding: 8px 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <h2 class="text-center mb-4">Our Restaurants</h2>
        <div class="row">
            <asp:Repeater ID="rptrRestaurants" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm border-0" style="border-radius: 15px; overflow: hidden;">
                            <img src='<%# ResolveUrl(Eval("Photo").ToString()) %>' class="card-img-top" style="height: 200px; object-fit: cover;" alt="restaurant"><div class="card-body">
                                <h5 class="card-title fw-bold"><%# Eval("Restaurant_Name") %></h5>
                                <p class="card-text text-muted small"><i class="fas fa-map-marker-alt"></i> <%# Eval("Location") %></p>
                                <a href='Menu.aspx?ResId=<%# Eval("Restaurant_ID") %>' class="btn btn-warning w-100 rounded-pill">Explore Menu</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>