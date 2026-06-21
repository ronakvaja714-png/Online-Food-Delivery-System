<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Desi_Bite.User.profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Profile | Desi Bite</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        :root {
            --teal-bg: #117a8b;
            --card-white: #ffffff;
            --text-dark: #333333;
            --text-light: #777777;
            --blue-btn: #2b87f5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background: var(--teal-bg);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .profile-wrapper {
            display: flex;
            gap: 30px;
            max-width: 1000px;
            width: 100%;
            align-items: flex-start;
        }

        .left-side {
            display: flex;
            flex-direction: column;
            gap: 30px;
            flex: 1;
        }

        .right-side {
            flex: 1.5;
        }

        .frame {
            background: var(--card-white);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            position: relative;
        }

        .header-box {
            margin-bottom: 25px;
        }

            .header-box h4 {
                font-size: 20px;
                color: var(--text-dark);
            }

            .header-box p {
                font-size: 14px;
                color: var(--text-light);
            }

        .menu-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-top: 1px solid #f0f0f0;
            color: var(--text-dark);
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
        }

            .menu-item i {
                margin-right: 12px;
                width: 20px;
            }

        .input-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 0;
            border-bottom: 1px solid #f5f5f5;
        }

            .input-row .label {
                color: var(--text-dark);
                font-weight: 500;
                font-size: 15px;
            }

            .input-row .value {
                color: var(--text-light);
                text-align: right;
                border: none;
                outline: none;
                background: transparent;
                width: 60%;
                font-size: 15px;
            }

        .btn-save {
            background: var(--blue-btn);
            color: #fff;
            border: none;
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: bold;
            margin-top: 25px;
            cursor: pointer;
            width: 100%;
        }

        .close-btn {
            position: absolute;
            top: 20px;
            right: 20px;
            color: #ccc;
            cursor: pointer;
        }

        .gv-style th {
            text-align: left;
            padding: 10px;
            border-bottom: 2px solid #eee;
        }

        .gv-style td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="profile-wrapper">
            <div class="left-side">
                <div class="frame">
                    <div class="header-box">
                        <h4>
                            <asp:Literal ID="litNameMenu" runat="server" Text="Your name" /></h4>
                        <p>
                            <asp:Literal ID="litEmailMenu" runat="server" Text="yourname@gmail.com" /></p>
                    </div>
                    <div class="profile-card" style="background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(10px); border-radius: 15px; padding: 15px; text-align: center; margin-bottom: 20px; border: 1px solid rgba(255,255,255,0.3);">
                        <h5 style="color: #333; font-size: 16px;">Reward Points</h5>
                        <div style="font-size: 28px; font-weight: bold; color: #ff4757;">
                            <asp:Label ID="lblUserPoints" runat="server" Text="0"></asp:Label>
                        </div>
                        <p style="color: #555; font-size: 11px; margin-bottom: 0;">(5 points = 1 rs.)</p>
                    </div>

                    <asp:HyperLink ID="hlHome" runat="server" NavigateUrl="Default.aspx" CssClass="menu-item">
                    <span><i class="fa-solid fa-house"></i> Home</span>
                    </asp:HyperLink>
                    <asp:LinkButton ID="lnkMyOrders" runat="server" CssClass="menu-item" OnClick="lnkMyOrders_Click" CausesValidation="false">
                    <span><i class="fa-solid fa-bag-shopping"></i> My Orders</span>
                    </asp:LinkButton>
                    <asp:LinkButton ID="lnkOrderStatus" runat="server" CssClass="menu-item" OnClick="lnkOrderStatus_Click" CausesValidation="false">
                    <span><i class="fa-solid fa-truck"></i> My Order Status</span>
                    </asp:LinkButton>
                    <asp:LinkButton ID="lnkLogout" runat="server" CssClass="menu-item" OnClick="lnkLogout_Click" Style="border-bottom: none;" CausesValidation="false">
                    <span><i class="fa-solid fa-arrow-right-from-bracket"></i> Log Out</span>
                    </asp:LinkButton>
                </div>
                <asp:Panel ID="pnlOrders" runat="server" Visible="false" CssClass="frame">
                    <h4 id="orderHeader" runat="server">My Order History</h4>
                    <br />
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="gv-style" Width="100%" GridLines="None" OnRowCommand="gvOrders_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="OrderNo" HeaderText="Order #" />
                            <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:dd-MM-yyyy}" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel Order"
                                        CommandName="CancelOrder" CommandArgument='<%# Eval("OrderNo") %>'
                                        Visible='<%# Eval("Status").ToString() == "Pending" %>'
                                        OnClientClick="return confirm('Are you sure?');"
                                        ForeColor="Red" Font-Bold="true" Style="text-decoration: none;" />

                                    <asp:LinkButton ID="btnReorder" runat="server" Text="Reorder"
                                        CommandName="Reorder" CommandArgument='<%# Eval("OrderNo") %>'
                                        Visible='<%# Eval("Status").ToString() == "Delivered" %>'
                                        ForeColor="Blue" Font-Bold="true" Style="text-decoration: none;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
            <div class="right-side">
                <div class="frame">
                    <div class="close-btn"><i class="fa-solid fa-xmark"></i></div>
                    <div class="header-box">
                        <h4 style="font-size: 24px;">Edit Profile</h4>
                        <p>Manage your account details</p>
                    </div>
                    <div class="input-row">
                        <span class="label">Name</span>
                        <asp:TextBox ID="txtName" runat="server" CssClass="value" />
                    </div>
                    <div class="input-row">
                        <span class="label">Current Password</span>
                        <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="value" TextMode="Password" placeholder="Enter current" />
                    </div>
                    <div class="input-row">
                        <span class="label">New Password</span>
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="value" TextMode="Password" placeholder="Enter new" />
                    </div>
                    <div class="input-row">
                        <span class="label">Confirm Password</span>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="value" TextMode="Password" placeholder="Repeat new" />
                    </div>
                    <%--<div class="input-row" style="border-bottom: none;">
                        <span class="label">Location</span>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="value" />
                    </div>--%>
                    <div class="input-row" style="border-bottom: none;">
                        <span class="label">Location</span>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="value" />
                    </div>
                    <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnUpdate_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
