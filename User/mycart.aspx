<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mycart.aspx.cs" Inherits="Desi_Bite.User.mycart" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart | Desi Bite</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        :root {
            --main-blue: #0047e1;
            --bg: #f5f8ff;
            --text: #1a1a1a;
            --border: #e6e9f0;
            --grey-text: #6d6d6d;
        }

        body {
            background: var(--bg);
            font-family: 'Inter', 'Segoe UI', sans-serif;
            margin: 0;
            color: var(--text);
        }

        .header {
            background: var(--main-blue);
            color: white;
            padding: 15px 60px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .user-icons {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .icon-btn {
            color: white;
            font-size: 18px;
            text-decoration: none;
            position: relative;
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -10px;
            background: white;
            color: var(--main-blue);
            font-size: 10px;
            padding: 2px 5px;
            border-radius: 50%;
            font-weight: 700;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .cart-card-main {
            background: white;
            border-radius: 12px;
            padding: 35px 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.02);
        }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 15px;
        }

        .title-text {
            font-size: 24px;
            font-weight: 700;
            color: var(--text);
        }

        .cart-item {
            display: flex;
            padding: 25px 0;
            border-bottom: 1px solid var(--border);
            align-items: center;
            gap: 20px;
        }

        .item-image-wrapper {
            width: 90px;
            height: 90px;
            border: 1px solid var(--border);
            border-radius: 10px;
            padding: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #fff;
        }

        .item-image-wrapper img {
            max-width: 80%;
            max-height: 80%;
            object-fit: contain;
        }

        .qty-controls {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 10px;
        }

        .qty-btn {
            background: white;
            border: 1px solid var(--border);
            color: var(--main-blue);
            border-radius: 4px;
            padding: 2px 10px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
        }

        .price-details-card {
            margin-top: 30px;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.02);
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            border-top: 2px solid #eef2f6;
            padding-top: 20px;
            font-size: 20px;
            font-weight: 700;
            color: var(--main-blue);
        }

        .btn-checkout {
            background: var(--main-blue);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-checkout:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .empty-cart {
            text-align: center;
            padding: 60px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header class="header">
            <div class="logo">Desi Bite</div>
            <div class="user-icons">
                <a href="Default.aspx" class="icon-btn"><i class="fas fa-home"></i></a>
                <a href="mycart.aspx" class="icon-btn">
                    <i class="fas fa-shopping-bag"></i>
                    <asp:Label ID="lblCartCount" runat="server" CssClass="cart-count" Text="0"></asp:Label>
                </a>
                <a href="#" class="icon-btn"><i class="far fa-user-circle"></i></a>
            </div>
        </header>

        <main class="container">
            <asp:Panel ID="pnlCart" runat="server">
                <div class="cart-card-main">
                    <div class="cart-header">
                        <span class="title-text">Review Items</span>
                        <asp:Label ID="lblTopItemCount" runat="server" CssClass="items-count" Text="0 items"></asp:Label>
                    </div>

                    <asp:Repeater ID="rptrCart" runat="server" OnItemCommand="rptrCart_ItemCommand">
                        <ItemTemplate>
                            <div class="cart-item">
                                <div class="item-image-wrapper">
                                    <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' alt='<%# Eval("Name") %>'
                                         onerror="this.src='../templatefiels/images/about-img.png';" />
                                </div>
                                <div class="item-details">
                                    <h4 style="margin:0;"><%# Eval("Name") %></h4>
                                    <p style="color:var(--grey-text); font-size:12px; margin:5px 0;"><%# Eval("Description") %></p>
                                    <div class="qty-controls">
                                        <asp:LinkButton ID="btnMinus" runat="server" CssClass="qty-btn" CommandName="Minus" CommandArgument='<%# Eval("CartId") + "|" + Eval("Quantity") %>'>-</asp:LinkButton>
                                        <span class="qty-text"><strong><%# Eval("Quantity") %></strong></span>
                                        <asp:LinkButton ID="btnPlus" runat="server" CssClass="qty-btn" CommandName="Plus" CommandArgument='<%# Eval("CartId") + "|" + Eval("Quantity") %>'>+</asp:LinkButton>
                                    </div>
                                </div>
                                <div style="text-align:right;">
                                    <div style="font-weight:700; font-size:18px;">₹<%# Convert.ToDecimal(Eval("Total")).ToString("N0") %></div>
                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="RemoveItem" CommandArgument='<%# Eval("CartId") %>' Style="color:#ff4d4d; font-size:14px; text-decoration:none; margin-top:10px; display:inline-block;">
                                        <i class="far fa-trash-alt"></i> Remove
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="price-details-card">
                    <h3 style="margin-top:0;">Price Summary</h3>
                    <div class="price-row">
                        <span>Sub Total</span>
                        <span>₹<asp:Literal ID="litSubtotal" runat="server" /></span>
                    </div>
                    <div class="price-row">
                        <span>GST (5%)</span>
                        <span>₹<asp:Literal ID="litGST" runat="server" /></span>
                    </div>
                    <div class="price-row" style="color:green; font-weight:600;">
                        <span>Delivery Fee</span>
                        <span>FREE</span>
                    </div>
                    <div class="total-row">
                        <span>Total Payable</span>
                        <span>₹<asp:Literal ID="litTotalPayable" runat="server" /></span>
                    </div>
                    <div style="text-align: right; margin-top: 30px;">
                        <asp:Button ID="btnCheckout" runat="server" Text="Place Order" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="cart-card-main empty-cart">
                <i class="fas fa-shopping-bag" style="font-size: 50px; color: #ccc;"></i>
                <h2>Your cart is empty</h2>
                <p>Browse our menu and discover something delicious!</p>
                <a href="Restaurent.aspx" style="background: var(--main-blue); color: white; text-decoration: none; padding: 12px 30px; border-radius: 8px; display: inline-block; margin-top: 20px;">Browse Menu</a>
            </asp:Panel>
        </main>
    </form>
</body>
</html>