<%@page import="com.emart.dataobject.AddressDao"%>
<%@page import="com.emart.entities.Address"%>
<%@page import="java.util.List"%>
<%@page import="com.emart.entities.User"%>
<%
    //fetch current user details
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        session.setAttribute("msg", "Please login to order your product..!");
        session.setAttribute("color", "danger");
        response.sendRedirect("login.jsp");

        return;
    }

    List<Address> addresses = new AddressDao().getAllAddressByUserId(user.getId());
%>

<!-- Modal -->
<div class="modal fade" id="address-modal" tabindex="-1" role="dialog" aria-labelledby="product" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <!--modal body-->
            <div class="modal-body">

                <div class="card">

                    <!--heading-->
                    <div class="card-header text-center text-white bg-dark">
                        <h2>Enter your delivery information..!</h2>
                    </div>

                    <div class="card-body">

                        <!--delivery address form-->
                        <form action="AddressOperationServlet" method="post">

                            <!--name-->
                            <div class="form-group">
                                <label for="name">Name<span class="mendatory">*</span></label>
                                <input type="text" value="<%= user.getUserName()%>" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                            </div>

                            <!--email-->
                            <div class="form-group">
                                <label for="email">Email<span class="mendatory">*</span></label>
                                <input type="email" value="<%= user.getUsrEmail()%>" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                            </div>

                            <!--mobile number-->
                            <div class="form-group">
                                <label for="mobile">Mobile number<span class="mendatory">*</span></label>
                                <input type="tel" pattern="[0-9]{10}" value="<%= user.getUserPhone()%>" class="form-control" id="mobile" name="mobile" placeholder="Enter mobile number" required>
                            </div>

                            <!--start address-->
                            <div class="form-group">

                                <label>Address<span class="mendatory">*</span></label>

                                <div class="form-control">

                                    <!--city and district-->
                                    <div class="form-group">
                                        <div class="form-row">

                                            <!--city-->
                                            <div class="col">
                                                <input type="text" class="form-control" id="city" name="city" placeholder="City (Required)" required>
                                            </div>

                                            <!--district-->
                                            <div class="col">
                                                <input type="text" class="form-control" id="dist" name="dist" placeholder="District (Required)" required>
                                            </div>

                                        </div>
                                    </div>

                                    <!--state and pin-->
                                    <div class="form-group">
                                        <div class="form-row">

                                            <!--state-->
                                            <div class="col">
                                                <input type="text" class="form-control" id="state" name="state" placeholder="State (Required)" required>
                                            </div>

                                            <!--pin-->
                                            <div class="col">
                                                <input type="number" class="form-control" id="pin" name="pin" placeholder="PIN Code (Required)" required>
                                            </div>

                                        </div>
                                    </div>

                                    <!--house number or building name-->
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="house" name="house" placeholder="House No, Building name (Required)" required>
                                    </div>

                                    <!--road name-->
                                    <input type="text" class="form-control" id="area" name="area" placeholder="Road name, Area, Colony (Required)" required>

                                </div>
                            </div>
                            <!--end address-->

                            <!--submit button-->
                            <div class="text-center">
                                <input type="hidden" name="operation" value="save">
                                <button type="submit" class="btn btn-success">Save</button>
                            </div>

                        </form>
                        <!--end form-->

                    </div>
                    <!--end card body-->

                </div>

            </div>
            <!--modal body-->

        </div>
    </div>
</div>
