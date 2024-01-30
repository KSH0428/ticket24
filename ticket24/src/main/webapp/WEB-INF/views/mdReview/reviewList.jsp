<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 내용 시작 -->
<div class="page-main">
	<h2>리뷰목록</h2>
	<form action="reviewList" id="search_form" method="get">
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>좋아요높은순</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>좋아요낮은순</option>
			</select>
			<c:if test="${!empty user}">
			<input type="button" value="리뷰작성" onclick="location.href='/mdReview/reviewWrite'">
			</c:if>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>좋아요수</th>
		</tr>
		<c:forEach var="mdReview" items="${reviewList}">
		<tr>
			<td class="align-center">${mdReview.md_review_num}</td>
			<td><a href="list?md_review_num=${mdReview.md_review_num}">${mdReview.md_title}</a></td>
			<td class="align-center">
				<c:if test="${empty mdReview.mem_nickname}">${mdReview.mem_id}</c:if>
				<c:if test="${!empty mdReview.mem_nickname}">${md_review.mem_nickname}</c:if>
			</td>
			<td class="align-center">${mdReview.md_regdate}</td>
			<td class="align-center">${mdReview.fav_cnt}</td>
		</tr>	
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//정렬 선택
	$('#order').change(function(){
		location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
	});
	
});	
</script>
<!-- 내용 끝 -->











