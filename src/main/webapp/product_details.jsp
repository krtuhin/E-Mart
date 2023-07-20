<%@page import="com.emart.dataobject.ProductDao"%>

<%
    //fetch particular product by id
    Product p = new ProductDao().getProductById(Integer.parseInt(request.getParameter("p_id")));

    //fetch current user details
    User productDetailsUser = (User) session.getAttribute("currentUser");

    boolean isSaved = false;

    //check user logged in or not
    if (productDetailsUser != null) {

        //access all product from wishlist
        List<Product> myProducts = new CartDao().getAllProductFromCartByUserId(productDetailsUser.getId());

        //check wishlist null or not
        if (myProducts != null) {

            for (int i = 0; i < myProducts.size(); i++) {

                //check the wishlist contain the current product or not
                if (myProducts.get(i).getId() == p.getId()) {

                    isSaved = true;
                }
            }
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--add error page-->
<%@page errorPage="common_files/error_page.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Mart | Product details</title>

        <!--add bootstrap-->
        <%@include file="common_files/css_js.jsp" %>
    </head>
    <body>

        <!--add nav bar-->
        <%@include file="common_files/navbar.jsp" %>

        <!--error or success message-->
        <div class="col-md-6 offset-md-3">
            <%@include file="common_files/message.jsp"%>
        </div>

        <!--start main column-->
        <div class="col-md-10 offset-md-1 my-4">

            <!--start product details card-->
            <div class="card">

                <!--card body-->
                <div class="card-body">

                    <!--divide card body in two row-->
                    <div class="row my-3">

                        <!--start image and buttons column-->
                        <div class="col-md-4 mt-auto mb-auto">

                            <!--product image-->
                            <div class="text-center">
                                <img class="my-2 product-details-img" src="img/products/<%= p.getPhoto()%>" alt="Product Image">
                            </div>

                            <!--buttons row-->
                            <div class="row ml-4 mt-5">

                                <!--save wishlist form-->
                                <form action="CartOperationServlet" method="post">

                                    <input type="hidden" name="operation" value="p-add">
                                    <input type="hidden" name="product" value="<%= p.getId()%>">

                                    <!--check the product is already saved in wishlist or not-->
                                    <%if (isSaved) {%>

                                    <!--already saved icon-->
                                    <button type="button" disabled class="btn btn-secondary text-uppercase text-white font-weight-bold mr-3 ml-5">
                                        <i class="fa fa-heart font-weight-bold"></i> Saved
                                    </button>

                                    <%} else {%>

                                    <!--wishlist button-->
                                    <button type="submit" class="btn btn-success text-uppercase text-white font-weight-bold mr-3">
                                        <i class="fa fa-heart-o font-weight-bold"></i> Add to wishlist
                                    </button>

                                    <%}%>

                                </form>
                                <!--end form-->

                                <!--order button-->
                                <a href="address_page.jsp?pid=<%= p.getId()%>" class="btn btn-warning text-uppercase text-white font-weight-bold">Order now</a>

                            </div>
                            <!--end buttons row-->

                        </div>
                        <!--end image and buttons column-->

                        <!--start product details column-->
                        <div class="col-md-8 mt-auto">

                            <!--product name-->
                            <h2><%= p.getName()%></h2>

                            <!--product price details-->
                            <h3 class="font-weight-bold my-1">

                                <!--price after discount-->
                                &#8377;<%= p.getDiscountPrice()%>/- 

                                <!--original price-->
                                <small class="text-muted pl-2" style="text-decoration: line-through">
                                    &#8377;<%= p.getPrice()%>
                                </small>

                            </h3> 
                            <!--end product price-->

                            <!--product discount-->
                            <h5 class="text-success"><%= p.getDiscount()%>% off</h5>

                            <!--product quantity-->
                            <p class="text-primary"><%= p.getQuantity()%> items left</p>

                            <!--product description-->
                            <p><%= p.getDesc()%></p>

                            <!--cash and return symbol-->
                            <div class="row col-md-10 offset-md-1">

                                <!--cash on delivery symbol-->
                                <div class="col-md-6 text-danger text-center">
                                    <i class="fa fa-inr fa-2x mb-2"></i><br>
                                    <h5>Cash On Delivery</h5>
                                </div>

                                <!--product return symbol-->
                                <div class="col-md-6 text-danger text-center">
                                    <i class="fa fa-undo fa-2x mb-2"></i>
                                    <h5>Return Available</h5>
                                </div>

                            </div>
                            <!--end return symbol-->

                        </div>
                        <!--end product details column-->

                    </div>
                    <!--end card body divide-->

                </div>    
                <!--end card body-->

            </div>   
            <!--end product details card-->

        </div>
        <!--end main column-->

    </body>
</html>