<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<a href="${pageContext.request.contextPath}/question/list">1:1문의</a>
<a href="#">1:1채팅</a>
<a href="${pageContext.request.contextPath}/faq/list">자주 찾는 질문</a>
<div class="page-main">
	<c:if test="${user.mem_auth == 9}">
	<input type="button" value="질문 등록" onclick="location.href='write'">
	</c:if>
	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list'">
			</li>
		</ul>
	</form>
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th>카테고리</th>
			<th>질문</th>
			<th></th>
		</tr>
		<c:forEach var="faq" items="${list}">
		<tr>
			<td></td>
			<td class="align-center">
				<c:if test="${faq.faq_category == 1}">티켓예매</c:if>
				<c:if test="${faq.faq_category == 2}">취소/환불</c:if>
				<c:if test="${faq.faq_category == 3}">기타</c:if>
			</td>
			<td style="text-align:center;">${faq.faq_title}</td>
			<c:if test="${user.mem_auth != 9}">
			<td></td>
			</c:if>
			<c:if test="${user.mem_auth == 9}">
			<td>
				<input type="button" value="수정" onclick="location.href='update?faq_num=${faq.faq_num}'">
				<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
						if(choice){
							location.href='delete?faq_num=${faq.faq_num}';
						}
					};
				</script>
			</td>
			</c:if>
		</tr>
		</c:forEach>
	</table>
</div>