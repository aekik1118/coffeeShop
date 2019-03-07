<%--
  Created by IntelliJ IDEA.
  User: JongSung
  Date: 2019-02-15
  Time: 오전 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            <table id="pd">
                    <c:forEach items="${list}" var="product" varStatus="status">

                        <c:if test="${status.index % 3 eq 0}"> <tr></c:if>
                            <td data-productid="${product.productId}">
                                <!-- Illustrations -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary"><c:out value="${product.productId}" /> </h6>
                                    </div>
                                    <div class="card-body">
                                        <div id="productImg" class="text-center">
                                            <c:choose>
                                                <c:when test="${product.imgPath eq null}">
                                                    <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="/resources/img/undraw_posting_photo.svg" alt="">
                                                </c:when>

                                                <c:otherwise>
                                                    <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="/productDisplay?fileName=${product.imgPath}" alt="">
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                        <c:out value="${product.explain}"/>
                                        <div>
                                            Price : <c:out value="${product.price}" />
                                            <c:if test="${product.ice eq true}"> ICE </c:if>
                                            <c:if test="${product.hot eq true}"> HOT </c:if>
                                        </div>
                                    </div>
                                </div>
                                <!-- end card shadow mb-4 -->
                            </td>
                        <c:if test="${status.count % 3 eq 0}"> <tr></c:if>

                    </c:forEach>

            </table>
        </div>
        <!-- end col-lg-6 mb-4 -->

        <!-- start pagination -->
        <div class="col-sm-12 col-md-7">
            <div class="col mr-2" align="center">
                <ul class="pagination">
                    <c:if test="${pageMaker.prev }">
                        <li class="page-item previous paginate_button"><a class="page-link" href="${pageMaker.startPage -1 }">Previous</a></li>
                    </c:if>

                    <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
                        <li class="page-item paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }" ><a class="page-link" href="${num }">${num }</a></li>
                    </c:forEach>

                    <c:if test="${pageMaker.next }">
                        <li class="page-item paginate_button next"><a class=page-link" href="${pageMaker.endPage +1 }">Next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
        <!-- end pagination -->

        <form id='actionForm' action="/product/list" method="get">
            <input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum }'>
            <input type="hidden" name="amount" value='${pageMaker.cri.amount }'>
        </form>
    </div>
    <!-- end row -->

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Register</h4>
            </div>

            <div class="form-group">
                <input type="text" class="orm-control form-control-user" name="productid" placeholder="Product Name">
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

            <div id="uploadDiv" class="form-group">
                <%--<input type="file" name="uploadFile" multiple>--%>
            </div>

            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>

<script src="/resources/js/product.js"></script>
<script>
    $(document).ready(function () {
        var actionForm = $("#actionForm");
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });
    });
</script>

