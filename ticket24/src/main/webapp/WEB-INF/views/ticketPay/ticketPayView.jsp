<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<link rel="stylesheet" href="/css/ksh.css">
<div class="page-main">
<h2>${ticket.ticket_name}</h2>
		<hr size="1"width="100%">
		<ul>
		<li>공연명 : ${ticket.ticket_name} , 공연장소 : ${ticket.ticket_place } , 공연일 : ${ticket.ticket_date} </li>
		<li>좌석정보 : ${ticket.ticket_seat}</li>
			<c:if test="${! empty ticket.f_ticket_special1}">
				<li> 상품 특이사항 : 
			<c:forEach var="ticket_special1" items="${ticket.f_ticket_special1}" varStatus="status">
				<c:if test="${status.index > 0}">,</c:if>
				<c:if test="${ticket_special1 == 1}">재관람 티켓</c:if> 
				<c:if test="${ticket_special1 == 2}">18세 이상 입장 가능</c:if> 
				<c:if test="${ticket_special1 == 3}">할인티켓 - 학생</c:if> 
				<c:if test="${ticket_special1 == 4}">할인티켓 - 장애인</c:if>
				<c:if test="${ticket_special1 == 5}">할인티켓 - 경로자</c:if>
				<c:if test="${ticket_special1 == 6}">여성명의</c:if>
				<c:if test="${ticket_special1 == 7}">남성명의</c:if>
				<c:if test="${ticket_special1 == 8}">조기입장</c:if>
			</c:forEach>
		</li>
		</c:if>
		<c:if test="${! empty ticket.f_ticket_special2}">
		<li> 좌석 특이사항 : 
			<c:forEach var="ticket_special2" items="${ticket.f_ticket_special2}" varStatus="status">
			    <c:if test="${status.index > 0}">,</c:if>
				<c:if test="${ticket_special2 == 1}">시야 제한석</c:if> 
				<c:if test="${ticket_special2 == 2}">통로석</c:if> 
				<c:if test="${ticket_special2 == 3}">스피커 옆</c:if> 
				<c:if test="${ticket_special2 == 4}">스탠딩 한정</c:if> 
				<c:if test="${ticket_special2 == 5}">가변석</c:if>	
			</c:forEach>										
		</li>
		</c:if>
		<li>수량 : ${ticket.ticket_quantity}장 , 가격 :  <fmt:formatNumber value="${ticket.ticket_price}"/>원 ,
			 총 가격 : <c:set var="totalPrice" value="${ticket.ticket_quantity * ticket.ticket_price}" />
    		<fmt:formatNumber value="${totalPrice}" pattern="###,###"/>원</li>
    	<li>입금 계좌 : ${ticket.ticket_account}</li>
		</ul>
		<hr size="1"width="100%">
		<div class="center">
    <input type="button" value="목록" onclick="location.href='/ticketPay/list'">
    <input type="button" value="홈으로" onclick="location.href='/main/main'">
</div>
		
</div>
<!-- 내용 끝 -->