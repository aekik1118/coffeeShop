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

    <%--upload file--%>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <div class="row no-gutters align-items-start">
                <div class="col mr-4">
                    <h6 class="m-0 font-weight-bold text-primary">첨부파일</h6>
                </div>
            </div>
        </div>
        <div class="card-body">
            <ul>
                <c:forEach items="${board.attachList}" var="attach">
                    <li>
                        <a href="/board/download?fileName=<c:out value="${attach.fileDownloadURI}"/>"> <c:out value="${attach.fileName}"/> </a>
                    </li>
                </c:forEach>
            </ul>
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
                        <div class='card shadow h-100 py-2'>
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
                <h5 class="modal-title" id="exampleModalLabel">답글 달기</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label>댓글 쓰기</label>
                        <textarea class="form-control" rows="3" id='inputReReply'></textarea>
                    </div>
                    <input type="hidden" name='replyer' value='Replyer' readonly="readonly">
                </form>
            </div>

            <div class="modal-footer">
                <button id='modalRegRereplyBtn' class="btn btn-primary" type="button" data-dismiss="modal">등록</button>
                <button id='modalCloseBtn' class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="removeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="removeModalLabel">삭제 확인</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
               <h2>해당 댓글을 삭제하시겠습니까?</h2>
            </div>
            <div class="modal-footer">
                <button id='modalRemoveRereplyBtn' class="btn btn-danger" type="button" data-dismiss="modal">삭제</button>
                <button id='removeModalCloseBtn' class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
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
<script src="/resources/js/rereply.js"></script>

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
                            str += "<li>\n" +
                                "                    <div class='col mb-4'>\n" +
                                "                        <div class='card shadow h-100 py-2'>\n" +
                                "                            <div class='card-body reply-card-body' >\n" +
                                "                                <div class='row align-items-start no-gutters'>\n" +
                                "                                    <div class='col-10'>\n" +
                                "                                        <div class='text-xs font-weight-bold text-primary text-uppercase mb-1'>"+ list[i].replyer +"</div>\n" +
                                "                                        <div class='h5 mb-0 font-weight-bold text-gray-800'>"+list[i].reply+"</div>\n" +
                                "                                    </div>\n" +
                                "                                    <div class='col-auto align-self-center'>\n" +
                                "                                        <div class='h5 mb-0 text-gray-800'>"+ replyService.displayTime(list[i].replyDate)+"</div>\n" +
                                "                                        <div class='h5 mb-0 text-gray-800 btn' id=replyRemoveBtn data-rno='"+list[i].rno+"' data-replyer='"+list[i].replyer+"'> 삭제 </div>" +
                                "                                    </div>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                            <div class='card-footer py-sm-0'>\n" +
                                "                            <ul id='rerepliesbody'>" +
                                "                                <div class='row align-items-start'>\n" +
                                "                                    <div class='col-auto'>\n" +
                                "                                        <div class= 'h5 mb-0 text-gray-800 btn' id='rereplyregbtn' data-rno='"+list[i].rno+"' data-replyer='"+list[i].replyer+"'> 답글  </div>\n" +
                                "                                    </div>\n";
                                 if(list[i].reReplyCount > 0){
                                     str += "                                    <div class='col-auto'>\n" +
                                     "                                        <div class= 'h5 mb-0 text-gray-800 btn' id='rereplylistbtn' data-rno='"+list[i].rno+"' data-replyer='"+list[i].replyer+"' data-rereplycount = '"+list[i].reReplyCount+"'> 답글 "+list[i].reReplyCount+"개 보기  </div>\n" +
                                     "                                    </div>\n";
                                 }
                                str += "                                </div>" +
                                "                            </ul>" +
                                "                            </div>\n" +
                                "                        </div>\n" +
                                "                    </div>\n" +
                                "                </li>";
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

       /*replyRemove*/

        var removeModal = $("#removeModal");
        var modalRemoveRereplyBtn = $("#modalRemoveRereplyBtn");


        replyBody.on("click","#replyRemoveBtn",function (e) {
            var rno = $(this).data("rno");
            var replyer = $(this).data("replyer");

            removeModal.data("rno", rno);
            removeModal.data("replyer", replyer);
            removeModal.data("isreply", true);
            removeModal.modal();
        });

        modalRemoveRereplyBtn.on("click",function (e) {
            var rno = removeModal.data("rno");
            var replyer = removeModal.data("replyer");

            if( removeModal.data("isreply")){
                replyService.remove(rno, replyer, function (result) {
                    alert(result);
                    removeModal.modal("hide");
                    showList(-1);
                });
            } else {
                reReplyService.remove(rno, replyer, function (result) {
                    alert(result);
                    removeModal.modal("hide");
                    showList(-1);
                });
            }
        });
        /*rereply modal*/

        var myModal = $("#myModal");
        var modalRegRereplyBtn = $("#modalRegRereplyBtn");
        var inputReReply = $("#inputReReply");
        var replyCardBody = $("reply-card-body");

        modalRegRereplyBtn.on("click",function (e) {
            var rno = myModal.data("rno");
            var replyer = myModal.data("replyer");
            var reply = inputReReply.val();

            var reReply = {
                reply : reply,
                replyer : replyer,
                bno : bnoValue,
                parentRno : rno
            };

            reReplyService.add(reReply,function (result) {
                alert(result);
                showList(-1);
            })

        });

        /*rereply*/

        replyBody.on("click","#rereplyregbtn", function (e) {
            var rno = $(this).data("rno");
            var replyer = $(this).data("replyer");

            console.log(rno);
            console.log(replyer);

            myModal.data("rno", rno);
            myModal.data("replyer",replyer);
            myModal.modal("show");
        });

        replyBody.on("click","#rereplylistbtn", function (e) {
            var rno = $(this).data("rno");
            var replyer = $(this).data("replyer");
            var reReplyCount = $(this).data("rereplycount");
            var rerepliesBody = $(this).closest("ul");
            var str = "";

            reReplyService.getList(rno, function(list){

                console.log("getrerepliesList" + rno);


                if (list == null || list.length == 0) {
                    console.log("null?");
                    return;
                }

                str += "<div class='mt-4'></div>";

                for(var i=0; i<list.length; i++){
                    str += "<li>\n" +
                        "                    <div class='col mb-4'>\n" +
                        "                        <div class='card shadow h-100 py-2'>\n" +
                        "                            <div class='card-body reply-card-body' >\n" +
                        "                                <div class='row align-items-start'>\n" +
                        "                                    <div class='col-10'>\n" +
                        "                                        <div class='text-xs font-weight-bold text-primary text-uppercase mb-1'>"+ list[i].replyer +"</div>\n" +
                        "                                        <div class='h5 mb-0 font-weight-bold text-gray-800'>"+list[i].reply+"</div>\n" +
                        "                                    </div>\n" +
                        "                                    <div class='col-auto align-self-center'>\n" +
                        "                                        <div class='h5 mb-0 text-gray-800'>"+ replyService.displayTime(list[i].replyDate)+"</div>\n" +
                        "                                        <div class='h5 mb-0 text-gray-800 btn' id=reReplyRemoveBtn data-rno='"+list[i].rno+"' data-replyer='"+list[i].replyer+"'> 삭제 </div>" +
                        "                                    </div>\n" +
                        "                                </div>\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                    </div>\n" +
                        "                </li>" ;
                }

                str +=  "<div class='row align-items-start'>\n" +
                    "    <div class='col-auto'>\n" +
                    "        <div class= 'h5 mb-0 text-gray-800 btn' id='rereplyregbtn' data-rno='"+rno+"' data-replyer='"+replyer+"'> 답글  </div>\n" +
                    "    </div>\n" +
                    "    <div class='col-auto'>\n" +
                    "        <div class= 'h5 mb-0 text-gray-800 btn' id='rereplylistHidebtn' data-rno='"+rno+"' data-replyer='"+replyer+"' data-rereplycount = '"+reReplyCount+"'> 답글 숨기기 </div>\n" +
                    "    </div>\n" +
                    "</div>\n";
                rerepliesBody.html(str);
            });
        });

        replyBody.on("click","#rereplylistHidebtn", function (e) {
            console.log("listHide");
            var rno = $(this).data("rno");
            var replyer = $(this).data("replyer");
            var rerepliesBody = $(this).closest("ul");
            var reReplyCount = $(this).data("rereplycount");
            var str = "";

            str +=  "<div class='row align-items-start'>\n" +
                "    <div class='col-auto'>\n" +
                "        <div class= 'h5 mb-0 text-gray-800 btn' id='rereplyregbtn' data-rno='"+rno+"' data-replyer='"+replyer+"'> 답글  </div>\n" +
                "    </div>\n" +
                "    <div class='col-auto'>\n" +
                "        <div class= 'h5 mb-0 text-gray-800 btn' id='rereplylistbtn' data-rno='"+rno+"' data-replyer='"+replyer+"' data-rereplycount = '"+reReplyCount+"'> 답글 "+reReplyCount+"개 보기</div>\n" +
                "    </div>\n" +
                "</div>\n";
            rerepliesBody.html(str);
        });

        replyBody.on("click", "#reReplyRemoveBtn",function (e) {
            var rno = $(this).data("rno");
            var replyer = $(this).data("replyer");
            removeModal.data("rno", rno);
            removeModal.data("replyer", replyer);
            removeModal.data("isreply", false);
            removeModal.modal();
        });
    })

</script>

<%@ include file="../includes/footer.jsp" %>