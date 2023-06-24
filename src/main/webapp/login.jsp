<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Login</title>

        <!--add bootstrap-->
        <%@include file="common_files/css_js.jsp" %>

    </head>
    <body class="login-bg">

        <!--navbar-->
        <%@include file="common_files/navbar.jsp" %>

        <div class="container my-5">
            <div class="row">
                <div class="col-md-6 offset-md-3">

                    <!--card-->
                    <div class="card">
                        <div class="card-header text-center text-white bg-dark">
                            <span class="fa fa-user-circle-o fa-3x my-1"></span>
                            <h3>Login here!</h3>
                        </div>
                        <div class="card-body">

                            <!--login or success message-->
                            <%@include file="common_files/message.jsp" %>

                            <!--start login form-->
                            <form action="LoginServlet" method="post">

                                <!--email field-->
                                <div class="form-group">
                                    <label for="userEmail">Email <span class="text-danger">*</span></label>
                                    <input id="userEmail1" class="form-control" name="email" type="email" placeholder="Enter email" required>
                                </div>

                                <!--password field-->
                                <div class="form-group">
                                    <label for="userPassword">Password <span class="text-danger">*</span></label>
                                    <input id="userPassword" class="form-control" name="password" type="password" minlength="8" placeholder="Enter password" required>
                                </div>

                                <!--login button-->
                                <div class="text-center my-2">
                                    <button type="submit" class="btn btn-success">Login</button>
                                </div>
                            </form>
                            <!--end login form-->

                            <!--new user register message-->
                            <div class="text-center">
                                Do not have account? <a class="text-blue" href="register.jsp"><b>Register now</b></a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
