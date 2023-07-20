<%@page import="com.emart.entities.User"%>
<%@page import="com.emart.entities.Product"%>
<%@page import="com.emart.dataobject.CartDao"%>
<%@page import="java.util.List"%>

<%
    //fetch current user details
    User user2 = (User) session.getAttribute("currentUser");

    //if not logged in any user cannot access this page
    if (user2 == null) {

        session.setAttribute("msg", "Please login to access your wishlist..!");
        session.setAttribute("color", "danger");

        response.sendRedirect("login.jsp");

        return;
    }

    //fetch all peoduct from wishlist by user id
    List<Product> list = new CartDao().getAllProductFromCartByUserId(user2.getId());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Order Page</title>

        <!--bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>

    <body>
        <!--nav bar-->
        <%@include file="common_files/navbar.jsp" %>

        <!--success or failure message-->
        <div class="col-md-6 offset-md-3">
            <%@include file="common_files/message.jsp" %>   
        </div>

        <!--start container-->
        <div class="container my-4">

            <!--main row-->
            <div class="row">

                <!--start column-->
                <div class="col-md-12">

                    <!--start card-->
                    <div class="card detail-card default-bg">

                        <!--card header-->
                        <div class="card-header text-center bg-dark text-white">

                            <h3 class="text-uppercase">
                                <span class="fa fa-life-bouy"></span>
                                Your Wishlist 
                                <span class="fa fa-life-bouy"></span>
                            </h3>

                        </div>

                        <!--main card body-->
                        <div class="card-body wishlist-scroll">

                            <%if (list.isEmpty()) {%>

                            <!--if wishlist is empty then show this message-->
                            <div class="text-center my-5 py-5">
                                <h3 class="py-5 display-4">Your wishlist is empty..!</h3>
                            </div>

                            <%
                                return;
                            } else {
                                for (Product p : list) {
                            %>

                            <!--single product card-->
                            <div class="card my-2">

                                <!--single product card body-->
                                <div class="card-body">

                                    <!--single product row-->
                                    <div class="row">

                                        <!--product image column-->
                                        <div class="col-md-3 text-center">

                                            <!--product details link-->
                                            <a href="product_details.jsp?p_id=<%= p.getId()%>" target="_blank" class="nav-link">

                                                <!--image-->
                                                <img class="wishlist-img" src="img/products/<%= p.getPhoto()%>" alt="Product Image">

                                            </a>
                                            <!--end link-->

                                        </div>
                                        <!--product image column-->

                                        <!--product details column-->
                                        <div class="col-md-7">

                                            <!--product details link-->
                                            <a href="product_details.jsp?p_id=<%= p.getId()%>" target="_blank" class="nav-link">

                                                <div class="my-4 title-clr">

                                                    <!--product title-->
                                                    <h4><%= p.getTitle()%></h4>

                                                    <!--product price details-->
                                                    <h4 class="mt-3">
                                                        &#8377;<%= p.getDiscountPrice()%> 

                                                        <small class="text-secondary ml-2" style="text-decoration: line-through;">&#8377;<%= p.getPrice()%></small>

                                                        <small class="text-success ml-1 font-weight-bold" style="font-size: 17px;"><%= p.getDiscount()%>% off</small>
                                                    </h4>
                                                    <!--end price details-->

                                                </div>

                                            </a>
                                            <!--end product details link-->

                                        </div>
                                        <!--end product details column-->

                                        <!--buttons for operations-->
                                        <div class="col-md-2 text-center my-3">

                                            <!--product delete form-->
                                            <form action="CartOperationServlet" method="post">

                                                <input type="hidden" name="operation" value="remove">
                                                <input type="hidden" name="product-id" value="<%= p.getId()%>">

                                                <!--order button-->
                                                <div class="col-md-12 mb-2 mt-3">
                                                    <a href="address_page.jsp?pid=<%= p.getId()%>" class="btn btn-warning text-uppercase text-white font-weight-bold">Order</a>
                                                </div>

                                                <!--delete button-->
                                                <div class="col-md-12">
                                                    <button type="submit" class="btn btn-danger text-uppercase font-weight-bold">Delete</button>
                                                </div>

                                            </form>
                                            <!--end product edit form-->

                                        </div>
                                        <!--end operation buttons-->

                                    </div>
                                    <!--end single product row-->

                                </div>
                                <!--end single product card body-->

                            </div>
                            <!--end single product card-->

                            <%}
                                }%>

                        </div>
                        <!--end main card body-->

                    </div>
                    <!--end card-->

                </div>
                <!--end columns-->

            </div>
            <!--end row-->

        </div>
        <!--end container-->

    </body>
</html>
