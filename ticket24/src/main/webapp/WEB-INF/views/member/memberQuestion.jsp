<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<div class="question-main">
<h2 class="h2">문의한 1:1 목록</h2>
	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield" class="form-select">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>닉네임+ID</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" class="form-control fc" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="btn btn-secondary sbtn">
				<input type="button" value="목록" onclick="location.href='list'" class="btn btn-secondary sbtn">
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
		<input type="button" value="문의글 작성" onclick="location.href='write'" class="btn btn-warning float-end" style="width:95px;font-size:11pt;padding:0;">
		</c:if>
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="table">
		<tr class="table-secondary">
			<th width="70">번호</th>
			<th width="120">카테고리</th>
			<th>제목</th>
			<th width="120">작성자</th>
			<th width="120">작성일</th>
			<th width="75">조회수</th>
		</tr>
		<c:forEach var="question" items="${list}" varStatus="loop">
		<c:if test="${question.question_level == 1}">
		<tr>
			<td>${loop.index + 1}</td>
			<td class="align-center">
				<c:if test="${question.question_category == 1}">상품</c:if>
				<c:if test="${question.question_category == 2}">주문</c:if>
				<c:if test="${question.question_category == 3}">배송</c:if>
				<c:if test="${question.question_category == 4}">기타</c:if>
			</td>
			<td style="text-align:left;padding-left:100px;">
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
