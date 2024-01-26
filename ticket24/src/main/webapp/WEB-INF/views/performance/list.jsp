<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콘서트 메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ysw.css">
<!-- css 파일 무시 -->
<script type="text/javascript">
	document.querySelector('link[href="${pageContext.request.contextPath}/css/layout.css"]').remove();
</script>
<!-- swiper js 시작 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<!-- swiper js 끝 -->
</head>
<body>
<!-- swiper 시작 -->
<div class="out-container">
	<div class="in-container">
		<div class="swiper-container">
			<div class="swiper-slider">
			    <div class="swiper-wrapper">
			        <div class="swiper-slide"><img class="image" src="${pageContext.request.contextPath}/images/test1.jpg"></div>
			        <div class="swiper-slide"><img class="image" src="${pageContext.request.contextPath}/images/test2.jpg"></div>
			        <div class="swiper-slide"><img class="image" src="${pageContext.request.contextPath}/images/test3.jpg"></div>
			        <div class="swiper-slide"><img class="image" src="${pageContext.request.contextPath}/images/test4.jpg"></div>
			        <div class="swiper-slide"><img class="image" src="${pageContext.request.contextPath}/images/test5.jpg"></div>
			        <div class="swiper-slide"><img class="image" src="${pageContext.request.contextPath}/images/test6.jpg"></div>
			    </div>
			    <!-- <div class="swiper-pagination"></div> -->
			    <div class="swiper-button-prev"></div>
			    <div class="swiper-button-next"></div>
			</div>
		</div>
	</div>	
</div>
<!-- swiper 끝 -->
<script>
	const swiper = new Swiper('.swiper-slider', {
	    loop: true,                        
	    slidesPerView: 4,				//한 화면에 보여줄 슬라이드 개수
	    centeredSlides : true,
	    spaceBetween: 30,               //페이지 간격
	    autoplay: {                         
	        delay: 2000,  				//다음 슬라이드 넘어가기까지 걸리는 시간
	    },                   
	    pagination: {                       
	    },
	    navigation: {                      
	        nextEl: ".swiper-button-next",
	        prevEl: ".swiper-button-prev",
	    },
	})
</script>
</body>
</html>