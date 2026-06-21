<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="Desi_Bite.User.Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .menu-section {
            background-color: #f8f9fa;
            padding: 60px 0;
        }

        .section-title {
            font-weight: 800;
            color: #222;
            margin-bottom: 40px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }


        .food-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s ease;
            border: none;
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            position: relative;
        }

            .food-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.15);
            }

        .img-container {
            height: 220px;
            overflow: hidden;
            background: #f1f1f1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .img-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s ease;
            }

        .food-card:hover .img-container img {
            transform: scale(1.1);
        }

        .food-details {
            padding: 20px;
        }

        .food-name {
            font-weight: 700;
            font-size: 1.25rem;
            color: #333;
            margin-bottom: 8px;
        }

        .food-desc {
            font-size: 0.9rem;
            color: #777;
            height: 45px;
            overflow: hidden;
            margin-bottom: 15px;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }

        .price-tag {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffbe33;
        }

        .btn-add-cart {
            background: #222;
            color: #fff;
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 600;
            transition: 0.3s;
            text-decoration: none !important;
        }

            .btn-add-cart:hover {
                background: #ffbe33;
                color: #222;
            }


        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: rgba(255, 255, 255, 0.9);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: bold;
            color: #28a745;
            z-index: 10;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <h2 class="text-center mb-4">Our Menu</h2>
        <div class="row">
            <asp:Repeater ID="rptrMenu" runat="server">
                <ItemTemplate>
                    <div class="col-md-3 mb-4">
                        <div class="card h-100 shadow-sm">
                            <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' alt='<%# Eval("Name") %>'
                                onerror="this.src='../Images/default-food.png';" />
                            <div class="card-body text-center">
                                <h5 class="card-title fw-bold"><%# Eval("Name") %></h5>
                                <p class="card-text small text-muted"><%# Eval("Description") %></p>
                                <p class="card-text text-success fw-bold">₹ <%# Eval("Price") %></p>

                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                                    CssClass="btn btn-warning w-100 rounded-pill mb-2 fw-bold"
                                    OnClick="btnAddToCart_Click"
                                    CommandArgument='<%# Eval("ProductId") %>' />
                                <a href='OrderSummary.aspx?ProdId=<%# Eval("ProductId") %>' class="btn btn-warning w-100 rounded-pill mb-2">Order Now</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
