<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<div class="question-main">
<h2>고객센터</h2>
<!-- 상단 시작 -->
<ul class="nav list">
    <li class="nav-item border" style="width: 33.33%;"><a href="/faq/list" class="nav-link link-body-emphasis px-2">자주 찾는 질문</a></li>
    <li class="nav-item border" style="width: 33.33%;"><a href="/question/list" class="nav-link link-body-emphasis px-2">1:1 문의</a></li>
    <li class="nav-item border" style="width: 33.33%;"><a href="/chat/main" class="nav-link link-body-emphasis px-2">1:1 채팅</a></li>
</ul>
<!-- 상단 끝 -->
	<div class="chat_main">
		<a href="chatDetail">
			<img src="${pageContext.request.contextPath}/images/chat_icon.png" width="250" height="250">
		</a>
	</div>
</div>