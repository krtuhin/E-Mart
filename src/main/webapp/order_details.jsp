<%@page import="com.emart.dataobject.AddressDao"%>
<%@page import="com.emart.entities.Address"%>
<%@page import="com.emart.dataobject.ProductDao"%>
<%@page import="com.emart.dataobject.OrderDao"%>
<%@page import="com.emart.entities.Order"%>
<%@page import="com.emart.entities.User"%>

<%
    //user validation
    User orderDetailsUser = (User) session.getAttribute("currentUser");

    if (orderDetailsUser == null) {

        session.setAttribute("msg", "Please login to check your order details..!");
        session.setAttribute("color", "danger");

        response.sendRedirect("login.jsp");

        return;
    }

    //order id from URL
    int orderId = Integer.parseInt(request.getParameter("o_id"));

    //access particular order from database 
    Order order = new OrderDao().getOrderDetailsById(orderId, String.valueOf(orderDetailsUser.getId()));

    //access ordered product by product id
    Product product = new ProductDao().getProductById(Integer.parseInt(order.getProductId()));

    //access address on which product will delivered, by address id
    Address address = new AddressDao().getAddressById(Integer.parseInt(order.getAddressId()));
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Order Details</title>

        <!--bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body>

        <!--nav bar-->
        <%@include  file="common_files/navbar.jsp" %>

        <!--start container-->
        <div class="container my-5">

            <!--link for go product details page-->
            <a href="product_details.jsp?p_id=<%= order.getProductId()%>" class="text-link">

                <!--start order details card-->
                <div class="card" style="min-height: 60vh;">

                    <!--card body-->
                    <div class="card-body">

                        <!--main row-->
                        <div class="row">

                            <!--image column-->
                            <div class="col-md-5 ml-3 mt-auto mb-auto">
                                <div class="text-center mt-auto">
                                    <img src="img/products/<%= product.getPhoto()%>" alt="Product Image" class="product-details-img my-2">
                                </div>
                            </div>
                            <!--end image column-->

                            <!--start details column-->
                            <div class="col-md-6 ml-5">

                                <!--product details row-->
                                <div class="row my-3" style="min-height: 40%;">

                                    <fieldset>

                                        <!--product name-->
                                        <h4 class="mb-3"><%= product.getTitle()%></h4>

                                        <!--product description-->
                                        <p><%= product.getDescription()%></p>

                                    </fieldset>

                                </div>

                                <!--order date row-->
                                <div class="row text-secondary text-uppercase">
                                    <h4>Ordered On: <%= order.getOrderDate().toLocaleString()%></h4>
                                </div>

                                <!--address details row-->
                                <div class="row my-3" style="min-height: 40%;">

                                    <fieldset class="scheduler-border">

                                        <!--name of user-->
                                        <h5><%= address.getName()%></h5>

                                        <!--house and area-->
                                        <p><%= address.getHouse()%>, <%= address.getArea()%></p>

                                        <!--city and district-->
                                        <p style="margin-top: -19px;"><%= address.getCity()%>, <%= address.getDistrict()%></p>

                                        <!--state and pin-->
                                        <p class="mb-2" style="margin-top: -19px;"><%= address.getState()%> - <%= address.getPin()%></p>

                                        <!--mobile number-->
                                        <p style="margin-bottom: -7px;">Phone number: <b><%= address.getMobile()%></b></p>

                                    </fieldset>

                                </div>
                                <!--end address row-->

                            </div>
                            <!--end details column-->

                        </div>
                        <!--end main row-->

                    </div>
                    <!--end card body-->

                </div>
                <!--end order details card-->

            </a>
            <!--product details link-->

        </div>
        <!--end container-->

    </body>
</html>
