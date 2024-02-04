<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<div class="question-main">
    <h2>문의글 비밀번호 확인</h2>
	<form action="checkPassword" method="post" class="question-form">
        <input type="hidden" name="question_num" value="${questionVO.question_num}">
        <label for="question_passwd">비밀번호:</label>
        <input type="password" name="question_passwd">
        <button type="submit">확인</button>
    </form>
</div>
