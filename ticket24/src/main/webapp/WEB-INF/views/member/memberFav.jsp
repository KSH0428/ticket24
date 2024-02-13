<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>좋아요한 게시글</h2>
		<form action="memberFav" id="search_form" method="get">
	<ul class="search">
			<li>
			<select name="keyfield" id="keyfield">
				<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
				<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>ID+별명</option>
				<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
				<option value="4"<c:if test="${param.keyfield == 4}">selected</c:if>>제목+내용</option>
			</select>
		</li>
		<li>
			<input type="search" name="keyword" id="keyword" value="${param.keyword}">
		</li>
		<li>
			<input type="submit" value="찾기">
			<input type="button" value="목록" onclick="location.href='memberFav'">
		</li>		
	</ul>
			<div class="align-right">
		<select id="order" name="order">
			<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
			<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
			<option value="3" <c:if test="${param.order == 3}">selected</c:if>>좋아요</option>
			<option value="4" <c:if test="${param.order == 4}">selected</c:if>>댓글수</option>
		</select>
			<c:if test="${!empty user}">
			<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/comm/write'">
			</c:if>
		</div>
	</form>
		<div class = "category">
		<input class="btn" type="button" value="전체게시판" onclick="location.href='memberFav'"> 
		<input class="btn" type="button" value="자유게시판" onclick="location.href='memberFav?comm_category=1'"> 
		<input class="btn" type="button" value="뮤지컬" onclick="location.href='memberFav?comm_category=2'">
		<input class="btn" type="button" value="공연" onclick="location.href='memberFav?comm_category=3'">
		<input class="btn" type="button" value="콘서트" onclick="location.href='memberFav?comm_category=4'">
		<input class="btn" type="button" value="클래식" onclick="location.href='memberFav?comm_category=5'"> 
		</div>
			<c:if test="${count == 0}">
				<div class="result-display">표시할 게시물이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
				<table class="striped-table">
					<tr class="align-center" >
						<th>번호</th>
						<th>카테고리</th>
						<th width="400">제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>좋아요수</th>
					</tr>
					<c:forEach var="comm" items="${list}">
						<tr>
							<td class="align-center">${comm.comm_num}</td>
							<td class="align-center"><c:if
									test="${comm.comm_category == 1}">자유게시판</c:if> <c:if
									test="${comm.comm_category == 2}">뮤지컬</c:if> <c:if
									test="${comm.comm_category == 3}">공연</c:if> <c:if
									test="${comm.comm_category == 4}">콘서트</c:if> <c:if
									test="${comm.comm_category == 5}">클래식</c:if></td>
							<td class="align-center" ><a href="${pageContext.request.contextPath}/comm/detail?comm_num=${comm.comm_num}">${comm.comm_title}(${comm.re_cnt})</a></td>
							<td class="align-center"><c:if
									test="${empty comm.mem_nickname}">${comm.mem_id}</c:if> <c:if
									test="${!empty comm.mem_nickname}">${comm.mem_nickname}</c:if>
							</td>
							<td class="align-center">${comm.comm_regdate}</td>
							<td class="align-center">${comm.comm_hit}</td>
							<td class="align-center">${comm.fav_cnt}</td>
						</tr>
					</c:forEach>
				</table>
				<div class="align-center">${page}</div>
			</c:if>
		</div>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
		<script type="text/javascript">
$(function(){
	//검색 유효성 체크
	$('#search_form').submit(function(){
		if($('#keyword').val().trim()==''){
		alert('검색어를 입력하세요');
		$('#keyword').val('').focus();
		return false;
	}
	});//end of submit
	
	//정렬선택
	$('#order').change(function(){
		if(${!empty param.comm_category}){
			location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val()+'&comm_category=${param.comm_category}';
		}else{
			location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
		}
	});
});
</script>
		<!-- 내용 끝 -->