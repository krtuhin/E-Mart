<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Register</title>

        <!--bootstrap file-->
        <%@include file="common_files/css_js.jsp" %>

    </head>
    <body class="register-bg">
        <!--navbar file-->
        <%@include file="common_files/navbar.jsp" %>

        <!--registration form-->
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card my-3">
                        <div class="card-header text-center bg-dark text-white">
                            <div class="fa fa-user-plus fa-3x"></div>
                            <h3>Register Here!</h3>
                        </div>

                        <!--error or success message-->
                        <%@include file="common_files/message.jsp" %>

                        <!--register form start-->
                        <div class="card-body px-5">
                            <form action="RegisterServlet" method="post" enctype="multipart/form-data">

                                <!--name-->
                                <div class="form-group">
                                    <label for="userName">Name <span class="mendatory">*</span></label>
                                    <input name="name" type="text" class="form-control" id="userName" placeholder="Enter your full name" required>
                                </div>

                                <!--email-->
                                <div class="form-group">
                                    <label for="userEmail">Email address <span class="mendatory">*</span></label>
                                    <input name="email" type="email" class="form-control" id="userEmail1" placeholder="Enter email" required>
                                </div>

                                <!--password-->
                                <div class="form-group">
                                    <label for="userPassword">Password <span class="mendatory">*</span></label>
                                    <input name="password" type="password" minlength="8" class="form-control" id="userPassword" placeholder="Enter password" required>
                                </div>

                                <!--mobile number-->
                                <div class="form-group">
                                    <label for="userPhone">Phone No. <span class="mendatory">*</span></label>
                                    <input name="phone" type="number" minlength="10" maxlength="10" class="form-control" id="userPhone" placeholder="Enter mobile number" required>
                                </div>

                                <!--address-->
                                <div class="form-group">
                                    <label for="profile">Profile picture (Optional)</label>
                                    <input type="file" id="profile" class="form-control" name="profile" placeholder="Choose profile picture">
                                </div>

                                <!--terms and condition checkbox-->
                                <div class="form-check">
                                    <input name="check" value="yes" type="checkbox" class="form-check-input" id="check">
                                    <label class="form-check-label" for="check">Terms & Conditions</label>
                                </div>

                                <!--submit and reset button-->
                                <div class="text-center my-2">
                                    <button type="submit" class="btn btn-success">Register</button>
                                    <button type="reset" class="btn btn-warning text-white">Reset</button>
                                </div>
                            </form>
                            <!--register form end-->

                            <!--login message-->
                            <div class="text-center">
                                Already have an account? 
                                <a href="login.jsp" class="text-blue"><b>Login Now</b></a>
                            </div>
                            <!--message end-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--form end-->
    </body>
</html>
