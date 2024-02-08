<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="main">
	<form:form class="findPwCheck" id="findPwCheck" action="findPwCheck" modelAttribute="memberVO">
	<h2>비밀번호 찾기</h2>
		<p>회원가입시 입력한 이메일로 임시 비밀번호를 보내드립니다.<p>	
		<form:errors element="div" cssClass="error-color" style="text-align:center"/>
		<ul>
			<li>
				<form:label path="mem_id">아이디</form:label>
				<form:input path="mem_id"/>
				<form:errors path="mem_id" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_name">이름</form:label>
				<form:input path="mem_name"/>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_email">이메일</form:label>
				<form:input path="mem_email"/>
				<form:errors path="mem_email" cssClass="error-color"/>
			</li>
		</ul>
		<div class="button-container">
			<form:button class="idf-btn" id="findPwCheck">비밀번호 찾기</form:button>
			<input type="button" value="로그인" class="idf-btn" onclick="location.href='${pageContext.request.contextPath}/member/login'">
		</div>
	</form:form>
</div>