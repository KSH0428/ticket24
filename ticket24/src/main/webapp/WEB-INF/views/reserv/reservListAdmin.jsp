<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<h2>[관리자]예약목록</h2>
	<hr size="1" width="100%">
	<c:if test="${empty list}">
		예약목록이 없습니다.
	</c:if>
	<c:if test="${!empty list}">
		<table class="striped-table">
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
				<a href="reservDetailAdmin?reservation_num=${list.reservation_num}">${list.reservation_name}</a></td>
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


<script type="text/javascript">
$('#reservListAdmin').addClass('active');
</script>
    