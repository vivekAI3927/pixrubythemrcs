// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require js/vendor/popper.min
//= require js/vendor/bootstrap.min
//= require js/custom
//= require js/main
//= require js/slick.min
//= require moment
//= require tempusdominus-bootstrap-4
//= require select2
//= require_self
$("[data-toggle=popover]").popover();
    document.addEventListener("DOMContentLoaded", function(event) {
      // Add minus icon for collapse element which is open by default
      $(".collapse.show").each(function(){
        $(this).prev(".card-header").find(".fa").addClass("fa-minus").removeClass("fa-plus");
      });
      
      // Toggle plus minus icon on show hide of collapse element
      $(".collapse").on('show.bs.collapse', function(){
        $(this).prev(".card-header").find(".fa").removeClass("fa-plus").addClass("fa-minus");
      }).on('hide.bs.collapse', function(){
        $(this).prev(".card-header").find(".fa").removeClass("fa-minus").addClass("fa-plus");
      });
  });
$(document).ready(function () {
    $("#answer").on('show.bs.collapse', function () { 
        $('#answer').css('display', 'block')
        $('html, body').animate({scrollTop: $('#answer').offset().top - 122}, 1000);
    });
    $("#answer").on('hide.bs.collapse', function () {  
      $('#answer').css('display', 'none')
    }); 
 })
