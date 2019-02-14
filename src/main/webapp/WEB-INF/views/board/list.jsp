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
            <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                    <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                </div>

            </div>
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
        <div class="card-footer">

            <div class="row">

                    <form id="searchForm" action="/board/list" method="get">

                            <select name="type">
                                <option value=""
                                        <c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
                                <option value="T"
                                        <c:out value="${pageMaker.cri.type == 'T' ? 'selected':'' }" />>제목</option>
                                <option value="C"
                                        <c:out value="${pageMaker.cri.type == 'C' ? 'selected':'' }" />>내용</option>
                                <option value="W"
                                        <c:out value="${pageMaker.cri.type == 'W' ? 'selected':'' }" />>작성자</option>
                                <option value="TC"
                                        <c:out value="${pageMaker.cri.type == 'TC' ? 'selected':'' }" />>제목
                                    or 내용</option>
                                <option value="TW"
                                        <c:out value="${pageMaker.cri.type == 'TW' ? 'selected':'' }" />>제목
                                    or 작성자</option>
                                <option value="TWC"
                                        <c:out value="${pageMaker.cri.type == 'TWC' ? 'selected':'' }" />>제목
                                    or 내용 or 작성자</option>
                            </select>

                            <input type='text' name='keyword' class="bg-light border-0 small d-none d-sm-inline-block form-inline navbar-search" aria-label="Search" aria-describedby="basic-addon2"
                                   value='<c:out value="${pageMaker.cri.keyword }" />' /> <input
                                type='hidden' name='pageNum'
                                value='<c:out value="${pageMaker.cri.pageNum }" />'> <input
                                type='hidden' name='amount'
                                value='<c:out value="${pageMaker.cri.amount }" />'>
                            <button class="btn btn-primary" type="button">
                                <i class="fas fa-search fa-sm"></i>
                            </button>
                    </form>
            </div>

            <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                    <ul class="pagination">
                        <c:if test="${pageMaker.prev}">
                            <li class="btn paginate_button previous"><a class="text"
                                                                        href="${pageMaker.startPage -1 }">Previous</a></li>
                        </c:if>

                        <c:forEach var="num" begin="${pageMaker.startPage}"
                                   end="${pageMaker.endPage}">
                            <li class="btn paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }"><a class="text"
                                                                                                              href="${num}">${num}</a></li>
                        </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li class="btn paginate_button next"><a class="text"
                                                                    href="${pageMaker.endPage +1 }">Next</a></li>
                        </c:if>
                    </ul>
                </div>
                <div class="col-auto">
                    <a class="btn btn-primary -align-right" href="/board/register">글작성</a>
                </div>
            </div>
        </div>
    </div>

</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>

            <div class="modal-body">처리가 완료되었습니다.</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save
                    changes</button>
            </div>
        </div>
    </div>
</div>

<form id='actionForm' action="/board/list" method='get'>
    <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
    <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
    <input type='hidden' name='type'
           value='<c:out value="${ pageMaker.cri.type }" />'> <input
        type='hidden' name='keyword'
        value='<c:out value="${ pageMaker.cri.keyword }" />'>
</form>

<script>
    $(document).ready(function () {

        var result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {
            if (result === '' || history.state) {
                return;
            }

            if (parseInt(result) > 0) {
                $(".modal-body").html("게시글 " + parseInt(result)
                    + " 번이 등록되었습니다.");
            }

            $("#myModal").modal("show");
        }

        var actionForm = $("#actionForm");

        $(".move").on("click",function(e) {
            e.preventDefault();
            actionForm.append("<input type='hidden' name='bno' value='"
                + $(this).attr("href")
                + "'>");
            actionForm.attr("action","/board/get");
            actionForm.submit();
        })

        $(".paginate_button a").on(
            "click",
            function(e) {

                e.preventDefault();

                console.log('click');

                actionForm.find("input[name='pageNum']")
                    .val($(this).attr("href"));
                actionForm.submit();
            });

        var searchForm = $("#searchForm");

        $("#searchForm button").on(
            "click",
            function(e) {
                if (!searchForm.find("option:selected")
                    .val()) {
                    alert("검색종류를 선택하세요");
                    return false;
                }

                if (!searchForm.find(
                    "input[name='keyword']").val()) {
                    alert("키워드를 입력하세요");
                    return false;
                }

                searchForm.find("input[name='pageNum']")
                    .val("1");
                e.preventDefault();

                searchForm.submit();

            })



    })

</script>

<%@include file="../includes/footer.jsp" %>
