<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="main">
		<form:form action="withdraw" class="withdraw" id="member_withdraw" modelAttribute="memberVO">
			<form:hidden path="mem_num"/>
			<form:errors element="div" cssClass="error-color"/>	
			<h2>회원 탈퇴</h2>
			<ul>
				<li style="margin-left:90px;">
					<form:label path="mem_ckpasswd">비밀번호</form:label>
					<form:password path="mem_ckpasswd"/>
					<span id="message_passwd"></span>
					<form:errors path="mem_ckpasswd" cssClass="error-color"/>
				</li>
			</ul>
			<div class="align-center">
				<form:button class="member-btn" id="withdrawbtn">회원 탈퇴</form:button>
				<input type="button" value="메인으로" class="member-btn" onclick="location.href='${pageContext.request.contextPath}/concert/list'">
			</div>
	</form:form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.withdraw.js"></script>