<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="page-main">
		<h1 class="align-center">비밀번호 변경</h1>
		<form:form action="passwdUpdate" id="member_UpdatePasswd" modelAttribute="memberVO">
			<form:hidden path="mem_num"/>
			<form:errors element="div" cssClass="error-color"/>	
			<ul>
				<li>
					<form:label path="mem_passwd">현재 비밀번호</form:label>
					<form:password path="mem_passwd"/>
				</li>
				<li>
					<form:label path="mem_newpasswd">변경할 비밀번호</form:label>
					<form:password path="mem_newpasswd"/>
				</li>
				<li>
					<form:label path="mem_confirmpasswd">변경할 비밀번호 확인</form:label>
					<form:password path="mem_confirmpasswd"/>
				</li>
			</ul>
			<div class="align-center">
				<form:button class="default-btn" id="passwdupdatebtn">비밀번호 변경</form:button>
				<input type="button" value="메인으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
			</div>
	</form:form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.withdraw.js"></script>