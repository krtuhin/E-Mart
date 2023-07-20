<%@page import="com.emart.dataobject.ProductDao"%>
<%@page import="com.emart.dataobject.OrderDao"%>
<%@page import="com.emart.entities.Order"%>
<%@page import="com.emart.entities.User"%>
<%@page import="com.emart.entities.Product"%>
<%@page import="java.util.List"%>

<%
    //fetch current logged in user
    User orderListUser = (User) session.getAttribute("currentUser");

    List<Order> ordersList = null;

    //if user is logged in then fetch all the order list of the user
    if (orderListUser != null) {

        ordersList = new OrderDao().getAllOrderDetailsByUserId(String.valueOf(orderListUser.getId()));
    }
%>

<!--start order list modal-->
<div class="modal fade" id="orderListModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog order-modal" role="document">
        <div class="modal-content">

            <!--start modal body-->
            <div class="modal-body">

                <!--start main card-->
                <div class="card default-bg">

                    <!--main card header-->
                    <div class="card-header bg-dark text-white text-center">
                        <h3>My Orders</h3>
                    </div>

                    <!--main card body-->
                    <div class="card-body scroll">

                        <%if (ordersList.isEmpty()) {%>

                        <!--if user don't have any order then show this message-->
                        <div class="text-center">
                            <h3>You have not order any item..!</h3>
                        </div>

                        <%
                        } else {

                            //fetch single product details by ordered product id
                            for (Order o : ordersList) {

                                Product orderPrd = new ProductDao().getProductById(Integer.parseInt(o.getProductId()));
                        %>

                        <!--link for go to order details page-->
                        <a href="order_details.jsp?o_id=<%= o.getId()%>" class="text-link">

                            <!--single order card-->
                            <div class="card mt-3">

                                <!--single order card body-->
                                <div class="card-body">

                                    <div class="row">

                                        <!--product image column-->
                                        <div class="col-md-3 text-center my-auto">
                                            <img src="img/products/<%= orderPrd.getPhoto()%>" alt="Product Image" class="product-list-img">
                                        </div>

                                        <!--product name and order date column-->
                                        <div class="col-md-7 mt-auto">

                                            <!--product name-->
                                            <h4 class="mb-4"><%= orderPrd.getTitle()%></h4>

                                            <!--order date-->
                                            <h6 class="text-uppercase">ordered on: <%= o.getOrderDate().toLocaleString()%></h6>
                                        </div>

                                        <!--right arrow button column-->
                                        <div class="col-md-2 text-center my-auto">
                                            <i class="fa fa-chevron-circle-right fa-2x text-secondary"></i>
                                        </div>

                                    </div>
                                    <!--end row-->

                                </div>
                                <!--end single order card body-->

                            </div>
                            <!--end single order card-->

                        </a>
                        <!--end order details page link-->

                        <%}
                            }%>

                    </div>
                    <!--end main card body-->

                </div>
                <!--end main card-->

            </div>
            <!--end modal body-->

            <!--start modal footer-->
            <div class="modal-footer">

                <!--modal close button-->
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

            </div>
            <!--end modal footer-->

        </div>
    </div>
</div>