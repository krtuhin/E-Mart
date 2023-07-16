<%@page import="com.emart.dataobject.AddressDao"%>
<%@page import="com.emart.entities.Address"%>
<%@page import="java.util.List"%>

<%
    //current user
    User user1 = (User) session.getAttribute("currentUser");

    //condition for checking user logged in or not
    if (user1 == null) {
        session.setAttribute("msg", "Please login to order your product..!");
        session.setAttribute("color", "danger");
        response.sendRedirect("login.jsp");

        return;
    }

    //getting address from database
    List<Address> address = new AddressDao().getAllAddressByUserId(user1.getId());

    //product id from URL
    String pId = request.getParameter("pid");

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Delivery Page</title>

        <!--add bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body>
        <!--nav bar-->
        <%@include file="common_files/navbar.jsp" %>

        <!--error or success message-->
        <%@include file="common_files/message.jsp" %>

        <!--start container-->
        <div class="container my-3">

            <div class="col-md-12">

                <!--start card-->
                <div class="card" style="height: 80vh; max-height: 100%;">

                    <!--header-->
                    <div class="card-header text-center text-white bg-dark">
                        <h2>Your delivery addresses..!</h2>
                    </div>

                    <!--card body-->
                    <div class="card-body">

                        <!--modal button-->
                        <div class="text-center mb-2">
                            <a href="#" class=" btn btn-warning text-white font-weight-bold" data-toggle="modal" data-target="#address-modal">Add a new address</a>
                        </div>

                        <!--modal for save address-->
                        <%@include file="modals/delivery_address.jsp" %>

                        <!--start show saved address-->
                        <div class="scroll">

                            <%if (addresses.isEmpty()) {%>

                            <!--if any address not saved-->
                            <div class="text-center display-4">
                                <h4>No address available...!</h4>
                            </div>

                            <%
                            } else {

                                //show all the saved addresses
                                for (Address a : addresses) {%>

                            <!--card for particular address-->
                            <div class="card mb-3">

                                <!--card body-->
                                <div class="card-body">

                                    <!--name of user-->
                                    <h5><%= a.getName()%></h5>

                                    <!--house and area-->
                                    <p><%= a.getHouse()%>, <%= a.getArea()%></p>

                                    <!--city and district-->
                                    <p style="margin-top: -19px;"><%= a.getCity()%>, <%= a.getDistrict()%></p>

                                    <!--state and pin-->
                                    <p class="mb-2" style="margin-top: -19px;"><%= a.getState()%> - <%= a.getPin()%></p>

                                    <!--mobile number-->
                                    <p style="margin-bottom: -7px;"><b><%= a.getMobile()%></b></p>

                                    <!--address manage form-->
                                    <div class="text-center">
                                        <form action="AddressOperationServlet" method="post">

                                            <!--hidden form for product id and address id-->
                                            <input type="hidden" name="address-id" value="<%= a.getId()%>">
                                            <input type="hidden" name="p-id" value="<%= pId%>">

                                            <!--address delete button-->
                                            <input name="operation" value="delete" type="submit" class="btn btn-danger text-white text-uppercase">

                                            <!--button for select address for deliver-->
                                            <input name="operation" value="deliver here" type="submit" class="btn btn-success text-white text-uppercase">

                                        </form>
                                        <!--end form-->

                                    </div>

                                </div>
                                <!--card body-->

                            </div>
                            <!--end card for particular address-->

                            <%}
                                }%>
                        </div>
                        <!--end show address-->

                    </div>
                    <!--end card body-->

                </div>
                <!--end card-->

            </div>

        </div>
        <!--end container-->

    </body>
</html>
