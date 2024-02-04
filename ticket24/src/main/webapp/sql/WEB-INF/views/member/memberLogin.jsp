<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"charset="utf-8"></script>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>회원로그인</h2>
	<form:form id="member_login" action="login" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li class="floating-label">
				<form:input path="mem_id" placeholder="아이디" cssClass="form-input" autocomplete="off"/>
				<form:label path="mem_id">아이디</form:label>
				<form:errors path="mem_id" element="div" cssClass="error-color"/>
			</li>
			<li class="floating-label">
				<form:password path="mem_passwd" placeholder="비밀번호" cssClass="form-input"/>
				<form:label path="mem_passwd">비밀번호</form:label>
				<form:errors path="mem_passwd" element="div" cssClass="error-color"/>
			</li>
			<li>
				<label for="auto"><input type="checkbox" name="auto" id="auto">로그인상태유지</label>
			</li>
		</ul>
		<div>
			<form:button class="login-btn">로그인</form:button>
		</div>
	</form:form>
	<p class="align-center">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main'">
	</p>
</div>
<!-- 내용 끝 -->