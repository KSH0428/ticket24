<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<style>
.menu {
	font-size: 17px !important;
	font-weight:bold !important;
}
.navbar{
	padding-top: 0.6rem !important;
	padding-bottom: 0 !important;
}
</style>
<nav class="py-1 border-bottom text-bg-dark">
	<div class="container d-flex flex-wrap">
		<ul class="nav me-auto">
			<li class="nav-item"><a href="#"
				class="nav-link link-body-emphasis px-2 text-white">공지사항</a></li>
			<li class="nav-item"><a href="${pageContext.request.contextPath}/faq/list"
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
			<c:if test="${!empty user && user.mem_auth > 0 && user.mem_auth != 9}">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/member/myPage"
				class="nav-link link-body-emphasis px-2 text-white">MY페이지</a></li>
			<li class="nav-item">
			<img src="${pageContext.request.contextPath}/member/photoView" 
				                               width="25" height="25" class="my-photo">
			</c:if>
			<c:if test="${!empty user && user.mem_auth == 9}">
			<li class="nav-item"><a href="${pageContext.request.contextPath}/admin/adminPage"
				class="nav-link link-body-emphasis px-2 text-white">관리자</a></li>
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
		</ul>
	</div>
</nav>

<div class="container-fluid">
    <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between py-3 mb-4 border-bottom">
      <div class="col-md-3 mb-2 mb-md-0" style="padding-left:100px">
        <a href="${pageContext.request.contextPath}/main/main" class="navbar-logo">
          <img src="${pageContext.request.contextPath}/images/logo.jpg" width="180px" height="50px">
        </a>
      </div>

      <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 navbar">
        <li><a href="${pageContext.request.contextPath}/concert/list" class="nav-link px-2 menu">콘서트</a></li>
        <li><a href="${pageContext.request.contextPath}/musical/list" class="nav-link px-2 menu">뮤지컬</a></li>
        <li><a href="${pageContext.request.contextPath}/play/list" class="nav-link px-2 menu">연극</a></li>
        <li><a href="${pageContext.request.contextPath}/classic/list" class="nav-link px-2 menu">클래식</a></li>
        <li><a href="${pageContext.request.contextPath}/md/list" class="nav-link px-2 menu">MD샵</a></li>
        <li><a href="${pageContext.request.contextPath}/comm/list" class="nav-link px-2 menu">커뮤니티</a></li>
        <li><a href="${pageContext.request.contextPath}/ticket/list" class="nav-link px-2 menu">티켓양도</a></li>
        <li><a href="${pageContext.request.contextPath}/event/list" class="nav-link px-2 menu">이벤트</a></li>
      </ul>

      <div class="col-md-3 text-end">
      </div>
   	</header>
</div>