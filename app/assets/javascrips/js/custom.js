 /* ==============================================
================== JS ===================
=============================================== */

function Open_facebook_link() { 
  window.open("https://www.facebook.com/PassTheMRCS/", "_blank"); 
}

$(document).ready(function(){
	// Select all links with hashes
$('a[href*="#"]')
  // Remove links that don't actually link to anything
  .not('[href="#"]')
  .not('[href="#0"]')
  .click(function(event) {
    // On-page links
    if (
      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
      && 
      location.hostname == this.hostname
    ) {
      // Figure out element to scroll to
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      // Does a scroll target exist?
      if (target.length) {
        // Only prevent default if animation is actually gonna happen
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 1000, function() {
          // Callback after animation
          // Must change focus!
          var $target = $(target);
          $target.focus();
          if ($target.is(":focus")) { // Checking if the target was focused
            return false;
          } else {
            $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
            $target.focus(); // Set focus again
          };
        });
      }
    }
  });
});
	

	
  
/* ==============================================
Scroll Navigation
=============================================== */	


	
	$(document).ready(function() {
		var s = $("header");
		var pos = s.position();					   
		$(window).scroll(function() {
			var windowpos = $(window).scrollTop();
			if (windowpos >= pos.top & windowpos <= 10) {
				s.removeClass("stick");	
			} else {
				s.addClass("stick");
			}
		});
	});
	
	

	  /*=================================
    Javascript for banner area carousel
    ==================================*/
    // $(".active-banner-slider").owlCarousel({
    //     items:1,
    //     autoplay:false,
    //     autoplayTimeout: 5000,
    //     loop:true,
    //     nav:true,
    //     navText:["<img src='img/banner/prev.png'>","<img src='img/banner/next.png'>"],
    //     dots:false
    // });
	
	
	



/* ==============================================
Wow Animation
=============================================== */


 // wow = new WOW(
 //      {
 //        animateClass: 'animated',
 //        offset:       100
 //      }
 //    );
 //    wow.init();



