$(document).ready(function() {
    $("div.bhoechie-tab-menu>div.list-group>a").click(function(e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
        $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
    });
});



$(document).ready(function(){
	$(".Exhionerw").hide();
	$(".vstonerw").hide();
    $(".vstone").click(function(){
        $(".vstonerw").show();
		$(".Exhionerw").hide();
	$(".Orgnonerw").hide();
    });
    $(".Exhione").click(function(){
        $(".Exhionerw").show();
		$(".vstonerw").hide();
	$(".Orgnonerw").hide();
    });
	
	$(".Orgnone").click(function(){
        $(".Orgnonerw").show();
		$(".Exhionerw").hide();
	$(".vstonerw").hide();
    });
});



$(document).ready(function(){
	$(".BoothTopRdsp").prop('checked', true);
    $(".BoothTopRdsp").click(function(){
        $(".ExhiBitrtoptblsp").hide();
		$(".BooTHtopTblsp").show();
    });
    $(".VisitrTopidsp").click(function(){
        $(".ExhiBitrtoptblsp").show();
		 $(".BooTHtopTblsp").hide();
    });
});  


$(document).ready(function(){
	$(".Exh").prop('checked' ,false);
	$(".Bthcot").prop('checked' ,false);
	$(".Bthdropcon").hide();
	$(".Exhdropcon").hide();
    $(".Exh").click(function(){
       $(".Exhdropcon").show();
	   $(".Bthdropcon").hide();
    });
    $(".Bthcot").click(function(){
        $(".Exhdropcon").hide();
	   $(".Bthdropcon").show();
    });
	 $(".ToTaler").click(function(){
        $(".").show();
    });

}); 

$('.J-demo-29').dateTimePicker();
$('.J-demo-30').dateTimePicker();  
$(".radiobtn").click(function(){
  if ($("input[name=optradio]:checked").val() == "bydate") {
        $(".date_input").attr("disabled", false);
         $(".year_select").attr("disabled", "disabled");
		  $(".month_select").attr("disabled", "disabled");
    }

    if ($("input[name=ynRadio]:checked").val() == "upload") {
        $(".uploadtext").attr("disabled", false);
        $(".Youtubetext").attr("disabled", "disabled");
    }
});
