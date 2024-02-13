<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.profile.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<div class="memberinfo" style="padding-top:100px; margin-bottom:80px;">
		<div class="member-photo">
			<ul>
				<li>
					<img src="${pageContext.request.contextPath}/member/photoView" width="200" height="200" class="my-photo">
				</li>
			</ul>
		</div>
		<div class="member-point">
			<ul>
				<li>
					'${member.mem_name}'님은 <c:if test="${member.mem_auth == 1}">'실버' 등급입니다.</c:if>
										    <c:if test="${member.mem_auth == 2}">'골드' 등급입니다.</c:if>
										    <c:if test="${member.mem_auth == 3}">'플래티넘' 등급입니다.</c:if>
										    <c:if test="${member.mem_auth == 9}">'관리자' 입니다.</c:if>
				</li>
				<li>
					<br>적립금 : <fmt:formatNumber value="${all_point}" pattern="#,###" /> 원
				</li>
			</ul>
		</div>
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="table-main">
		<tr>
			<th class="align-center">적립/사용 일자</th>
			<th class="align-center" width="400">적립/사용</th>
			<th class="align-center">내용</th>
			<th class="align-center">총 적립금</th>
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