<%@page import="com.emart.entities.User"%>

<%
    //access current user details
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");

        return;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Home</title>

        <!--bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body class="default-bg">

        <!--nav bar-->
        <%@include file="common_files/navbar.jsp" %>

        <!--show all product module-->
        <%@include file="common_files/show_all_product.jsp" %>

    </body>
</html>
