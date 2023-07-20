<%@page import="com.emart.dataobject.CartDao"%>
<%@page import="com.emart.entities.User"%>
<%@page import="com.emart.helper.FactoryProvider"%>
<%@page import="com.emart.dataobject.CategoryDao"%>
<%@page import="com.emart.entities.Category"%>
<%@page import="com.emart.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.emart.dataobject.ProductDao"%>

<%
    //fetch category id
    String catId = request.getParameter("catId");
    List<Product> products = null;

    //if category not mention then show all product
    if (catId == null) {

        products = new ProductDao().getAllProduct();

    } else {

        products = new ProductDao().getAllProductByCId(Integer.parseInt(catId));
    }

    //access all category from database
    List<Category> categories = new CategoryDao().getAllCategory(FactoryProvider.getFactory());

    //access current user from http session
    User showProductuUser = (User) session.getAttribute("currentUser");

    List<Product> pList = null;

    //if user logged in then store all the product id from from user wishlist
    if (showProductuUser != null) {

        pList = new CartDao().getAllProductFromCartByUserId(showProductuUser.getId());
    }
%>

<!--start category bar-->
<nav class="navbar navbar-expand-lg navbar-light default-bg">

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mt-1">

            <!--button to show all product-->
            <li class="nav-item active mb-2">
                <a class="nav-link btn btn-info text-white" href="index.jsp">All Products</a>
            </li>

            <%for (Category c : categories) {%>

            <!--button to show particular category-->
            <li class="nav-item active mb-2">
                <a class="nav-link btn btn-info text-white mx-2" href="index.jsp?catId=<%= c.getId()%>"><%= c.getName()%></a>
            </li>

            <%}%>

        </ul>
    </div>

</nav>
<!--end category bar-->

<!--success or failure message-->
<div class="col-md-4 offset-md-4">
    <%@include file="message.jsp" %>
</div>

<!--start main view-->
<div class="container">

    <!--start row-->
    <div class="row">

        <%if (products.isEmpty()) {%>

        <!--if no product available-->
        <div class="container text-center mt-5">
            <h2 class="display-4 mt-5">No products in this category..!!</h2>
        </div>

        <%} else {

            for (Product p : products) {

                boolean isSaved = false;

                //check cart is empty or not
                if (pList != null) {

                    for (int i = 0; i < pList.size(); i++) {

                        //check the current product is saved in wishlist or not
                        if (pList.get(i).getId() == p.getId()) {

                            isSaved = true;
                        }
                    }
                }
        %>

        <!--view for a particular product-->
        <div class="col-md-4 my-3">

            <!--start product card-->
            <div class="card">

                <!--button for product details-->
                <a href="product_details.jsp?p_id=<%= p.getId()%>" target="_blank" class="nav-link">

                    <!--start card body-->
                    <div class="card-body">

                        <!--product image-->
                        <div class="text-center">
                            <img src="img/products/<%= p.getPhoto()%>" alt="Product Image" class="card-img-top mb-3 product-view-img">
                        </div>

                        <!--product name-->
                        <h3 class="title-clr"><%= p.getTitle()%></h3>

                        <!--product description-->
                        <p class="my-1 desc-clr">

                            <%= p.getDescription()%>

                        </p>
                        <!--end description-->

                    </div>
                    <!--end card body-->

                </a>
                <!--end product details button-->

                <!--start card footer-->
                <div class="card-footer">

                    <!--add wishlist form-->
                    <form action="CartOperationServlet" method="post">

                        <input type="hidden" name="operation" value="add">
                        <input type="hidden" name="product" value="<%= p.getId()%>">

                        <!--check for wishlist contains this product or not-->
                        <%if (isSaved) {%>

                        <!--if product saved then show saved icon-->
                        <button type="button" disabled class="btn btn-secondary text-white text-uppercase font-weight-bold"><i class="fa fa-heart"></i> saved</button>

                        <%} else {%>

                        <!--add wishlist button-->
                        <button type="submit" class="btn btn-warning text-white text-uppercase font-weight-bold"><i class="fa fa-heart-o font-weight-bold"></i> wishlist</button>

                        <%}%>

                        <!--product price-->
                        <a href="#" class="btn price-btn font-weight-bold ml-2"><span>&#8377;</span> <%= p.getDiscountPrice()%></a>

                    </form>
                    <!--end form-->
                </div>
                <!--end card footer-->

            </div>
            <!--end product card-->

        </div>
        <!--end particular product view-->

        <%}
            }%>
    </div>
    <!--end row-->
</div>
<!--end main view-->