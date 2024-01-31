<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.profile.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>포인트 목록</h2>
	<div class="memberinfo">
		<ul>
			<li>
				<img src="${pageContext.request.contextPath}/member/photoView" width="200" height="200" class="my-photo">
			</li>
		</ul>
		<ul>
			<li>
				'${member.mem_name}'님은 <c:if test="${member.mem_auth == 1}">'실버' 등급입니다.</c:if><br>
									    <c:if test="${member.mem_auth == 2}">'골드' 등급입니다.</c:if><br>
									    <c:if test="${member.mem_auth == 3}">'플래티넘' 등급입니다.</c:if><br>
									    <c:if test="${member.mem_auth == 9}">'관리자' 입니다.</c:if><br>
			</li>
			<li>
				적립금 : <fmt:formatNumber value="${point.pt_sum}" pattern="#,###" /> 원
			</li>
		</ul>
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>적립/사용 일자</th>
			<th width="400">적립/사용</th>
			<th>내용</th>
			<th>총 적립금</th>
		</tr>
		<c:forEach var="point" items="${list}">
		<tr>
			<td class="align-center">${point.pt_reg_date}</td>
			<td class="align-center">${point.pt_amount}</td>
			<td class="align-center">${point.pt_content}</td>
			<td class="align-center">${point.pt_sum}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 끝 -->