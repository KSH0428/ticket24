<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page-main">
	<h2>1:1 문의</h2>
	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>닉네임+ID</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list'">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
			
			</select>
		</div>
		<c:if test="${!empty user}">
		<input type="button" value="문의글 작성" onclick="location.href='write'">
		</c:if>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>카테고리</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="question" items="${list}">
		<c:if test="${question.question_level == 1}">
		<tr>
			<td class="align-center">
				<c:if test="${question.question_category == 1}">주문</c:if>
				<c:if test="${question.question_category == 2}">상품</c:if>
				<c:if test="${question.question_category == 3}">배송</c:if>
				<c:if test="${question.question_category == 4}">기타</c:if>
			</td>
			<td class="align-center">
			<c:if test="${question.question_lock == 2}">
			<img src="${pageContext.request.contextPath}/images/question_lock.png" width="8">
			</c:if>
			<a href="detail?question_num=${question.question_num}">${question.question_title}</a>
			</td>
			<td class="align-center">
				<c:if test="${empty question.mem_nickname}">${question.mem_id}</c:if>
				<c:if test="${!empty question.mem_nickname}">${question.mem_nickname}</c:if>
			</td>
			<td class="align-center">${question.question_regdate}</td>
			<td class="align-center">${question.question_hit}</td>
		</tr>
		</c:if>
		</c:forEach>
	</table>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>