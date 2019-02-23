console.log("ReReply Module.....");


var reReplyService = (function() {

    function getList(parentRno, callback, error) {

        $.getJSON("/rereplies/list/" + parentRno + ".json",
            function(data) {
                if (callback) {
                    callback(data);
                }
            }).fail(function(xhr, status, err) {
            if (error) {
                error();
            }
        });
    }

    function add(rereply, callback, error) {

        console.log("add reply..........");

        $.ajax({
            type : 'post',
            url : '/rereplies/new',
            data : JSON.stringify(rereply),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        })
    }

    return {
        getList : getList,
        add : add
    };
})();