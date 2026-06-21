<%@ Page Title="Feedback | Desi Bite" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Desi_Bite.User.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <h2>Give us Feedback</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div class="mb-3">
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Write your experience..." TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Rating" Value="" />
                                <asp:ListItem Text="5 ⭐ Excellent" Value="5" />
                                <asp:ListItem Text="4 ⭐ Very Good" Value="4" />
                                <asp:ListItem Text="3 ⭐ Good" Value="3" />
                                <asp:ListItem Text="2 ⭐ Poor" Value="2" />
                                <asp:ListItem Text="1 ⭐ Terrible" Value="1" />
                            </asp:DropDownList>
                        </div>
                        <div class="btn_box">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
