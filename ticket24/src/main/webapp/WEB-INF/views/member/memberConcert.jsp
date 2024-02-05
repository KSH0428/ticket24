<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<div class="page-main">
	<div>
		<h2>찜한 공연</h2>
		<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>공연 제목</th>
				<th width="400">공연 일자</th>
				<th>예약 오픈 일자</th>
				<th>주연</th>
			</tr>
			<c:forEach var="board" items="${list}">
			<tr>
				<td class="align-center">${board.board_num}</td>
				<td><a href="detail?board_num=${board.board_num}">${board.title}(${board.re_cnt})</a></td>
				<td class="align-center">${board.hit}</td>
				<td class="align-center">${board.fav_cnt}</td>
			</tr>	
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
	<div>
		<h2>공연 예약 내역</h2>
		<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>예약 번호</th>
				<th width="400">공연 제목</th>
				<th>공연 일자</th>
				<th>예약 일자</th>
			</tr>
			<c:forEach var="board" items="${list}">
			<tr>
				<td class="align-center">${board.board_num}</td>
				<td><a href="detail?board_num=${board.board_num}">${board.title}(${board.re_cnt})</a></td>
				<td class="align-center">${board.hit}</td>
				<td class="align-center">${board.fav_cnt}</td>
			</tr>	
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>











