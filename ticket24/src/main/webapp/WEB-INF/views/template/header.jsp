<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 상단 시작 -->
<div class="align-right">
	<a href="${pageContext.request.contextPath}/reserv/list">공연장대관</a>
	<a href="${pageContext.request.contextPath}/notice/list">공지사항</a>
	<c:if test="${!empty user}">
	<a href="${pageContext.request.contextPath}/member/myPage">MY페이지</a>
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
	<a href="${pageContext.request.contextPath}/zzim/list">장바구니/찜</a>
	<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
	</c:if>
	
	<c:if test="${empty user}">
	<a href="${pageContext.request.contextPath}/member/registerUser">회원가입</a>
	<a href="${pageContext.request.contextPath}/member/login">로그인</a>
	</c:if>
	
	<c:if test="${!empty user && user.mem_auth == 9}">
	<a href="${pageContext.request.contextPath}/main/admin">관리자</a>
	</c:if>
	<a href="${pageContext.request.contextPath}/question/list">고객센터</a>
</div>
<div class="align-center">
	<a href="${pageContext.request.contextPath}/concert/list">콘서트</a>
	<a href="${pageContext.request.contextPath}/musical/list">뮤지컬</a>
	<a href="${pageContext.request.contextPath}/play/list">연극</a>
	<a href="${pageContext.request.contextPath}/classic/list">클래식</a>
	<a href="${pageContext.request.contextPath}/md/list">MD샵</a>
	<a href="${pageContext.request.contextPath}/ranking/list">랭킹</a>
	<a href="${pageContext.request.contextPath}/event/list">이벤트</a>
	<a href="${pageContext.request.contextPath}/comm/list">커뮤니티</a>
</div>
<!-- 상단 끝 -->


