<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="OrderSummary.aspx.cs" Inherits="Desi_Bite.User.OrderSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .summary-wrapper {
            padding: 40px 0;
            background-color: #f4f7f6;
            min-height: 80vh;
        }

        .order-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .order-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 25px;
            text-align: center;
        }

        .btn-qty {
            border: 1px solid #ddd;
            padding: 2px 10px;
            border-radius: 5px;
            background: #f8f9fa;
            text-decoration: none;
            color: #333;
        }

        .payment-box {
            background: #fff;
            border: 1px solid #eee;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .btn-order {
            background: #27ae60;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 10px;
            width: 100%;
            font-weight: 600;
            font-size: 1.1rem;
            cursor: pointer;
        }

            .btn-order:hover {
                background: #219150;
            }


        .cart-item-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            font-size: 0.95rem;
        }

            .cart-item-row:last-child {
                border-bottom: none;
            }

        .btn-outline-secondary {
            border: 1px solid rgba(0,0,0,0.1);
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(5px);
            transition: all 0.3s ease;
        }

            .btn-outline-secondary:hover {
                background: #ffbe33;
                color: white;
                border-color: #ffbe33;
            }
    </style>

    <script type="text/javascript">
        function confirmOrder() {
            if (confirm("Are you sure you want to place this order?")) {
                if (confirm("Second Confirmation: Are you really sure?")) {
                    if (confirm("Final Check: Proceed to confirm your order?")) {
                        return true;
                    }
                }
            }
            return false;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="summary-wrapper py-5 bg-light">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow-sm border-0 rounded-lg">
                        <div class="card-header bg-primary text-white p-4">
                            <h3 class="mb-1">Order Summary</h3>
                            <p class="mb-0 opacity-75">Verify your details before payment</p>
                        </div>
                        <div class="card-body p-4">

                            <div class="mb-4 pb-3 border-bottom">
                                <h6 class="text-muted fw-bold small mb-3 text-uppercase">Item Details</h6>

                                <asp:Panel ID="pnlSingleItem" runat="server">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="text-dark mb-1">
                                                <asp:Label ID="lblPName" runat="server"></asp:Label></h5>
                                            <div class="d-flex align-items-center mt-2">
                                                <asp:LinkButton ID="btnMinus" runat="server" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnMinus_Click">
        <i class="fa fa-minus"></i>
                                                </asp:LinkButton>

                                                <asp:Label ID="lblQty" runat="server" Text="1" CssClass="mx-3 fw-bold"></asp:Label>

                                                <asp:LinkButton ID="btnPlus" runat="server" CssClass="btn btn-sm btn-outline-secondary" OnClick="btnPlus_Click">
        <i class="fa fa-plus"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                        <div class="h5 fw-bold text-primary">₹<asp:Label ID="lblPrice" runat="server" Text="0.00"></asp:Label></div>
                                    </div>
                                </asp:Panel>

                                <asp:Repeater ID="rptrOrderItems" runat="server">
                                    <ItemTemplate>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span><%# Eval("Name") %> <small class="text-muted">(x<%# Eval("Quantity") %>)</small></span>
                                            <span class="fw-bold">₹<%# Eval("Total") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <div class="mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <h6 class="text-muted fw-bold small mb-0 text-uppercase">Delivery Address</h6>
                                    <asp:LinkButton ID="btnEditAddress" runat="server" CssClass="small text-primary text-decoration-none" OnClick="btnEditAddress_Click">Change</asp:LinkButton>
                                </div>
                                <div class="p-3 border rounded bg-white">
                                    <asp:Label ID="lblAddress" runat="server" CssClass="d-block mb-1"></asp:Label>
                                    <asp:TextBox ID="txtNewAddress" runat="server" CssClass="form-control mb-2" Visible="false" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                    <asp:Button ID="btnUpdateAddr" runat="server" Text="Update Address" CssClass="btn btn-sm btn-success" Visible="false" OnClick="btnUpdateAddr_Click" />
                                </div>
                            </div>

                            <div class="mb-4 pt-3 border-top">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Subtotal</span>
                                    <span class="fw-bold">₹<asp:Label ID="lblSubTotal" runat="server" Text="0.00"></asp:Label></span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Delivery</span>
                                    <span class="text-success fw-bold">FREE</span>
                                </div>
                                <div class="d-flex justify-content-between h4 fw-bold text-dark mt-3">
                                    <span>Total</span>
                                    <span>₹<asp:Label ID="lblGrandTotal" runat="server" Text="0.00"></asp:Label></span>
                                </div>
                            </div>

                            <div class="payment-box mb-4 p-3 border rounded bg-light">
                                <h6 class="text-muted fw-bold small mb-3 text-uppercase">Payment Method</h6>
                                <asp:RadioButtonList ID="rblPayment" runat="server" CssClass="w-100 custom-radio"
                                    AutoPostBack="true" OnSelectedIndexChanged="rblPayment_SelectedIndexChanged">
                                    <asp:ListItem Text="&nbsp;Cash On Delivery (COD)" Value="COD" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;Online Payment (Invoice Generated)" Value="Online"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;Use Loyalty Points" Value="Points"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <asp:Panel ID="pnlOnlinePayment" runat="server" Visible="false" CssClass="p-3 border rounded mb-4 bg-white shadow-sm">
                                <h6 class="fw-bold mb-3 border-bottom pb-2">Card Details</h6>
                                <div class="mb-3">
                                    <label class="small text-muted mb-1">Card Number</label>
                                    <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="1234 5678 9101 1121" MaxLength="16"></asp:TextBox>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <label class="small text-muted mb-1">Expiry</label>
                                        <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" placeholder="MM/YY"></asp:TextBox>
                                    </div>
                                    <div class="col-6">
                                        <label class="small text-muted mb-1">CVV</label>
                                        <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="123" TextMode="Password" MaxLength="3"></asp:TextBox>
                                    </div>
                                </div>
                            </asp:Panel>

                            <asp:Button ID="btnPlaceOrder" runat="server"
                                Text="Confirm & Place Order"
                                CssClass="btn btn-primary btn-lg w-100 fw-bold shadow-sm"
                                OnClientClick="return confirmOrder();"
                                OnClick="btnPlaceOrder_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
