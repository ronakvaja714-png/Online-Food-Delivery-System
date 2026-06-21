<%@ Page Title="About Us | Desi Bite" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Desi_Bite.User.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="about_section layout_padding">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="img-box">
                        <img src="../templatefiels/images/about-img.png" alt="About Desi Bites">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>We Are Desi Bites</h2>
                        </div>
                        <p>
                            At Desi Bite, our journey began with a simple idea: to bring the authentic, heartwarming flavors of home-cooked meals to your dining table. We believe that food is more than just sustenance—it’s a memory, a culture, and a celebration. From the freshest local ingredients to our secret traditional recipes, every dish we deliver is crafted with passion, hygiene, and the promise of a truly delicious experience.
                        </p>
                        
                        <div class="row mt-4">
                            <div class="col-md-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-check-circle text-warning mr-2"></i>
                                    <span><strong>Fresh Ingredients:</strong> Sourced daily for the best taste.</span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-shipping-fast text-warning mr-2"></i>
                                    <span><strong>Fast Delivery:</strong> We value your hunger and time.</span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-shield-alt text-warning mr-2"></i>
                                    <span><strong>Hygiene First:</strong> Clean kitchens and safe packaging.</span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-heart text-warning mr-2"></i>
                                    <span><strong>Made with Love:</strong> Traditional recipes from our heart to yours.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>