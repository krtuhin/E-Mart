<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--condition for show this page as error page-->
<%@page contentType="text/html" isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>

        <!--adding bootstrap-->
        <%@include file="css_js.jsp" %>
    </head>
    <body>
        <div class="container text-center mt-5">

            <!--error information-->
            <img alt="Error" src="img/error.png" class="img-fluid" style="width: 350px;">
            <h4 class="display-4">Sorry!! Something went wrong...!</h4>

            <!--button for go to home page-->
            <a class="btn btn-warning text-white my-4" href="index.jsp">Home</a>

        </div>
    </body>
</html>
