<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<body>
	<div class="main">
		<div class="login">
			<h2>로그인</h2>
			<form:form id="member_login" action="login" modelAttribute="memberVO">
			<form:errors element="div" cssClass="error-color"/>
			<ul>
				<li class="floating-label">
					<form:label path="mem_id" id="login_id">아이디</form:label>
					<form:input path="mem_id" placeholder="아이디" cssClass="form-input" autocomplete="off"/>
					<form:errors path="mem_id" element="div" cssClass="error-color"/>
				</li>
				<li class="floating-label">
					<form:label path="mem_passwd">비밀번호</form:label>
					<form:password path="mem_passwd" placeholder="비밀번호" cssClass="form-input"/>
					<form:errors path="mem_passwd" element="div" cssClass="error-color"/>
				</li>
				<li>
					<label for="mem_auto"><input type="checkbox" name="mem_auto" id="mem_auto"> 로그인상태유지</label>
				</li>
			</ul>
			<div>
				<form:button class="login-btn">로그인</form:button>
			</div>
			</form:form>
			<div class="button-container">
				<input type="button" value="아이디 찾기" onclick="location.href='findIdCheck'">
				<input type="button" value="비밀번호 찾기" onclick="location.href='findPwCheck'">
				<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main'">
			</div>
		</div>
	</div>
</body>