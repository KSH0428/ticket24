<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- MyPage 메뉴 시작 -->
<div class="side-bar">
	<ul>
		<li>
			<input type="button" class="menu-btn" value="비밀번호변경"
			   onclick="location.href='${pageContext.request.contextPath}/member/changePassword'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="채팅"
			   onclick="location.href='${pageContext.request.contextPath}/talk/talkList'">
		</li>
		<li>
			<input type="button" class="menu-btn" value="회원탈퇴"
			   onclick="location.href='${pageContext.request.contextPath}/member/delete'">
		</li>
	</ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.profile.js"></script>
<!-- MyPage 메뉴 끝 -->







