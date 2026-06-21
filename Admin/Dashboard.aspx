<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Desi_Bite.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="card bg-primary text-white shadow">
                    <div class="card-body">
                        <h5>Total Orders</h5>
                        <h2>
                            <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card bg-success text-white shadow">
                    <div class="card-body">
                        <h5>Total Revenue</h5>
                        <h2>
                            <asp:Label ID="lblTotalRevenue" runat="server" Text="₹ 0"></asp:Label></h2>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card bg-warning text-dark shadow">
                    <div class="card-body">
                        <h5>Restaurants</h5>
                        <h2>
                            <asp:Label ID="lblTotalRestaurants" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card bg-danger text-white shadow">
                    <div class="card-body">
                        <h5>Active Users</h5>
                        <h2>
                            <asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>
        </div>


    </div>
</asp:Content>
