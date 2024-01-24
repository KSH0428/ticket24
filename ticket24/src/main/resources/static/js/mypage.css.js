$(document).ready(function(){
	$(".main-menu").mouseover(function(){
		$(this).children(".sub-menu").show(200);
	});
	$(".main-menu").mouseleave(function(){
		$(this).children(".sub-menu").hide(200);
	});
	
});