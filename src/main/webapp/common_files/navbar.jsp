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

            <!--home button based on condition-->
            <%
                if (nowUser != null) {
                    if (nowUser.getUserType().trim().equalsIgnoreCase("admin")) {
            %>

            <!--if user is admin then home page is admin panel-->
            <!--home button-->
            <li class="nav-item active">
                <a class="nav-link font-weight-bold" href="admin.jsp"><i class="fa fa-home font-weight-bold"></i> Home</a>
            </li>

            <%} else {%>

            <!--if user is normal user then home page is index page-->
            <!--home button-->
            <li class="nav-item active">
                <a class="nav-link font-weight-bold" href="index.jsp"><i class="fa fa-home font-weight-bold"></i> Home</a>
            </li>

            <%}
            } else {%>

            <!--if user not logged in then home page is index page-->
            <!--home button-->
            <li class="nav-item active">
                <a class="nav-link font-weight-bold" href="index.jsp"><i class="fa fa-home font-weight-bold"></i> Home</a>
            </li>

            <%}%>
            <!--end all home button condition-->

            <!--about us-->
            <li class="nav-item active">
                <a class="nav-link font-weight-bold" href="about.jsp"><i class="fa fa-info-circle"></i> About Us</a>
            </li>

            <!--contact us-->
            <li class="nav-item active">
                <a class="nav-link font-weight-bold" href="contact.jsp"><i class="fa fa-id-badge"></i> Contact Us</a>
            </li>

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
        <a class="btn my-2 my-sm-0 text-white font-weight-bold" href="#" data-toggle="modal" data-target="#orderListModal"><i class="fa fa-order-plus mr-1"></i> Orders</a>

        <!--wishlist button-->
        <a class="btn my-2 my-sm-0 mr-3 text-white font-weight-bold" href="wishlist.jsp" ><i class="fa fa-heart-o mr-1 font-weight-bold"></i> Wishlist (<%= pList.size()%>)</a>

        <!--profile button-->
        <a class="btn my-2 my-sm-0 mr-2 text-white" href="#" data-toggle="modal" data-target="#profileModal"><span class="fa fa-user-circle-o"></span>  <%= nowUser.getUserName()%></a>

        <!--logout button-->
        <a class="btn my-2 my-sm-0 text-white" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>

        <!--user profile modal-->
        <%@include file="../modals/profile_modal.jsp" %>

        <!--order list modal-->
        <%@include file="../modals/order_list_modal.jsp" %>

        <%
            }
        %>

    </div>
</nav>