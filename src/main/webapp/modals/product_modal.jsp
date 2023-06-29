<%@page import="java.util.List"%>
<%@page import="com.emart.helper.FactoryProvider"%>
<%@page import="com.emart.dataobject.CategoryDao"%>
<%@page import="com.emart.entities.Category"%>
<!--add product modal-->

<!--fetch category list from database-->
<% List<Category> categories = new CategoryDao().getAllCategory(FactoryProvider.getFactory()); %>

<!-- Modal -->
<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="product" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <!--modal body-->
            <div class="modal-body">

                <!--start card-->
                <div class="card">

                    <!--form heading-->
                    <div class="card-header bg-dark text-center text-white">
                        <h2 class="my-2">Add product here..!</h2>
                    </div>

                    <div class="card-body">

                        <!--start add product form-->
                        <form action="AddProductServlet" method="post" enctype="multipart/form-data">

                            <!--product name field-->
                            <div class="form-group">
                                <label for="title">Product name<span class="mendatory">*</span></label>
                                <input name="name" type="text" class="form-control" id="title" placeholder="Enter product name" required>
                            </div>

                            <!--description field-->
                            <div class="form-group">
                                <label for="description">Product description<span class="mendatory">*</span></label>
                                <textarea name="desc" class="form-control" id="description" placeholder="Enter product description" rows="3" required></textarea>
                            </div>

                            <!--price field-->
                            <div class="form-group">
                                <label for="price">Product price<span class="mendatory">*</span></label>
                                <input name="price" type="number" class="form-control" id="price" placeholder="Enter product price" required>
                            </div>

                            <!--discount field-->
                            <div class="form-group">
                                <label for="discount">Product discount<span class="mendatory">*</span></label>
                                <input name="discount" type="number" class="form-control" id="discount" placeholder="Enter product discount" required>
                            </div>

                            <!--quantity field-->
                            <div class="form-group">
                                <label for="quantity">Product quantity<span class="mendatory">*</span></label>
                                <input name="quantity" type="number" class="form-control" id="quantity" placeholder="Enter product quantity" required>
                            </div>

                            <!--drop down button for select category-->
                            <div class="form-group">
                                <label for="category">Product category<span class="mendatory">*</span></label>
                                <select name="category" id="category" class="form-control" required>

                                    <option disabled selected>--Select--</option>

                                    <!--fetch category from category list-->
                                    <%for (Category c : categories) {%>

                                    <option value="<%= c.getId()%>"><%= c.getName()%></option>

                                    <%}%>

                                </select>
                            </div>
                            <!--end of drop down-->

                            <!--product image field-->
                            <div class="form-group">
                                <label for="image">Product image<span class="mendatory">*</span></label>
                                <input name="photo" type="file" class="form-control" id="image" required>
                            </div>

                            <!--submit and reset button-->
                            <div class="text-center">
                                <button type="submit" class="btn btn-success">Save</button>
                                <button type="reset" class="btn btn-secondary">Reset</button>
                            </div>
                        </form>
                        <!--end of product form-->
                    </div>
                </div>
                <!--end card-->

            </div>

            <!--button for close the modal-->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>