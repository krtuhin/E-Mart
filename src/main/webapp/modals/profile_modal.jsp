<%@page import="com.emart.entities.User"%>
<% User currentUser = (User) session.getAttribute("currentUser");%>

<!--start profile modal-->
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">

                <!--profile card-->
                <div class="card">

                    <!--header-->
                    <div class="card-header bg-dark text-center text-white">

                        <!--profile picture-->
                        <div class="my-2">
                            <img class="picture-radius" src="img/profiles/<%= currentUser.getUserPic()%>" alt="Profile Picture">
                        </div>

                        <!--name of user-->
                        <h2><%= currentUser.getUserName()%></h2>
                    </div>

                    <!--card body-->
                    <div class="card-body">

                        <!--start table-->
                        <table class="table">
                            <tbody>

                                <!--name-->
                                <tr>
                                    <th scope="row">Name:</th>
                                    <td><%= currentUser.getUserName()%></td>
                                </tr>

                                <!--email-->
                                <tr>
                                    <th scope="row">Email:</th>
                                    <td><%= currentUser.getUsrEmail()%></td>
                                </tr>

                                <!--mobile number-->
                                <tr>
                                    <th scope="row">Mobile No.:</th>
                                    <td><%= currentUser.getUserPhone()%></td>
                                </tr>

                            </tbody>
                        </table>
                        <!--end table-->

                    </div>
                    <!--end card body-->

                </div>
            </div>
            <!--end modal body-->

            <!--close and edit button-->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-success" data-dismiss="modal" data-toggle="modal" data-target="#editProfile"><span class="fa fa-edit"></span> Edit</button>
            </div>
        </div>
    </div>
</div>
<!--end profile modal-->

<!--start edit profile modal-->
<div class="modal fade" id="editProfile" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <!--edit profile form-->
            <form action="ProfileUpdateServlet" method="post" enctype="multipart/form-data">

                <div class="modal-body">

                    <div class="card">

                        <!--card header-->
                        <div class="card-header bg-dark text-center text-white">

                            <!--image-->
                            <div class="my-2">
                                <img class="picture-radius" src="img/profiles/<%= currentUser.getUserPic()%>" alt="Profile Picture">
                            </div>

                            <h2><%= currentUser.getUserName()%></h2>
                        </div>

                        <!--start card body-->
                        <div class="card-body">

                            <!--start table-->
                            <table class="table">
                                <tbody>

                                    <!--name-->
                                    <tr>
                                        <th scope="row">Name:<span class="mendatory">*</span></th>
                                        <td><input class="form-control" required type="text" value="<%= currentUser.getUserName()%>" name="name" placeholder="Enter your name"></td>
                                    </tr>

                                    <!--email-->
                                    <tr>
                                        <th scope="row">Email:<span class="mendatory">*</span></th>
                                        <td><input class="form-control" required type="email" name="email" value="<%= currentUser.getUsrEmail()%>" placeholder="Enter your email"></td>
                                    </tr>

                                    <!--password-->
                                    <tr>
                                        <th scope="row">Password:<span class="mendatory">*</span></th>
                                        <td><input class="form-control" required type="password" name="password" value="<%= currentUser.getUserPassword()%>" placeholder="Enter password"></td>
                                    </tr>

                                    <!--mobile number-->
                                    <tr>
                                        <th scope="row">Mobile No.:<span class="mendatory">*</span></th>
                                        <td><input class="form-control" required type="text" name="mobile" value="<%= currentUser.getUserPhone()%>" placeholder="Enter mobile number" pattern="[0-9]{10}"></td>
                                    </tr>

                                    <!--profile picture input-->
                                    <tr>
                                        <th scope="row">Profile picture:</th>
                                        <td><input class="form-control" type="file" name="profile"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <!--end table-->

                        </div>
                        <!--end card body-->

                    </div>
                </div>

                <!--close and save button-->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>

            </form>
            <!--end edit form-->

        </div>
    </div>
</div>
<!--end edit profile modal-->