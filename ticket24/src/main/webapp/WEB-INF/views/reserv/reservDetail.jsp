<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib	prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- detail 시작 -->
<div>
	<h2>예약상세</h2>
	<hr size="1" width="100%">
	<ul class="detail_ul">
		<li>이름 (단체명) : ${detail.reservation_name}</li>
		<li>연락처 : ${detail.reservation_phone}</li>
		<li>이메일 : ${detail.reservation_email}</li>
		<li>신청서 : <p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=1">${fn:substringAfter(detail.reservation_form1, '_')}</a></p>
				<c:if test="${!empty detail.reservation_form2}"><p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=2">${fn:substringAfter(detail.reservation_form2, '_')}</a></p></c:if>
				<c:if test="${!empty detail.reservation_form3}"><p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=3">${fn:substringAfter(detail.reservation_form3, '_')}</a></p></c:if>
		</li>
		<li>예약일 : ${detail.reservation_date}</li>
		<li>결제금액 : "금액을 입력해주세요"원</li>
		<li>진행 현황 : 
		<c:if test="${detail.reservation_status==0}">신청완료</c:if>
		<c:if test="${detail.reservation_status==1}">심사대기</c:if>
		<c:if test="${detail.reservation_status==2}">결제대기</c:if>
		<c:if test="${detail.reservation_status==3}">결제완료</c:if>
		<c:if test="${detail.reservation_status==4}">신청취소</c:if>
		</li>
	</ul>
	<div class="align-right">
		<button class="btn btn-primary">신청취소</button> 
		<button class="btn btn-primary">목록</button> 
	</div>
</div>
<script>
$('#reservList').addClass('active');
</script>
<!-- detail 끝 -->
   