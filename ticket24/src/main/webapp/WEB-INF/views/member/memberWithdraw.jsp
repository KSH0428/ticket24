<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$('#withdrawbtn').click(function(){
		let choice = confirm('삭제하시겠습니까?');
		if(choice){
			location.href='withdraw?mem_num=${member.mem_num}';
		}
	});
});
</script>
<div class="page-main">
		<h1 class="align-center">회원 탈퇴</h1>
		<form:form action="withdraw" id="member_withdraw" modelAttribute="memberVO">
			<form:hidden path="mem_num"/>
			<form:errors element="div" cssClass="error-color"/>	
			<ul>
				<li>
					<form:label path="mem_passwd">비밀번호</form:label>
					<form:input path="mem_passwd"/>
					<form:errors path="mem_passwd" cssClass="error-color"/>
				</li>
				<li>
					<form:label path="mem_passwd">비밀번호 재확인</form:label>
					<form:input path="mem_passwd"/>
					<form:errors path="mem_phone" cssClass="error-color"/>
				</li>
			</ul>
			<div class="align-center">
				<form:button class="default-btn" id="withdrawbtn">회원 탈퇴</form:button>
				<input type="button" value="메인으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
			</div>
	</form:form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
