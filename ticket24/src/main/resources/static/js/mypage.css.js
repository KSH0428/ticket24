$(document).ready(function(){
        $(".main-menu").mouseover(function(){
            $(this).children(".sub-menu").stop().slideDown(300);
        });

        $(".main-menu").mouseleave(function(e){
            var target = e.relatedTarget || e.toElement;
            if (!$(target).is(".sub-menu, .main-menu *")) {
                $(this).children(".sub-menu").stop().slideUp(300);
            }
        });

        $(".sub-menu").mouseover(function(e){
            var target = e.relatedTarget || e.toElement;
            if (!$(target).is(".main-menu, .main-menu *")) {
                $(this).stop().slideUp(300);
            }
        });
    });