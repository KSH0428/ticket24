<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<div class="main">
	<form:form id="member_UpdatePasswd" modelAttribute="memberVO">
		<form:hidden path="mem_num" value="${mem_num}"/>
		<form:errors element="div" cssClass="error-color"/>
		<div style="display: flex; justify-content: space-between; margin-bottom: 40px;">
			<h2 style="margin: 0 auto;">비밀번호 변경</h2>
			<input type="button" value="돌아가기" style="margin-left:-70px;" class="member-btn" onclick="location.href='${pageContext.request.contextPath}/member/myPage'">
		</div>
		<div style="margin-left:100px;">
			<ul>
				<li>
					<form:label path="mem_passwd">현재 비밀번호</form:label>
					<form:password path="mem_passwd"/>
					<form:errors path="mem_passwd" cssClass="error-color"/>
				</li>
				<li>
					<form:label path="mem_newpasswd">변경할 비밀번호</form:label>
					<form:password path="mem_newpasswd"/>
					<form:errors path="mem_newpasswd" cssClass="error-color"/>
				</li>
				<li>
					<form:label path="mem_confirmpasswd">비밀번호 확인</form:label>
					<form:password path="mem_confirmpasswd"/>
					<form:errors path="mem_confirmpasswd" cssClass="error-color"/>
				</li>
			</ul>
		</div>
		<div class="align-center">
			<form:button class="member-btn" id="passwdupdatebtn">비밀번호 변경</form:button>
			<input type="button" value="메인으로" class="member-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
	</form:form>
</div>