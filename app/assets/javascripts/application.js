//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
$( document ).ready(function() {
  $(function(){
      $(window).scroll(function(e){
        if ($(this).scrollTop() > 0) {
          $(".navbar-wagon").css({
            "background": "rgba(0, 0, 0, 0.8)",
            "box-shadow": "0 0 0px transparent"
          });
        }
        else {
          $(".navbar-wagon").css({
            "background": "transparent",
             "box-shadow": "0 0 0px transparent"
          });
        }
      });
    })
});


