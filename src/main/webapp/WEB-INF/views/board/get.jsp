<%--
  Created by IntelliJ IDEA.
  User: WON
  Date: 2019-02-14
  Time: 오전 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>

<div class="container-fluid">
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary"><c:out value="${board.bno}"/>. <c:out value="${board.title}"/></h6>
        </div>
        <div class="card-body">

            <div class="form-group">
                <label>내용</label>
                <textarea class="form-control" rows="3" name="content"readonly="readonly"><c:out value="${board.content}"></c:out></textarea>
            </div>

            <div class="form-group">
                <label>작성자</label>
                <input type="text" class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly" >
            </div>

            <div class="row align-items-start">
                <div class="col-lg-1 col-md-6 mb-4 h-100 py-2">
                    <button class="btn btn-primary btn-block" data-oper='modify'>수정</button>
                </div>
                <div class="col-lg-1 col-md-6 mb-4 h-100 py-2">
                    <button class="btn btn-primary btn-block" data-oper='list'>글목록</button>
                </div>
            </div>
        </div>
    </div>
</div>

<form id='operForm' action="/board/modify" method="get">
    <input type='hidden' id='bno' name='bno'
           value='<c:out value="${board.bno}" />'> <input
        type='hidden' name='pageNum'
        value='<c:out value="${cri.pageNum}" />'> <input
        type='hidden' name='amount'
        value='<c:out value="${cri.amount}" />'> <input
        type='hidden' name='keyword'
        value='<c:out value="${cri.keyword}" />'> <input
        type='hidden' name='type' value='<c:out value="${cri.type}" />'>
</form>

<script>
    $(document).ready(function () {
        var operForm = $("#operForm");

        $("button[data-oper='modify']").on("click", function(e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function(e) {

            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });

    })

</script>

<%@ include file="../includes/footer.jsp" %>