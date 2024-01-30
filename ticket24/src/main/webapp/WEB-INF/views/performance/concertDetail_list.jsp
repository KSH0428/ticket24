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
<ul>	
	<li><img src="${concert.img_poster}"></li>
	<li>${concert.concert_title}</li>
	<li>${concert.period}</li>
	<li>${concert.concert_hall}</li>
	<li>${concert.monopoly}</li>	
	<li>${concert.grade}</li>
	<li>${concert.viewing_time}</li>
	<li>${concert.casting}</li>
	<li>${concert.c_round_1}</li>
	<c:if test="${concert.c_round_2!='null'}">
	<li>${concert.c_round_2}</li>
	</c:if>
	<c:if test="${concert.image_1!='null'}">
	<li><img src="${concert.image_1}"></li>
	</c:if>
	<c:if test="${concert.image_2!='null'}">
	<li><img src="${concert.image_2}"></li>
	</c:if>
	<c:if test="${concert.image_3!='null'}">
	<li><img src="${concert.image_3}"></li>
	</c:if>
	<c:if test="${concert.image_4!='null'}">
	<li><img src="${concert.image_4}"></li>
	</c:if>
	<c:if test="${concert.image_5!='null'}">
	<li><img src="${concert.image_5}"></li>
	</c:if>
	<c:if test="${concert.image_6!='null'}">
	<li><img src="${concert.image_6}"></li>
	</c:if>
	<c:if test="${concert.image_7!='null'}">
	<li><img src="${concert.image_7}"></li>
	</c:if>
	
	
</ul>
</body>
</html>