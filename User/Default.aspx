<%@ Page Title="Home | Desi Bite" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Desi_Bite.User.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .client_section .box {
            text-align: center;
            padding: 30px;
            border-radius: 15px;
            margin: 10px;
            background: #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .client_section .detail-box p {
            font-style: italic;
            color: #555;
        }

        .rating_stars {
            font-size: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="offer_section layout_padding-bottom">
        <div class="offer_container">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="box">
                            <div class="img-box">
                                <img src="../templatefiels/images/images.jpg" alt="All time favorite">
                            </div>
                            <div class="detail-box">
                                <h5>All time favorite</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="box">
                            <div class="img-box">
                                <img src="../templatefiels/images/dhokla.png" alt="Great Breakfast">
                            </div>
                            <div class="detail-box">
                                <h5>Great Breakfast</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about_section layout_padding_bottom">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="img-box">
                        <img src="../templatefiels/images/about-img.png" alt="About Us">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>We Are Desi Bites</h2>
                        </div>
                        <p>
                            At Desi Bite, our journey began with a simple idea: to bring authentic flavors to your doorstep.
                        </p>
                        <a href="About.aspx">Read More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="client_section layout_padding-bottom pt-5">
        <div class="container">
            <div class="heading_container heading_center psudo_white_primary mb_45">
                <h2>What Our Customers Say</h2>
            </div>
            <div class="carousel-wrap row">
                <div class="owl-carousel client_owl-carousel">
                    <asp:Repeater ID="rptrFeedback" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <div class="box">
                                    <div class="detail-box">
                                        <div class="client_info">
                                            <h6><%# Eval("name") %></h6>
                                            <div class="rating_stars text-warning mb-2">
                                                <i class="fa fa-star"></i> <%# Eval("rating") %>/5
                                            </div>
                                        </div>
                                        <p>"<%# Eval("msg") %>"</p>
                                        <p class="small text-muted mt-2">
                                            <i class="fa fa-calendar-alt"></i> <%# Eval("created_at", "{0:dd MMM yyyy}") %>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </section>

</asp:Content>