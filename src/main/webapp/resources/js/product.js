console.log("-- Product Module --");
var productService = (function () {

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

   return {
       register : register
   };
})();