<%--
  Created by IntelliJ IDEA.
  User: WON
  Date: 2019-02-14
  Time: 오전 12:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>

<div class="container-fluid">
        <!-- Basic Card Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">글쓰기</h6>
            </div>
            <div class="card-body">

                <form role="form" action="/board/register" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>글제목</label>
                        <input type="text" class="form-control" name="title">
                    </div>

                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="3" name="content"></textarea>
                    </div>

                    <div class="form-group">
                        <label>작성자</label>
                        <input type="text" class="form-control" name="writer">
                    </div>

                    <div class="form-group">
                        <label>첨부파일</label>
                        <input type="file" class="form-control" name="uploadFile" multiple>
                    </div>

                    <button class="btn btn-primary btn-block">작성 완료</button>
                </form>
            </div>
        </div>
</div>

<%@include file="../includes/footer.jsp" %>
