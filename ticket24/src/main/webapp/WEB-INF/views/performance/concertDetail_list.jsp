<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콘서트 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ysw.css">
</head>
<body>
<div class="common-container">
	<div class="detail-container">
		<div class="img-container">
			<img width= 100%; height=100% src="${concert.img_poster}">
		</div>
		<div class="info-container">
			<c:if test="${concert.monopoly eq '단독'}">
			<div style="margin-bottom: 17px;">
				<span class="concert-monopoly">${concert.monopoly}</span>
			</div>
			</c:if>
			<div class="concert-title">
				<h1 class="concert-title-content">${concert.concert_title}</h1>
			</div>
			<div class="concert-info">
				<ul class="concert-info-l1" style="list-style: none">
					<li class="info">
						<span>장소</span>
						<div>${concert.concert_hall}</div>
					</li>
					<li class="info">
						<span>관람시간</span>
						<div>${concert.viewing_time}</div>
					</li>
					<li class="info">
						<span>공연기간</span>
						<div>${concert.period}</div>
					</li>
					<li class="info">
						<span>관람등급</span>
						<div>${concert.grade}</div>
					</li>
					<li class="info2">
						<span>출연진</span>
						<div>${concert.casting}</div>
					</li>
					<li class="info2">
						<span>공연 회차</span>
						<div>${concert.c_round_1}</div>
			
					</li>
					<c:if test="${concert.c_round_2!='null'}">
					<li class="info2">
						<span></span>
						<div>${concert.c_round_2}</div>
					</li>
					</c:if>
				</ul>
			</div>
			<div class="concert-price-info">
				<div>가격 미정</div>
			</div>
		</div>
	</div>
	
	<!-- 공연 예약 부분 -->
	
	<!-- 공연 상세 이미지 -->
	<div class="concert-detail-img">
		<c:if test="${concert.image_1!='null'}">
		<div><img src="${concert.image_1}"></div>
		</c:if>
		<c:if test="${concert.image_2!='null'}">
		<div><img src="${concert.image_2}"></div>
		</c:if>
		<c:if test="${concert.image_3!='null'}">
		<div><img src="${concert.image_3}"></div>
		</c:if>
		<c:if test="${concert.image_4!='null'}">
		<div><img src="${concert.image_4}"></div>
		</c:if>
		<c:if test="${concert.image_5!='null'}">
		<div><img src="${concert.image_5}"></div>
		</c:if>
		<c:if test="${concert.image_6!='null'}">
		<div><img src="${concert.image_6}"></div>
		</c:if>
		<c:if test="${concert.image_7!='null'}">
		<div><img src="${concert.image_7}"></div>
		</c:if>
	</div>
</div>


</body>
</html>