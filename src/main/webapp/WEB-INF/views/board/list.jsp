<%--
  Created by IntelliJ IDEA.
  User: WON
  Date: 2019-02-13
  Time: 오전 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp" %>

<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below. For more information about DataTables, please visit the <a target="_blank" href="https://datatables.net">official DataTables documentation</a>.</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>수정일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${list}" var="board">
                        <tr>
                            <td><c:out value="${ board.bno }" /></td>
                            <td><a class='move' href='<c:out value="${ board.bno }"/>'>
                                <c:out value="${ board.title }" />
                                <b>[ <c:out value="${board.replyCnt}" /> ]</b>
                            </a></td>
                            <td><c:out value="${ board.writer }" /></td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd"
                                                value="${ board.regDate }" /></td>
                            <td><fmt:formatDate pattern="yyyy-MM-dd"
                                                value="${ board.updateDate }" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<%@include file="../includes/footer.jsp" %>
