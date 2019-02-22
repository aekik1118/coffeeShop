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

    return {
        getList : getList
    };
})();