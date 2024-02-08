<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- MyPage 메뉴 시작 -->
<div class="side-bar">
	<h1>관리자 페이지</h1>
	<hr>
	<ul class="side-navbar">
		<li class="main-menu"><a href="${pageContext.request.contextPath}/reserv/list">공연 관리</a>
			<ul class="sub-menu">
				<li><a href="${pageContext.request.contextPath}/reserv/list">찜한 공연</a></li>
				<li><a href="${pageContext.request.contextPath}/reserv/list">공연 예약 내역</a></li>
			</ul>
		</li>
		<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">공연장 대관 관리</a></li>
		<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">MD 관리</a></li>
		<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">포인트 관리</a></li>
	</ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage.css.js"></script>
<!-- MyPage 메뉴 끝 -->