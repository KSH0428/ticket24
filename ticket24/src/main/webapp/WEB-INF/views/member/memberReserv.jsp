<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<!-- 시작 -->
<div>
	<h5 style="margin-bottom:50px;">공연장 대관 예약 목록</h5>
	<c:if test="${empty list}">
		예약목록이 없습니다.
	</c:if>
	<c:if test="${!empty list}">
		<table class="table-main" style="width:90%;">
			<tr>
				<th>신청일</th>
				<th>신청인</th>
				<th>예약일</th>
				<th>예약현황</th>
			</tr>
			<c:forEach var="list" items="${list}">
			<tr>
				<td>${list.reservation_regdate}</td>
				<td>
				<a href="${pageContext.request.contextPath}/reserv/reservDetail?reservation_num=${list.reservation_num}">${list.reservation_name}</a></td>
				<td>
				<c:if test="${fn:length(list.reservation_date)==1}"><fmt:formatDate value="${list.reservation_date[0]}" pattern="yyyy-MM-dd"/></c:if>
				<c:if test="${fn:length(list.reservation_date)>1}">
				<fmt:formatDate value="${list.reservation_date[0]}" pattern="yyyy-MM-dd"/>외 ${fn:length(list.reservation_date)-1}건
				</c:if>
				</td>
				<td>
				<c:if test="${list.reservation_status==0}">신청완료</c:if>
				<c:if test="${list.reservation_status==1}">심사대기</c:if>
				<c:if test="${list.reservation_status==2}">결제대기</c:if>
				<c:if test="${list.reservation_status==3}">결제완료</c:if>
				<c:if test="${list.reservation_status==4}">신청취소</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script>
$('#reservList').addClass('active');
</script>
<!-- 끝 -->
    