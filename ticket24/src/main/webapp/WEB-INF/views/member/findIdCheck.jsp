<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="page-main">
	<h1 class="align-center">아이디 찾기</h1>
	<form:form id="findIdCheck" modelAttribute="memberVO">
		<ul>
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
		<div class="align-center">
			<form:button class="default-btn" id="findIdCheck">아이디 찾기</form:button>
			<input type="button" value="메인으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
	</form:form>
</div>