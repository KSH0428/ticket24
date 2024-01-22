<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 내용 시작 -->
<div class="page-main">
	<h2>md 목록</h2>
	<button onclick="location.href='insertMd'">상품 등록</button>
	<!-- 상품개수 : <span id="totalCount">${md.tatalCount}</span> -->
	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword"
				                                  value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list'">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>등록순</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>높은가격순</option>
				<option value="4" <c:if test="${param.order == 4}">selected</c:if>>낮은가격순</option>
			</select>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table>
		<tr>
			<th>상품번호</th>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>가격</th>
		</tr>
		<!-- 
		<c:forEach var="row" items="${list}">
		<tr>
			<td class="align-center">${board.board_num}</td>
			<td><a href="detail?board_num=${board.board_num}">${board.title}(${board.re_cnt})</a></td>
			<td class="align-center">
				<c:if test="${empty board.nick_name}">${board.id}</c:if>
				<c:if test="${!empty board.nick_name}">${board.nick_name}</c:if>
			</td>
			<td class="align-center">${board.reg_date}</td>
			<td class="align-center">${board.hit}</td>
			<td class="align-center">${board.fav_cnt}</td>
		</tr>	
		</c:forEach>
		 -->
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//검색 유효성 체크
	$('#search_form').submit(function(){
		if($('#keyword').val().trim()==''){
			alert('검색어를 입력하세요!');
			$('#keyword').val('').focus();
			return false;
		}
	});//end of submit
	
	//정렬 선택
	$('#order').change(function(){
		location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
	});
	
});	
</script>
<!-- 내용 끝 -->











