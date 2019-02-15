<%--
  Created by IntelliJ IDEA.
  User: JongSung
  Date: 2019-02-15
  Time: 오전 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../includes/header.jsp" %>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Product List</h1>
        <button id="regBtn" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-flag"></i> Register</button>
    </div>

    <!-- Content Row -->
    <div class="row">

        <div class="col-lg-6 mb-4">

            <!-- Illustrations -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Illustrations</h6>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="/resources/img/undraw_posting_photo.svg" alt="">
                    </div>
                    <p>Add some quality, svg illustrations to your project courtesy of <a target="_blank" rel="nofollow" href="https://undraw.co/">unDraw</a>, a constantly updated collection of beautiful svg images that you can use completely free and without attribution!</p>
                    <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on unDraw &rarr;</a>
                </div>
            </div>

        </div>
        <!-- end col-lg-6 mb-4 -->
    </div>
    <!-- end row -->

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<div class="modal fade" id="regModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Register</h4>
            </div>

            <div class="form-group">
                <input type="text" class="form-control form-control-user" name="productid" placeholder="Product Name">
            </div>

            <div class="form-group row">
                <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="number" class="form-control form-control-user" name="price" placeholder="Price">
                </div>
                <div class="col-sm-6">
                    ICE <input type="checkbox"  id="ice" name="ice" value="false">
                    HOT <input type="checkbox"  id="hot" name="hot" value="false">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" name="explain" placeholder="Product explain">
                </div>
            </div>

            <div class="modal-footer">
                <button id="registerBtn" class="btn btn-primary btn-icon-split">
                    <span class="icon text-white-50">
                      <i class="fas fa-check"></i>
                    </span>
                    <span class="text">Register</span>
                </button>
                <button id="cancelBtn" class="btn btn-secondary btn-icon-split">
                    <span class="icon text-white-50">
                      <i class="fas fa-arrow-right"></i>
                    </span>
                    <span class="text">Cancel</span>
                </button>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/product.js"></script>
<script>
    $(document).ready(function () {

        $("#ice").on("change", function(){
            if($(this).is(':checked')) $(this).attr('value', 'true');
            else $(this).attr('value', 'false');
        });

        $("#hot").on("change", function(){
            if($(this).is(':checked')) $(this).attr('value', 'true');
            else $(this).attr('value', 'false');
        });

        $("#regBtn").on("click", function () {
            $("#regModal").modal("show");
        });

        var regModal = $("#regModal");
        var modalInputProductId = regModal.find("input[name='productid']");
        var modalInputPrice = regModal.find("input[name='price']");
        var modalInputIce = regModal.find("input[name='ice']");
        var modalInputHot = regModal.find("input[name='hot']");
        var modalInputExplain = regModal.find("input[name='explain']");

        $("#registerBtn").on("click", function () {

            var product = {
                productId : modalInputProductId.val(),
                price : modalInputPrice.val(),
                ice : modalInputIce.val(),
                hot : modalInputHot.val(),
                explain : modalInputExplain.val()
            };

            productService.register(product, function (result) {
                alert(result);

                regModal.find("input").val("");
                regModal.modal("hide");
            });
        });

        $("#cancelBtn").on("click", function () {
            regModal.modal("hide");
        });
    });
</script>

<%@include file="../includes/footer.jsp" %>
