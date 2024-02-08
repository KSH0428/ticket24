<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<!-- MyPage 메뉴 시작 -->
<body>
	<div class="side-bar">
		<h3>마이페이지</h3>
		<hr>
		<ul class="side-navbar">
			<li class="main-menu"><a href="${pageContext.request.contextPath}/reserv/list">공연</a>
				<ul class="sub-menu">
					<li><a href="${pageContext.request.contextPath}/reserv/list">찜한 공연</a></li>
					<li><a href="${pageContext.request.contextPath}/reserv/list">공연 예약 내역</a></li>
				</ul>
			</li>
			<li class="main-menu"><a href="${pageContext.request.contextPath}/reserv/reservList">공연장</a></li>
			<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">MD</a>
				<ul class="sub-menu">
					<li><a href="${pageContext.request.contextPath}/reserv/list">주문 내역</a></li>
					<li><a href="${pageContext.request.contextPath}/reserv/list">작성한 문의</a></li>
				</ul>
			</li>
			<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">커뮤니티</a>
				<ul class="sub-menu">
					<li><a href="${pageContext.request.contextPath}/reserv/list">작성한 게시글</a></li>
					<li><a href="${pageContext.request.contextPath}/reserv/list">스크랩한 게시글</a></li>
				</ul>
			</li>
			<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">티켓양도</a>
				<ul class="sub-menu">
					<li><a href="${pageContext.request.contextPath}/reserv/list">찜한 티켓 양도글</a></li>
					<li><a href="${pageContext.request.contextPath}/reserv/list">양도 티켓 결제 내역</a></li>
				</ul>
			</li>
			<li class="main-menu"><a href="${pageContext.request.contextPath}/notice/list">1:1 문의</a></li>
		</ul>
	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage.css.js"></script>
<!-- MyPage 메뉴 끝 -->