<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<div class="question-main">
<h2 class="h2">고객센터</h2>
<!-- 상단 시작 -->
<ul class="nav list">
    <li class="nav-item border" style="width: 33.33%;"><a href="/faq/list" class="nav-link link-body-emphasis px-2">자주 찾는 질문</a></li>
    <li class="nav-item border" style="width: 33.33%;"><a href="/question/list" class="nav-link link-body-emphasis px-2">1:1 문의</a></li>
    <li class="nav-item border" style="width: 33.33%; background-color:#f2f2f2;"><a href="/chat/main" class="nav-link link-body-emphasis px-2">1:1 채팅</a></li>
</ul>
<!-- 상단 끝 -->
	<c:if test="${user.mem_auth != 9}">
	<div class="chat_main">
		<a href="chatDetail">
			<img src="${pageContext.request.contextPath}/images/chat_icon.png" width="300" height="300">
		</a>
	</div>
	</c:if>
	<c:if test="${user.mem_auth == 9}">
		<c:if test="${count == 0}">
		<div class="result-display">표시할 채팅방이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="striped-table">
			<c:forEach var="chat" items="${list}">
			<tr>
				<td style="text-align:left;">
					<a href="chatDetail?chatroom_num=${chat.chatroom_num}">
						<b>${chat.mem_id}</b>
						<span>${fn:substring(chat.chatMessageVO.message,0,45)}</span>
					</a>
					<b>${chat.read_count}</b>
				</td>
				<td>
				</td>
			</tr>
			</c:forEach>
		</table>
		</c:if>
	</c:if>
</div>