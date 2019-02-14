<%--
  Created by IntelliJ IDEA.
  User: WON
  Date: 2019-02-14
  Time: 오전 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>

<div class="container-fluid">
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary"><c:out value="${board.bno}"/>. <c:out value="${board.title}"/> 수정</h6>
        </div>
        <div class="card-body">
            <form role="form" action="/board/modify" method="post">
                <div class="form-group">
                    <label>글제목</label>
                    <input type="text" class="form-control" name="title"
                           value='<c:out value="${board.title}" />'>
                </div>

                <div class="form-group">
                    <label>내용</label>
                    <textarea class="form-control" rows="3" name="content"><c:out value="${board.content}"></c:out></textarea>
                </div>

                <div class="form-group">
                    <label>작성자</label>
                    <input type="text" class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly" >
                </div>

                <div class="row">
                    <div class="col-xl-1 col-md-6 mb-4">
                        <button class="btn btn-primary btn-block" data-oper='modify'>수정</button>
                    </div>
                    <div class="col-xl-1 col-md-6 mb-4">
                        <button class="btn btn-danger btn-block" data-oper='remove'>삭제</button>
                    </div>
                    <div class="col-xl-1 col-md-6 mb-4">
                        <button class="btn btn-primary btn-block" data-oper='list'>글목록</button>
                    </div>
                </div>

                <input type="hidden" value="<c:out value="${board.bno}"/>" name="bno">

            </form>
        </div>
    </div>
</div>

<script>

    $(document).ready(function() {
        var formObj = $("form");

        $('button').on("click", function (e) {
            e.preventDefault();

            var operation = $(this).data("oper");

            console.log(operation);

            if (operation === 'remove') {
                formObj.attr("action", "/board/remove");
            } else if (operation === 'list') {
                //move to list
                formObj.attr("action", "/board/list").attr("method", "get");
                var pageNumTag = $("input[name='pageNum']").clone();
                var amountTag = $("input[name='amount']").clone();
                var typeTag = $("input[name='type']").clone();
                var keywordTag = $("input[name='keyword']").clone();

                formObj.empty();

                formObj.append(pageNumTag);
                formObj.append(amountTag);
                formObj.append(typeTag);
                formObj.append(keywordTag);
            } else if (operation === 'modify') {
                console.log("submit clicked");

                var str = "";
                $(".uploadResult ul li").each(function (i, obj) {
                    var jobj = $(obj);
                    console.dir(jobj);

                    str += "<input type='hidden' name='attachList[" + i + "].fileName' value = '" + jobj.data("filename") + "'>";
                    str += "<input type='hidden' name='attachList[" + i + "].uuid' value = '" + jobj.data("uuid") + "'>";
                    str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value = '" + jobj.data("path") + "'>";
                    str += "<input type='hidden' name='attachList[" + i + "].fileType' value = '" + jobj.data("type") + "'>";

                });
                formObj.append(str).submit();
            }
            formObj.submit();
        });
    });

</script>

<%@include file="../includes/footer.jsp" %>