<script>
    $(document).ready(function () {

        var myModal = $("#myModal");
        var modalInputProductId = myModal.find("input[name='productid']");
        var modalInputPrice = myModal.find("input[name='price']");
        var modalInputIce = myModal.find("input[name='ice']");
        var modalInputHot = myModal.find("input[name='hot']");
        var modalInputExplain = myModal.find("input[name='explain']");

        $("#ice").on("change", function(){
            if($(this).is(':checked')) $(this).attr('value', 'true');
            else $(this).attr('value', 'false');
        });

        $("#hot").on("change", function(){
            if($(this).is(':checked')) $(this).attr('value', 'true');
            else $(this).attr('value', 'false');
        });

        $("#regBtn").on("click", function () {
            var imgPath = "";
            var fileReg = "<input type='file' name='uploadFile' multiple>";
            $("#uploadDiv").html(fileReg);

            var str = " <button id=\"registerBtn\" class=\"btn btn-primary btn-icon-split\">\n" +
                "                    <span class=\"icon text-white-50\">\n" +
                "                      <i class=\"fas fa-check\"></i>\n" +
                "                    </span>\n" +
                "                    <span class=\"text\">Register</span>\n" +
                "                </button>\n" +
                "                <button id=\"cancelBtn\" class=\"btn btn-secondary btn-icon-split\">\n" +
                "                    <span class=\"icon text-white-50\">\n" +
                "                      <i class=\"fas fa-arrow-right\"></i>\n" +
                "                    </span>\n" +
                "                    <span class=\"text\">Cancel</span>\n" +
                "                </button>";
            $(".modal-footer").html(str);

            $("#myModal").modal("show");


            var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            var maxSize = 5242880; //5MB

            function checkExtension(fileName, fileSize) {

                if(fileSize >= maxSize) {
                    alert("파일 사이즈 초과!");
                    return false;
                }

                if(regex.test(fileName)) {
                    alert("해당 종류의 파일은 업로드 할 수 없습니다.");
                    return false;
                }

                return true;
            } // end checkExtension

            var uuid = null;
            var fileName = null;
            var uploadPath = null;

            $("#uploadDiv").on("change", "input", function () {
                var formData = new FormData();
                var inputFile = $("input[name='uploadFile']");
                var files = inputFile[0].files;

                for(var i = 0; i < files.length; i++) {

                    if(!checkExtension(files[i].name, files[i].size)) return false;

                    formData.append("uploadFile", files[i]);
                }

                $.ajax({
                    url: '/productUpload',
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: 'POST',
                    dataType: 'json',
                    success: function (obj, result) {
                        console.log("upload : " + result);

                        uuid = obj[0].uuid;
                        fileName = obj[0].fileName;
                        uploadPath = obj[0].uploadPath;

                        var fileCallPath = encodeURIComponent(obj[0].uploadPath + "/s_" + obj[0].uuid + "_" + obj[0].fileName);
                        imgPath = fileCallPath;

                        var str = obj[0].fileName + " ";
                        str += "<button id='productDelete' data-file=\'" + fileCallPath + "\'> Delete </button>";

                        $("#uploadDiv").html(str);
                    }
                }); // end productUpload ajax
            }); // uploadDiv input on change


            $("#uploadDiv").on("click", "button", function () {
               console.log("delete file");
               var targetFile = $(this).data("file");
               console.log(targetFile);

               productService.deleteFile(targetFile, function (result) {
                   if(result == "delete") {
                       $("#uploadDiv").html(fileReg);

                       imgPath = "";
                       uuid = null;
                       fileName = null;
                       uploadPath = null;
                   }
               })
            }); // end uploadDiv button on click

            $("#registerBtn").on("click", function (e) {
                var product;

                if(uuid != null) {
                    product = {
                        productId : modalInputProductId.val(),
                        price : modalInputPrice.val(),
                        ice : modalInputIce.val(),
                        hot : modalInputHot.val(),
                        explain : modalInputExplain.val(),
                        imgPath : imgPath,
                        attach : {
                            uuid : uuid,
                            fileName : fileName,
                            uploadPath : uploadPath,
                            productid : modalInputProductId.val()
                        }
                    };
                }
                else {
                    product = {
                        productId : modalInputProductId.val(),
                        price : modalInputPrice.val(),
                        ice : modalInputIce.val(),
                        hot : modalInputHot.val(),
                        explain : modalInputExplain.val(),
                        imgPath : "",
                        attach : null
                    };
                }

                console.log(product);
                productService.register(product, function (result) {
                    console.log(product);
                    alert(result);

                    imgPath = "";
                    myModal.modal("hide");
                    location.reload();
                });

            }); // end registerBtn on click


            $("#cancelBtn").on("click", function () {
                myModal.modal("hide");

            }); // cancelBtn on click

            myModal.on('hide.bs.modal', function(e) {
                console.log(imgPath);
                if (imgPath != "") {
                    productService.deleteFile(imgPath);
                    imgPath = "";
                }

                myModal.find("input").val("");
                $("#uploadDiv").html("");
                modalInputIce.removeAttr("checked");
                modalInputHot.removeAttr("checked");
                console.log('modal close');

                location.reload();
            });

        }); // end regBtn on click

        $("#pd").on("click", "td", function () {
            var productid = $(this).data("productid");
            var flag = 0;

            var originalPath = "";
            var imgPath = "";
            var trashPath = "";

            var attach = {
                uuid : null,
                fileName : null,
                uploadPath : null,
                productid : productid
            };


            modalInputProductId.attr("readonly", "readonly");

            productService.get(productid, function (product) {
                console.log(product);

                modalInputProductId.val(product.productId);
                modalInputPrice.val(product.price);
                modalInputIce.val(product.ice);
                if(product.ice == true) modalInputIce.attr("checked", "checked");
                if(product.hot == true) modalInputHot.attr("checked", "checked");
                modalInputExplain.val(product.explain);
                originalPath = product.imgPath;

                if(originalPath == null) {
                    var fileReg = "<input type='file' name='uploadFile' multiple>";
                    $("#uploadDiv").html(fileReg);
                }

            });


            $.getJSON("/product/getAttach", {productid : productid}, function (obj) {

                if(obj != null) {
                    console.log(obj);

                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                    var uploaded = obj.fileName + " " + "<button id='productDelete' data-file=\'" + fileCallPath + "\'> Delete </button>";
                    $("#uploadDiv").html(uploaded);
                }

            }); // end getJSON

            var str = "<button id=\"updateBtn\" class=\"btn btn-primary btn-icon-split\">\n" +
                "                    <span class=\"icon text-white-50\">\n" +
                "                      <i class=\"fas fa-check\"></i>\n" +
                "                    </span>\n" +
                "                    <span class=\"text\">Update</span>\n" +
                "                </button>\n" +
                "                <button id=\"removeBtn\" class=\"btn btn-danger btn-icon-split\">\n" +
                "                    <span class=\"icon text-white-50\">\n" +
                "                      <i class=\"fas fa-trash\"></i>\n" +
                "                    </span>\n" +
                "                    <span class=\"text\">Remove</span>\n" +
                "                </button>\n" +
                "                <button id=\"cancelBtn\" class=\"btn btn-secondary btn-icon-split\">\n" +
                "                    <span class=\"icon text-white-50\">\n" +
                "                      <i class=\"fas fa-arrow-right\"></i>\n" +
                "                    </span>\n" +
                "                    <span class=\"text\">Cancel</span>\n" +
                "                </button>";

            $(".modal-footer").html(str);

            myModal.modal("show");

            var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            var maxSize = 5242880; //5MB

            function checkExtension(fileName, fileSize) {

                if(fileSize >= maxSize) {
                    alert("파일 사이즈 초과!");
                    return false;
                }

                if(regex.test(fileName)) {
                    alert("해당 종류의 파일은 업로드 할 수 없습니다.");
                    return false;
                }

                return true;
            } // end checkExtension

            $("#uploadDiv").on("change", "input", function () {
                console.log("uploadDiv input change!!");
                var formData = new FormData();
                var inputFile = $("input[name='uploadFile']");
                var files = inputFile[0].files;

                for(var i = 0; i < files.length; i++) {

                    if(!checkExtension(files[i].name, files[i].size)) return false;

                    formData.append("uploadFile", files[i]);
                }

                $.ajax({
                    url: '/productUpload',
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: 'POST',
                    dataType: 'json',
                    success: function (obj, result) {
                        console.log("upload : " + result);

                        attach.uuid = obj[0].uuid;
                        attach.fileName = obj[0].fileName;
                        attach.uploadPath = obj[0].uploadPath;

                        var fileCallPath = encodeURIComponent(obj[0].uploadPath + "/s_" + obj[0].uuid + "_" + obj[0].fileName);
                        imgPath = fileCallPath;

                        var str = obj[0].fileName + " ";
                        str += "<button id='productDelete' data-file=\'" + fileCallPath + "\'> Delete </button>";

                        $("#uploadDiv").html(str);
                    }
                }); // end productUpload ajax
            }); // uploadDiv input on change


            $("#uploadDiv").on("click", "button", function () {
                var targetFile = $(this).data("file");
                console.log("delete file : " + targetFile);
                var fileReg = "<input type='file' name='uploadFile' multiple>";

                if(targetFile == originalPath) {
                    console.log("originalPath = targetFile");
                    $("#uploadDiv").html(fileReg);
                    flag = 1;
                    trashPath = originalPath;
                    originalPath = "";
                }

                else {
                    productService.deleteFile(targetFile, function(result) {
                        if(result == "delete") {
                            alert(result);
                            $("#uploadDiv").html(fileReg);

                            imgPath = "";
                            attach.uuid = null;
                            attach.fileName = null;
                            attach.uploadPath = null;
                        }
                    });
                }

            }); // end uploadDiv button on click

            $("#updateBtn").on("click", function () {
                var product;

                if(attach.uuid != null) {
                    console.log("update attach : " + attach);
                    product = {
                        productId : modalInputProductId.val(),
                        price : modalInputPrice.val(),
                        ice : modalInputIce.val(),
                        hot : modalInputHot.val(),
                        explain : modalInputExplain.val(),
                        imgPath : imgPath,
                        attach : attach
                    };
                }
                else {
                    product = {
                        productId : modalInputProductId.val(),
                        price : modalInputPrice.val(),
                        ice : modalInputIce.val(),
                        hot : modalInputHot.val(),
                        explain : modalInputExplain.val(),
                        imgPath : originalPath,
                        attach : null
                    };
                }



                console.log("update product : " + product);
                productService.update(product, function (result) {
                    alert(result);

                    if(result == "success") {

                        if(flag == 1) {
                            productService.deleteFile(trashPath, function(result) {
                                if(result == "delete") console.log("original file delete");
                            });

                            flag = 0;
                        }

                        imgPath = "";
                    }

                    myModal.modal("hide");
                    location.reload();
                });

            }); // end updateBtn on click

            $("#removeBtn").on("click", function () {
                if(originalPath != null) {
                    productService.deleteFile(originalPath, function (result) {
                        console.log(result);
                    });
                }

                productService.remove(productid, function (result) {
                    console.log(result);
                });


                myModal.modal("hide");
                location.reload();

            }); // end removeBtn on click



            $("#cancelBtn").on("click", function () {
                /*if(imgPath != "") {
                    productService.deleteFile(imgPath);
                }*/

                myModal.modal("hide");
            }); // end cancelBtn on click

            $("#myModal").on('hide.bs.modal', function() {
                console.log(imgPath);
                if(imgPath != "") {
                    productService.deleteFile(imgPath);
                    imgPath = "";
                }

                myModal.find("input").val("");
                $("#uploadDiv").html("");
                modalInputProductId.removeAttr("readonly");
                modalInputIce.removeAttr("checked");
                modalInputHot.removeAttr("checked");
                console.log('modal close');

                location.reload();
            });

        }); // end pd on click


    });
</script>

<%@include file="../includes/footer.jsp" %>