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
            <form role="form" action="/board/modify" method="post" enctype="multipart/form-data">
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
                    <label>첨부파일 삭제</label>
                    <ul id="removeAttachList">
                        <c:forEach items="${board.attachList}" var="attach">
                            <li>
                                <c:out value="${attach.fileName}"/>
                                <button class="btn btn-danger" data-oper="remove" data-uuid="<c:out value="${attach.uuid}"/>" data-filename="<c:out value="${attach.fileName}"/>">파일 삭제</button>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="form-group">
                    <label>첨부파일 추가</label>
                    <input type="file" class="form-control" name="uploadFile" multiple>
                </div>

                <div class="row" id="modifyButtons">
                    <div class="col-xl-1 col-md-6 mb-4">
                        <button class="btn btn-primary btn-block" data-oper='modify'>글 수정</button>
                    </div>
                    <div class="col-xl-1 col-md-6 mb-4">
                        <button class="btn btn-danger btn-block" data-oper='remove'>글 삭제</button>
                    </div>
                    <div class="col-xl-1 col-md-6 mb-4">
                        <button class="btn btn-primary btn-block" data-oper='list'>글 목록</button>
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
        var removeAttachList = $("#removeAttachList");
        var removeUuidList = new Array();

        removeAttachList.on("click","li button",function (e) {
            e.preventDefault();
            var operation = $(this).data("oper");
            var liObj = $(this).closest("li");
            var filename = $(this).data("filename");
            var uuid =  $(this).data("uuid");

            var str = "";

            console.log( $(this).data("filename"));
            console.log( $(this).data("uuid"));
            console.log(operation);

            if(operation === 'remove'){
                removeUuidList.push(uuid);

                str += "<STRIKE>"+filename+"</STRIKE>\n"+
                    "<button class=\"btn btn-danger\" data-oper=\"cancle\" data-uuid='"+ uuid +"' data-filename='"+ filename +"'>삭제 취소</button>\n";
            }
            else{
                var index = removeUuidList.indexOf(uuid);
                console.log(index);
                if(index > -1){
                    removeUuidList.splice(index,1);
                    console.log("splice");
                }

                str += filename+"\n"+
                    "<button class=\"btn btn-danger\" data-oper=\"remove\" data-uuid='"+ uuid +"' data-filename='"+ filename +"'>파일 삭제</button>\n";
            }
            liObj.html(str);
        });


        $('#modifyButtons').on("click","button", function (e) {
            e.preventDefault();

            var operation = $(this).data("oper");

            console.log(operation + "aaa");

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

                console.log(removeUuidList);

                var str = "";

            /*    removeUuidList.forEach(function (value,index) {
                    console.log(value);
                    console.log(index);
                    str += "<input type='hidden' name='removeUuidList[" + index + "]' value = '" + value + "'>";
                });*/

                removeUuidList.forEach(function (value, index) {
                    console.log(value);
                    console.log(index);
                    str += "<input type='hidden' name='removeUuidList[" + index + "]' value = '" + value + "'>";
                });

                formObj.append(str);
            }
            formObj.submit();
        });



    });

</script>

<%@include file="../includes/footer.jsp" %>