console.log("-- Product Module --");
var productService = (function () {

    function get(productid, callback, error) {
        $.get("/product/" + productid + ".json", function (result) {
            if(callback) callback(result);
        }).fail(function (xhr, status, er) {
            if(error) error(er);
        });
    }
    
   function register(product, callback, error) {
       console.log("product register..");

       $.ajax({
           type : 'post',
           url : '/product/register',
           data : JSON.stringify(product),
           contentType : "application/json; charset = UTF-8",
           success : function (result, status, xhr) {
               if(callback) callback(result);
           },
           error : function (xhr, status, er) {
               if(error) error(er);
           }
       });
   }
   
   function update(product, callback, error) {
       console.log("product update..");
       
       $.ajax({
           type : 'put',
           url : '/product/' + product.productId,
           data : JSON.stringify(product),
           contentType: "application/json; charset = UTF-8",
           success : function (result, status, xhr) {
               if(callback) callback(result);
            },
           error : function (xhr, status, er) {
               if(error) error(er)
           }
        });
   }

   function remove(productid, callback, error) {
       console.log("product remove : " + productid);

       $.ajax({
           type : 'delete',
           url : '/product/' + productid,
           data : JSON.stringify(productid),
           success : function (result, status, xhr) {
               if(callback) callback(result);
           },
           error : function (xhr, status, er) {
               if(error) error(er);
           }
       });
   }

   return {
       get : get,
       register : register,
       update : update,
       remove : remove
   };
})();