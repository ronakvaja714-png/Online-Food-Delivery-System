<%@ Page Title="All Dishes" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="AllProducts.aspx.cs" Inherits="Desi_Bite.User.AllProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .product-card {
            border-radius: 15px;
            transition: 0.3s;
            overflow: hidden;
            border: 1px solid #eee;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.12);
            }

        .res-name-label {
            font-size: 0.75rem;
            background: #fff3cd;
            color: #856404;
            padding: 3px 10px;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .food-img {
            height: 190px;
            width: 100%;
            object-fit: cover;
        }

       /* Stack buttons vertically with a gap */
.button-container {
    display: flex;
    flex-direction: column;
    gap: 12px; 
    margin-top: 15px;
    padding: 0 5px;
}

/* The Yellow Pill Style from the photo */
.btn-yellow-pill {
    background: #ffb800; /* Fallback */
    background: linear-gradient(180deg, #ffc93c 0%, #ffb800 100%);
    color: #003049; /* Dark contrast text */
    border: 1px solid #e6a700;
    border-radius: 50px; /* Perfect pill shape */
    padding: 10px 20px;
    font-weight: 600;
    font-size: 15px;
    width: 100%;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    text-align: center;
    text-decoration: none;
    display: inline-block;
}

.btn-yellow-pill:hover {
    background: linear-gradient(180deg, #ffb800 0%, #e6a700 100%);
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    color: #000;
}

/* Optional: if you want the 'Order Now' to look slightly more prominent */
.btn-order-now {
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">All Menu Items</h2>
            <p class="text-muted">Discover the best dishes from all our restaurants</p>
        </div>

        <div class="row">
            <asp:Repeater ID="rptrAllProducts" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="card product-card h-100">
                            <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' class="food-img"
                                onerror="this.src='../Images/default-food.png';" alt="food">

                            <div class="card-body d-flex flex-column">
                                <div>
                                    <span class="res-name-label">
                                        <i class="fas fa-store me-1"></i><%# Eval("Restaurant_Name") %>
                                    </span>
                                </div>

                                <h5 class="card-title fw-bold"><%# Eval("Name") %></h5>
                                <p class="card-text text-muted small flex-grow-1"><%# Eval("Description") %></p>
                                <h6 class="text-dark fw-bold mb-3">Price: ₹<%# Eval("Price") %></h6>

                                <div class="mt-auto">

                                    

                                    <div class="button-container">
                                        <asp:Button ID="btnAddToCart" runat="server"
                                            Text="Add to Cart"
                                            OnClick="btnAddToCart_Click"
                                            CommandArgument='<%# Eval("ProductId") %>'
                                            CssClass="btn-yellow-pill btn-order-now" />

                                     
                                        <asp:LinkButton ID="btnOrderNow" runat="server"
        Text="Order Now"
        OnClick="btnOrderNow_Click" 
        CommandArgument='<%# Eval("ProductId") %>'
        CssClass="btn-yellow-pill btn-order-now" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
