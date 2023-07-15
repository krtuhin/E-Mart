<%
    User userr = (User) session.getAttribute("currentUser");

    //if user not logged in then cannot order product
    if (userr == null) {

        session.setAttribute("msg", "Login to order your products..!");
        session.setAttribute("color", "danger");
        response.sendRedirect("login.jsp");

        return;
    }

    String pId = request.getParameter("p_id");
    String addressId = request.getParameter("a_id");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--error page-->
<%@page errorPage="error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Payment</title>

        <!--bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body>
        <!--navbar-->
        <%@include file="common_files/navbar.jsp" %>

        <div class="container my-5">

            <!--order success message-->
            <div class="mb-5">
                <%@include file="common_files/message.jsp" %>
            </div>

            <!--payment field-->
            <div class="col-md-8 offset-md-2">

                <!--payment form-->
                <form action="OrderServlet" method="post">

                    <!--payment card-->
                    <div class="card">

                        <!--header-->
                        <div class="card-header bg-dark text-center text-white">
                            <h3>Payment Now..!</h3>

                        </div>

                        <!--card body-->
                        <div class="card-body">

                            <!--select online payment mode-->
                            <div class="form-group">
                                <div class="form-control">

                                    <input type="radio" name="payment-mode" value="online" id="online" required>
                                    <label for="online">Online Payment</label>

                                </div>
                            </div>

                            <!--select offline payment mode-->
                            <div class="form-group">
                                <div class="form-control">

                                    <input id="cod" type="radio" name="payment-mode" value="cod" required>
                                    <label for="cod">Cash On Delivery</label>

                                </div>
                            </div>

                            <input type="hidden" name="user-id" value="<%= userr.getId()%>">
                            <input type="hidden" name="address-id" value="<%= addressId%>">
                            <input type="hidden" name="product-id" value="<%= pId%>">

                        </div>
                        <!--end card body-->

                    </div>
                    <!--end payment card-->

                    <!--order button-->
                    <div class="col-md-12 text-center my-3">
                        <button type="submit" class="btn btn-clr text-white text-center text-uppercase col-md-6">Place Order</button>
                    </div>

                </form>

            </div>
            <!--end payment field-->

        </div>
        <!--end container-->

    </body>
</html>