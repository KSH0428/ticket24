<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<link rel="stylesheet" href="/css/ksh.css">
<div class="page-main">
	<h2>${ticket.ticket_name}</h2>
	<ul class="detail-info">
	<li>
	<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${ticket.mem_num}" width="40" height="40" class="my-photo">
	</li>
	<li>
		<c:if test="${empty ticket.mem_nickname}">${ticket.mem_id}</c:if>
		<c:if test="${!empty ticket.mem_nickname}">${ticket.mem_nickname}</c:if>
		<br>
			<c:if test="${!empty ticket.ticket_modifydate}">
			최근 수정일 : ${ticket.ticket_modifydate}
			</c:if>
			<c:if test="${empty ticket.ticket_modifydate}">
			작성일 : ${ticket.ticket_regdate}
			</c:if>
			조회 : ${ticket.ticket_hit}
	</li>
	</ul>
			<c:if test="${!empty ticket.ticket_filename1}">
		<ul>
			<li>첨부파일1 : <a href="file?ticket_num=${ticket.ticket_num}&file_num=1">${ticket.ticket_filename1}</a></li>
			<li>첨부파일2 : <a href="file?ticket_num=${ticket.ticket_num}&file_num=2">${ticket.ticket_filename2}</a></li>
			<li>첨부파일3 : <a href="file?ticket_num=${ticket.ticket_num}&file_num=3">${ticket.ticket_filename3}</a></li>
			<li>첨부파일4 : <a href="file?ticket_num=${ticket.ticket_num}&file_num=4">${ticket.ticket_filename4}</a></li>
		</ul>
		</c:if>
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
		</ul>
		<div class="align-right">
		 <c:if test="${!empty user && user.mem_num != ticket.mem_num && ticket.ticket_status!=2}">	
    		<input type="button" value="결제하기" 
    		onclick="location.href='${pageContext.request.contextPath}/ticketPay/write?ticket_num=${ticket.ticket_num}'">
    	</c:if>
    	</div>
		<hr size="1"width="100%">
		<c:if test="${fn:endsWith(ticket.ticket_filename1,'.jpg') ||
				  fn:endsWith(ticket.ticket_filename1,'.JPG') ||					
				  fn:endsWith(ticket.ticket_filename1,'.jpeg') ||
				  fn:endsWith(ticket.ticket_filename1,'.JPEG') ||
				  fn:endsWith(ticket.ticket_filename1,'.gif') ||	
				  fn:endsWith(ticket.ticket_filename1,'.GIF') ||
				  fn:endsWith(ticket.ticket_filename1,'.png') ||
				  fn:endsWith(ticket.ticket_filename1,'.PNG')}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${ticket.ticket_filename1}" class="detail-img">
		</div>
		</c:if>
		<c:if test="${fn:endsWith(ticket.ticket_filename2,'.jpg') ||
				  fn:endsWith(ticket.ticket_filename2,'.JPG') ||					
				  fn:endsWith(ticket.ticket_filename2,'.jpeg') ||
				  fn:endsWith(ticket.ticket_filename2,'.JPEG') ||
				  fn:endsWith(ticket.ticket_filename2,'.gif') ||	
				  fn:endsWith(ticket.ticket_filename2,'.GIF') ||
				  fn:endsWith(ticket.ticket_filename2,'.png') ||
				  fn:endsWith(ticket.ticket_filename2,'.PNG')}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${ticket.ticket_filename2}" class="detail-img">
		</div>
		</c:if>
		<c:if test="${fn:endsWith(ticket.ticket_filename3,'.jpg') ||
				  fn:endsWith(ticket.ticket_filename3,'.JPG') ||					
				  fn:endsWith(ticket.ticket_filename3,'.jpeg') ||
				  fn:endsWith(ticket.ticket_filename3,'.JPEG') ||
				  fn:endsWith(ticket.ticket_filename3,'.gif') ||	
				  fn:endsWith(ticket.ticket_filename3,'.GIF') ||
				  fn:endsWith(ticket.ticket_filename3,'.png') ||
				  fn:endsWith(ticket.ticket_filename3,'.PNG')}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${ticket.ticket_filename3}" class="detail-img">
		</div>
		</c:if>
		<c:if test="${fn:endsWith(ticket.ticket_filename4,'.jpg') ||
				  fn:endsWith(ticket.ticket_filename4,'.JPG') ||					
				  fn:endsWith(ticket.ticket_filename4,'.jpeg') ||
				  fn:endsWith(ticket.ticket_filename4,'.JPEG') ||
				  fn:endsWith(ticket.ticket_filename4,'.gif') ||	
				  fn:endsWith(ticket.ticket_filename4,'.GIF') ||
				  fn:endsWith(ticket.ticket_filename4,'.png') ||
				  fn:endsWith(ticket.ticket_filename4,'.PNG')}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${ticket.ticket_filename4}" class="detail-img">
		</div>
		</c:if>
		<hr size="1"width="100%">
		<div class="detail-content">
			${ticket.ticket_content}
		</div>
		<div class="align-right">
		<c:if test="${!empty user && user.mem_num == ticket.mem_num}">
		<input type="button" value="수정" 
		  onclick="location.href='update?ticket_num=${ticket.ticket_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='delete?ticket_num=${ticket.ticket_num}';
				}
			};
		</script>  
		</c:if>
		<input type="button" value="목록" onclick="location.href='list'">
	</div>
</div>
<!-- 내용 끝 -->
