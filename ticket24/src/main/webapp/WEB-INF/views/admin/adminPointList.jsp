<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>포인트 목록</h2>
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
			<td class="align-center"><fmt:formatNumber value="${point.pt_amount}" pattern="#,###" /> 원</td>
			<td class="align-center">${point.pt_content}</td>
			<td class="align-center"><fmt:formatNumber value="${point.total_point}" pattern="#,###" /> 원</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 끝 -->