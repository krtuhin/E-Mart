<!--add category form modal-->

<!-- Modal -->
<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="category" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">

            <!--modal body-->
            <div class="modal-body">

                <!--start card-->
                <div class="card">

                    <!--display heading-->
                    <div class="card-header text-center bg-dark text-white">
                        <span class="fa fa-sitemap fa-3x"></span>
                        <h3 class="">Add category here..!</h3>
                    </div>

                    <!--card body/ start category form-->
                    <div class="card-body mx-4">
                        <form action="AddCategoryServlet" method="post">

                            <!--category name field-->
                            <div class="form-group">
                                <label for="catName">Category name<span class="mendatory">*</span></label>
                                <input class="form-control" id="catName" name="name" type="text" placeholder="Enter category name" required>
                            </div>

                            <!--category description field-->
                            <div class="form-group">
                                <label for="catDesc">Category description<span class="mendatory">*</span></label>
                                <textarea class="form-control" id="catDesc" name="description" placeholder="Enter category description" rows="3" required></textarea>
                            </div>

                            <!--submit and reset button-->
                            <div class="text-center">
                                <button type="submit" class="btn btn-success">Save</button>
                                <button type="reset" class="btn btn-secondary">Reset</button>
                            </div>
                        </form>
                        <!--end of category form-->

                    </div>
                </div>
                <!--end of card-->

            </div>

            <!--button for close the modal-->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>