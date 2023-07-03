<%@page import="com.emart.dataobject.ProductDao"%>
<%@page import="com.emart.dataobject.UserDao"%>
<%@page import="com.emart.entities.User"%>
<%
    //fetch current user from http session
    User user = (User) session.getAttribute("currentUser");

    //if not logged in then send to login page
    if (user == null) {

        session.setAttribute("msg", "You are not logged in..!");
        session.setAttribute("color", "danger");
        response.sendRedirect("login.jsp");
        return;

        //if the user not an admin then send to home page
    } else if (!user.getUserType().equalsIgnoreCase("admin")) {
        session.setAttribute("msg", "You are not an admin..!");
        session.setAttribute("color", "danger");
        response.sendRedirect("home.jsp");
        return;
    }

    //fetch all user, products, product category to count total
    List<User> users = new UserDao().getAllUser(FactoryProvider.getFactory());
    List<Category> categorys = new CategoryDao().getAllCategory(FactoryProvider.getFactory());
    List<Product> products = new ProductDao().getAllProduct(FactoryProvider.getFactory());

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--if any error to load the page then send to error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Admin</title>

        <!--bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body class="admin-bg">

        <!--navbar-->
        <%@include file="common_files/navbar.jsp" %>

        <!--show message for error and success-->
        <%@include file="common_files/message.jsp" %>

        <div class="container my-4 admin">

            <!--first row or count row-->
            <div class="row">

                <!--user count-->
                <div class="col-md-4">
                    <div class="card bg-secondary text-white">
                        <div class="card-body text-center">
                            <span class="fa fa-users fa-3x my-4"></span>
                            <h4 class="my-3 text-uppercase">Total Users</h4>
                            <h2><%= users.size()%></h2>
                        </div>
                    </div>
                </div>

                <!--category count-->
                <div class="col-md-4">
                    <div class="card bg-info text-white">
                        <div class="card-body text-center">
                            <span class="fa fa-sitemap fa-3x my-4"></span>
                            <h4 class="my-3 text-uppercase">Total Categories</h4>
                            <h2><%= categorys.size()%></h2>

                        </div>
                    </div>
                </div>

                <!--product count-->
                <div class="col-md-4">
                    <div class="card bg-warning text-white">
                        <div class="card-body text-center">
                            <span class="fa fa-shopping-basket fa-3x my-4"></span>
                            <h4 class="my-3 text-uppercase">Total Products</h4>
                            <h2><%= products.size()%></h2>

                        </div>
                    </div>
                </div>

            </div>
            <!--end of first row-->

            <!--start second row/ add product and add category row-->                
            <div class="row my-4">

                <!--add product-->
                <div class="col-md-6">
                    <div class="card px-5" style="max-height: 350px;">
                        <div class="card-body text-center">
                            <div class="my-3">
                                <img class="img-fluid" src="img/add_product.png" alt="Add product" style="max-width: 150px;">
                            </div>
                            <a class="text-success my-2 btn btn-warning" href="#" data-toggle="modal" data-target="#productModal">
                                <b>Add Product</b>
                            </a>
                        </div>
                    </div>
                </div>

                <!--add category-->
                <div class="col-md-6">
                    <div class="card px-5" style="max-height: 350px;">
                        <div class="card-body text-center">
                            <div class="my-3">
                                <img class="img-fluid" src="img/menu.png" alt="Add category" style="max-width: 150px;">
                            </div>
                            <a class="text-success my-2 btn btn-warning" href="#" data-toggle="modal" data-target="#categoryModal">
                                <b>Add Category</b>
                            </a>
                        </div>
                    </div>
                </div>

            </div>
            <!--end of second row-->

        </div>

        <!--add category modal-->
        <%@include file="modals/category_modal.jsp" %>

        <!--add product modal-->
        <%@include file="modals/product_modal.jsp" %>

    </body>
</html>
