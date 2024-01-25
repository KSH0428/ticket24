<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<nav class="py-2 border-bottom text-bg-dark">
	<div class="container d-flex flex-wrap">
		<ul class="nav me-auto">
			<li class="nav-item"><a href="#"
				class="nav-link link-body-emphasis px-2 text-white">공지사항</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/question/list"
				class="nav-link link-body-emphasis px-2 text-white">고객센터</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/reserv/list"
				class="nav-link link-body-emphasis px-2 text-white">공연장 대관</a></li>
		</ul>
		<ul class="nav">
			<c:if test="${empty user}">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/member/login"
				class="nav-link link-body-emphasis px-2 text-white">로그인</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/member/register"
				class="nav-link link-body-emphasis px-2 text-white">회원가입</a></li>
			</c:if>
			<c:if test="${!empty user}">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/member/myPage"
				class="nav-link link-body-emphasis px-2 text-white">MY페이지</a></li>
			<li class="nav-item">
			<img src="${pageContext.request.contextPath}/member/photoView" 
				                               width="25" height="25" class="my-photo">
			</c:if>
			<c:if test="${!empty user && !empty user.mem_nickname}">
			[<span class="user_name">${user.mem_nickname}</span>]
			</c:if>
			<c:if test="${!empty user && empty user.mem_nickname}">
			[<span class="user_name">${user.mem_id}</span>]
			</c:if>
			<c:if test="${!empty user}">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/zzim/list"
				class="nav-link link-body-emphasis px-2 text-white">장바구니/찜</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/member/logout"
				class="nav-link link-body-emphasis px-2 text-white">로그아웃</a></li>
			</c:if>
			<c:if test="${!empty user && user.mem_auth == 9}">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/main/admin"
				class="nav-link link-body-emphasis px-2 text-white">관리자</a></li>
			</c:if>
		</ul>
	</div>
</nav>
<div class="container">
	<header class="d-flex justify-content-center py-3">
		<span class="fs-4" style="text-align:left;"><a href="${pageContext.request.contextPath}/main/main">티켓24</a></span>
		<ul class="nav nav-pills">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/concert/list" class="nav-link">콘서트</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/musical/list" class="nav-link">뮤지컬</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/play/list" class="nav-link">연극</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/classic/list" class="nav-link">클래식</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/md/list" class="nav-link">MD샵</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/ranking/list" class="nav-link">랭킹</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/comm/list" class="nav-link">커뮤니티</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/ticket/list" class="nav-link">티켓양도</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/event/list" class="nav-link">이벤트</a></li>
<!-- 검색창	<li><input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"></li>
			<li><button class="btn btn-outline-success" type="submit">Search</button></li> -->
		</ul>
	</header>
</div>
<hr size="1" width="100%">

