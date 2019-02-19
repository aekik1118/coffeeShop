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

<style>
    ul{
        list-style:none;
        padding-left:0px;
    }
</style>

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

    <!-- reply -->

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <div class="row no-gutters align-items-start">
                <div class="col mr-4">
                    <h6 class="m-0 font-weight-bold text-primary">댓글</h6>
                </div>
                <div class="col-auto">
                    <button id="addReplyBtn" class='btn btn-primary btn-xs pull-right'>댓글 등록</button>
                </div>
            </div>
        </div>
        <div class="card-body">
            <ul>
                <li class='row'>
                    <div class='col mb-4'>
                        <div class='card border-left-primary shadow h-100 py-2'>
                            <div class='card-body'>
                                <form>
                                    <div class="form-group">
                                        <label>댓글 쓰기</label>
                                        <textarea class="form-control" rows="3" id='inputReply'></textarea>
                                    </div>
                                    <input type="hidden" name='replyer' value='Replyer' readonly="readonly">
                                </form>

                            </div>
                        </div>
                    </div>
                </li>
            </ul>

            <ul class="replybody">
                <li>
                    <div class='col mb-4'>
                        <div class='card border-left-primary shadow h-100 py-2'>
                            <div class='card-body'>
                                <div class='row align-items-start'>
                                    <div class='col mr-4'>
                                        <div class='text-xs font-weight-bold text-primary text-uppercase mb-1'>user00</div>
                                        <div class='h5 mb-0 font-weight-bold text-gray-800'>내용</div>
                                    </div>
                                    <div class='col-auto'>
                                        <div class='h5 mb-0 text-gray-800'>날짜</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>

        </div>

        <div class="card-footer replyfooter"></div>
    </div>

</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">댓글 설정</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-footer">
                <button id='modalReplyRemoveBtn' class="btn btn-danger" type="button" data-dismiss="modal">삭제</button>
                <button id='modalRegRereplyBtn' class="btn btn-primary" type="button" data-dismiss="modal">대댓글</button>
                <button id='modalCloseBtn' class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
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

<script src="/resources/js/reply.js"></script>

<script>
    $(document).ready(function () {

        /*board button*/

        var operForm = $("#operForm");


        $("button[data-oper='modify']").on("click", function(e) {
            operForm.attr("action", "/board/modify").submit();
        });

        $("button[data-oper='list']").on("click", function(e) {

            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });


        /*reply*/

        var bnoValue = '<c:out value="${board.bno}" />'
        var replyBody = $(".replybody");
        var replyFooter = $(".replyfooter");

        showList(-1);

        function showList(page) {
            replyService.getList({
                        bno : bnoValue,
                        page : page || 1
                    }, function(replyCnt, list) {

                        console.log("replyCnt: " + replyCnt);
                        console.log("list: " + list);
                        console.log(list);

                        if (page == -1) {
                            pageNum = Math.ceil(replyCnt / 10.0);
                            showList(pageNum);
                            return;
                        }

                        var str = "";
                        if (list == null || list.length == 0) {
                            replyBody.html("");
                            return;
                        }

                        for (var i = 0, len = list.length || 0; i < len; i++) {
                            str += "<li data-rno='"+list[i].rno+"' data-replyer='"+list[i].replyer+"'>\n" +
                                "                    <div class='col mb-4'>\n" +
                                "                        <div class='card border-left-primary shadow h-100 py-2'>\n" +
                                "                            <div class='card-body reply-card-body' >\n" +
                                "                                <div class='row align-items-start'>\n" +
                                "                                    <div class='col mr-4'>\n" +
                                "                                        <div class='text-xs font-weight-bold text-primary text-uppercase mb-1'>"+ list[i].replyer +"</div>\n" +
                                "                                        <div class='h5 mb-0 font-weight-bold text-gray-800'>"+list[i].reply+"</div>\n" +
                                "                                    </div>\n" +
                                "                                    <div class='col-auto'>\n" +
                                "                                        <div class='h5 mb-0 text-gray-800'>"+ replyService.displayTime(list[i].replyDate)+"</div>\n" +
                                "                                    </div>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>\n" +
                                "                    </div>\n" +
                                "                </li>"
                        }

                        replyBody.html(str);
                        showReplyPage(replyCnt);
            });

        }

        function showReplyPage(replyCnt) {

            var endNum = Math.ceil(pageNum / 10.0) * 10;
            var startNum = endNum - 9;

            var prev = startNum != 1;
            var next = false;

            if (endNum * 10 >= replyCnt) {
                endNum = Math.ceil(replyCnt / 10.0);
            }

            if (endNum * 10 < replyCnt) {
                next = true;
            }

            var str = "<ul class='pagination -pull-right'>";

            if (prev) {
                str += "<li class='page-item'><a class='page-link' href='"
                    + (startNum - 1)
                    + "'>Previous</a></li>";
            }

            for (var i = startNum; i <= endNum; i++) {
                var active = pageNum == i ? "active" : "";

                str += "<li class='page-item " + active+" '><a class='page-link' href='" + i + "'>"
                    + i + "</a></li>";
            }

            if (next) {
                str += "<li class='page-item'><a class='page-link' href='"
                    + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";
            replyFooter.html(str);
        }

        replyFooter.on("click", "li a", function(e) {
            e.preventDefault();
            console.log("page click");

            var targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            pageNum = targetPageNum;

            showList(pageNum);

        });

        /*reply add*/

        var addReplyBtn = $("#addReplyBtn");

        var InputReply = $("#inputReply");

        addReplyBtn.on("click", function (e) {

            console.log(InputReply.val());

            var reply = {
                reply : InputReply.val(),
                replyer : "testReplyer",
                bno : bnoValue
            };

            replyService.add(reply, function(result) {
                alert(result);

                //showList(1);
                showList(-1);
            });
        });
        
        /*reply modal*/

        var myModal = $("#myModal");
        var modalReplyRemoveBtn = $("#modalReplyRemoveBtn");
        var modalRegRereplyBtn = $("modalRegRereplyBtn");
        var replyCardBody = $("reply-card-body");
        var modalInputRno;


        replyBody.on("click","li", function (e) {
            var rno = $(this).data("rno");
            console.log(rno);
            replyService.get(rno, function(reply) {
                console.log("get success "+ reply.rno);
                myModal.data("rno", reply.rno);
                myModal.data("replyer",reply.replyer);
                myModal.modal("show");
            });

        });

        /*reply remove*/

        modalReplyRemoveBtn.on("click", function (e) {
            console.log("remove click!");
            var rno = myModal.data("rno");
            var replyer = myModal.data("replyer");
            console.log(rno);
            console.log(replyer);

            replyService.remove(rno, replyer, function(result) {
                alert(result);
                myModal.modal("hide");
                showList(-1);
            })
        });


    })

</script>

<%@ include file="../includes/footer.jsp" %>