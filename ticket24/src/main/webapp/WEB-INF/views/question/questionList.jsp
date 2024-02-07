<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<div class="question-main">
<h2 class="h2">고객센터</h2>
<!-- 상단 시작 -->
<ul class="nav list">
    <li class="nav-item border" style="width: 33.33%;"><a href="/faq/list" class="nav-link link-body-emphasis px-2">자주 찾는 질문</a></li>
    <li class="nav-item border" style="width: 33.33%; background-color:#f2f2f2;"><a href="/question/list" class="nav-link link-body-emphasis px-2">1:1 문의</a></li>
    <li class="nav-item border" style="width: 33.33%;"><a href="/chat/main" class="nav-link link-body-emphasis px-2">1:1 채팅</a></li>
</ul>
<!-- 상단 끝 -->
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
	</form>
	<div class="category-main">
		<ul class="category">
			<li class="total"><a href="list">전체</a></li>
			<li><a href="list?question_category=1">상품</a></li>
			<li><a href="list?question_category=2">주문</a></li>
			<li><a href="list?question_category=3">배송</a></li>
			<li><a href="list?question_category=4">기타</a></li>
		</ul>
		<c:if test="${!empty user}">
		<input type="button" value="문의글 작성" onclick="location.href='write'" class="btn btn-warning float-end">
		</c:if>
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="table">
		<tr class="table-secondary">
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
				<c:if test="${question.question_category == 1}">상품</c:if>
				<c:if test="${question.question_category == 2}">주문</c:if>
				<c:if test="${question.question_category == 3}">배송</c:if>
				<c:if test="${question.question_category == 4}">기타</c:if>
			</td>
			<td class="align-center">
            	<c:if test="${question.question_lock == 2 && user.mem_auth != 9}">
                	<a href="checkPassword?question_num=${question.question_num}">
                	<span><img src= "${pageContext.request.contextPath}/images/question_lock.png" width="14" height="17"></span>
                	${question.question_title}
                	<br>
                	<c:if test="${question.question_status == 1}">
                	<span>>> [답변완료]</span>
                	</c:if>
                	</a>
                </c:if>
                <c:if test="${question.question_lock == 2 && user.mem_auth == 9}">
                	<a href="detail?question_num=${question.question_num}">
                	<span><img src= "${pageContext.request.contextPath}/images/question_lock.png" width="14" height="17"></span>
                	${question.question_title}
                	<br>
                	<c:if test="${question.question_status == 1}">
                	<span>>> [답변완료]</span>
                	</c:if>
                	</a>
                </c:if>
                <c:if test="${question.question_lock == 1}">
                    <a href="detail?question_num=${question.question_num}">${question.question_title}
                    <br>
                	<c:if test="${question.question_status == 1}">
                	<span>>> [답변완료]</span>
                	</c:if>
                	</a>
                </c:if>
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
<div style="text-align:center;">
	${page}
</div>
