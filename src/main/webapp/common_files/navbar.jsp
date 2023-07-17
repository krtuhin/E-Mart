<%@page import="com.emart.entities.Cart"%>
<%@page import="com.emart.dataobject.CartDao"%>
<%@page import="com.emart.entities.Product"%>
<%@page import="com.emart.dataobject.CategoryDao"%>
<%@page import="com.emart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.emart.entities.User"%>

<% User nowUser = (User) session.getAttribute("currentUser");%>

<nav class="navbar navbar-expand-lg navbar-dark bg-info">

    <!--E-Mart logo-->
    <a class="navbar-brand logo" href="index.jsp">E-Mart</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">

            <!--home button-->
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home</a>
            </li>

            <!--about us-->
            <li class="nav-item active">
                <a class="nav-link" href="about.jsp">About Us</a>
            </li>

            <!--contact us-->
            <li class="nav-item active">
                <a class="nav-link" href="contact.jsp">Contact Us</a>
            </li>

            <%
                String disable = null;
                String btnColor = null;
            %>

        </ul>
        <!--if no user logged in then show login and register option-->
        <% if (nowUser == null) { %>

        <a class="btn btn-light my-2 my-sm-0 mr-4" href="login.jsp">Login</a>
        <a class="btn btn-outline-light my-2 my-sm-0 text-white" href="register.jsp">Register Us</a>

        <%
        } else {
            //fetch items from cart using user id
            List<Product> pList = new CartDao().getAllProductFromCartByUserId(nowUser.getId());
        %>

        <!--if any user logged in then show user profile, product order, wishlist, logout button in place of login and register button-->

        <!--order button-->
        <a class="btn my-2 my-sm-0 text-white" href="#" data-toggle="modal" data-target="#orderModal"><i class="fa fa-order-plus mr-1"></i> Orders</a>

        <!--wishlist button-->
        <a class="btn my-2 my-sm-0 mr-3 text-white" href="wishlist.jsp" ><i class="fa fa-heart-o mr-1"></i> Wishlist (<%= pList.size()%>)</a>

        <!--profile button-->
        <a class="btn my-2 my-sm-0 mr-2 text-white" href="#" data-toggle="modal" data-target="#profileModal"><span class="fa fa-user-circle-o"></span>  <%= nowUser.getUserName()%></a>

        <!--logout button-->
        <a class="btn my-2 my-sm-0 text-white" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>

        <!--user profile modal-->
        <%@include file="../modals/profile_modal.jsp" %>

        <%
            }
        %>

    </div>
</nav>