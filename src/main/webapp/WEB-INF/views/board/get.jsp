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
<%@include file="../includes/header.jsp" %>

<div class="container-fluid">
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">글쓰기</h6>
        </div>
        <div class="card-body">

            <div class="form-group">
                <label>번호</label>
                <input type="text" class="form-control" name="bno"
                       value='<c:out value="${board.bno}" />' readonly="readonly">
            </div>

            <div class="form-group">
                <label>글제목</label>
                <input type="text" class="form-control" name="title"
                       value='<c:out value="${board.title}" />' readonly="readonly">
            </div>

            <div class="form-group">
                <label>내용</label>
                <textarea class="form-control" rows="3" name="content"readonly="readonly"><c:out value="${board.content}"></c:out></textarea>
            </div>

            <div class="form-group">
                <label>작성자</label>
                <input type="text" class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly" >
            </div>


        </div>
    </div>

</div>

<%@include file="../includes/footer.jsp" %>