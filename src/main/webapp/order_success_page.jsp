<%@page import="com.emart.entities.User"%>

<%
    //fetch current user details
    User orderUser = (User) session.getAttribute("currentUser");

    //user validation
    if (orderUser == null) {

        session.setAttribute("msg", "Please login to complete your order..!");
        session.setAttribute("color", "danger");

        response.sendRedirect("login.jsp");

        return;
    }

    String orderId = request.getParameter("o_id");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--add error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Order Success</title>

        <!--bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body class="default-bg">

        <!--start container-->
        <div class="container my-5 pt-5">

            <!--start card-->            
            <div class="card">

                <!--start card body-->
                <div class="card-body text-center">

                    <!--check icon-->
                    <div class="display-3">
                        <i class="fa fa-check-circle-o fa-3x text-success"></i>
                    </div>

                    <!--order success message-->
                    <h3 class="display-4 text-success">Your Order Placed Successfully..!</h3>

                    <!--order details button-->
                    <a href='order_details.jsp?o_id=<%= orderId%>' class='btn btn-info text-white mt-4 mr-2 font-weight-bold'>Check Order Details</a>

                    <!--home button-->
                    <a href='index.jsp' class='btn btn-warning text-white mt-4 font-weight-bold'><i class="fa fa-home"></i> Home Page</a>

                </div>
                <!--start card body-->

            </div>
            <!--start card-->

        </div>
        <!--end container-->

    </body>
</html>
