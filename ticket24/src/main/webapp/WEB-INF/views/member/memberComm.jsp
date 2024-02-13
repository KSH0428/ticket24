<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 작성한 게시글 -->
<div class="page-main">	
	<div style="display: inline-block; text-align: right;">
	    <h2 style="display: inline;">작성한 게시글</h2>
	    <input type="button" value="더보기" onclick="location.href='${pageContext.request.contextPath}/member/memberWrite'">
	</div>
	<c:if test="${!empty list_write}">
		<table class="striped-table">
			<tr class="align-center" >
				<th>번호</th>
				<th>카테고리</th>
				<th width="400">제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="comm_w" items="${list_write}">
				<tr>
					<td class="align-center">${comm_w.comm_num}</td>
					<td class="align-center"><c:if
							test="${comm_w.comm_category == 1}">자유게시판</c:if> <c:if
							test="${comm_w.comm_category == 2}">뮤지컬</c:if> <c:if
							test="${comm_w.comm_category == 3}">공연</c:if> <c:if
							test="${comm_w.comm_category == 4}">콘서트</c:if> <c:if
							test="${comm_w.comm_category == 5}">클래식</c:if></td>
					<td class="align-center" ><a href="${pageContext.request.contextPath}/comm/detail?comm_num=${comm_w.comm_num}">${comm_w.comm_title}(${comm_w.re_cnt})</a></td>
					<td class="align-center"><c:if
							test="${empty comm_w.mem_nickname}">${comm_w.mem_id}</c:if> <c:if
							test="${!empty comm_w.mem_nickname}">${comm_w.mem_nickname}</c:if>
					</td>
					<td class="align-center">${comm_w.comm_regdate}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</div>
<!-- 좋아요한 게시글 -->
<div style="display: inline-block; text-align: right;">
    <h2 style="display: inline;">좋아요한 게시글</h2>
    <input type="button" value="더보기" onclick="location.href='${pageContext.request.contextPath}/member/memberFav'">
</div>
	<c:if test="${empty list_fav}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${!empty list_fav}">
		<table class="striped-table">
			<tr class="align-center" >
				<th>번호</th>
				<th>카테고리</th>
				<th width="400">제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="comm_f" items="${list_fav}">
				<tr>
					<td class="align-center">${comm_f.comm_num}</td>
					<td class="align-center"><c:if
							test="${comm_f.comm_category == 1}">자유게시판</c:if> <c:if
							test="${comm_f.comm_category == 2}">뮤지컬</c:if> <c:if
							test="${comm_f.comm_category == 3}">공연</c:if> <c:if
							test="${comm_f.comm_category == 4}">콘서트</c:if> <c:if
							test="${comm_f.comm_category == 5}">클래식</c:if></td>
					<td class="align-center" ><a href="${pageContext.request.contextPath}/comm/detail?comm_num=${comm_f.comm_num}">${comm_f.comm_title}(${comm_f.re_cnt})</a></td>
					<td class="align-center"><c:if
							test="${empty comm_f.mem_nickname}">${comm_f.mem_id}</c:if> <c:if
							test="${!empty comm_f.mem_nickname}">${comm_f.mem_nickname}</c:if>
					</td>
					<td class="align-center">${comm_f.comm_regdate}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</div>