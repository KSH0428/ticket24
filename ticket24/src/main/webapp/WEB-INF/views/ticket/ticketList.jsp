<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="align-right">
	<select id="order" name="order">
			<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
			<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
	</select>
	<c:if test="${!empty user}">
			<input type="button" value="글쓰기" onclick="location.href='write'">
			</c:if>
		</div>
	</form>
	<div class = "category">
		<input class="btn" type="button" value="전체" onclick="location.href='list'"> 
		<input class="btn" type="button" value="뮤지컬" onclick="location.href='list?ticket_category=1'">
		<input class="btn" type="button" value="공연" onclick="location.href='list?ticket_category=2'">
		<input class="btn" type="button" value="콘서트" onclick="location.href='list?ticket_category=3'">
		<input class="btn" type="button" value="클래식" onclick="location.href='list?ticket_category=4'"> 
		</div>
		<c:if test="${count == 0}">
				<div class="result-display">표시할 게시물이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
			<table class="striped-table">
				<tr class="align-center">
    			<th>번호</th>
    			<th>카테고리</th>
   				<th>공연명</th>
    			<th>공연장소</th>
    			<th>공연일</th>
    			<th>좌석정보</th>
    			<th>보유여부</th>
    			<th>수량</th>
    			<th>가격</th>
				</tr>
				<c:forEach var="ticket" items="${list}">
					<tr>
						<td class="align-center" >${ticket.ticket_num}</td>
						<td class="align-center"><c:if
									test="${ticket.ticket_category == 1}">뮤지컬</c:if> <c:if
									test="${ticket.ticket_category == 2}">공연</c:if> <c:if
									test="${ticket.ticket_category == 3}">콘서트</c:if> <c:if
									test="${ticket.ticket_category == 4}">클래식</c:if></td>
					<td class="align-center" ><a href="detail?ticket_num=${ticket.ticket_num}">${ticket.ticket_name}</a></td>
					<td class="align-center">${ticket.ticket_place}</td>
					<td class="align-center">${ticket.ticket_date}</td>
					<td class="align-center">${ticket.ticket_seat}</td>
					<td class="align-center"><c:if
							test="${ticket.ticket_status == 1}">보유중</c:if> <c:if
							test="${ticket.ticket_status == 2}">판매 완료</c:if>
					<td class="align-center">${ticket.ticket_quantity}장</td>
					<td class="align-center">${ticket.ticket_price}원</td>
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
				if(${!empty param.ticket_category}){
					location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val()+'&ticket_category=${param.ticket_category}';
				}else{
					location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
				}
			});
		});
		
		</script>
<!-- 내용 끝 -->