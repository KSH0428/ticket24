<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>티켓양도 목록</h2>
	<form action="list" id="search_form" method="get">
	<ul class="search">
	<li>
		<select name="keyfield" id="keyfield">
				<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>공연명</option>
				<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
				<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>공연명+내용</option>
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
			<c:if test="${count == 0}">
				<div class="result-display">표시할 게시물이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
			<table class="striped-table">
				<tr>
					<th>번호</th>
					<th>카테고리</th>
					<th>공연명</th>
				</tr>
				<c:forEach var="ticket" items="${list}">
					<td class="align-center">${ticket.ticket_num}</td>
					<td class="align-center"><c:if
						test="${ticket.ticket_category == 1}">뮤지컬</c:if> <c:if
						test="${ticket.ticket_category == 2}">공연</c:if> <c:if
						test="${ticket.ticket_category == 3}">콘서트</c:if> <c:if
						test="${ticket.ticket_category == 4}">클래식</c:if></td>
				<td><a href="detail?ticket_num=${ticketPay.ticket_num}">${ticket.ticket_name}</a></td>					
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
				if(${!empty param.ticket_category}){
					location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val();
				}else{
					location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword');
				}
			});
		});
		
		</script>
<!-- 내용 끝 -->