<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<div class="question-main">
    <h2 class="h2" style="margin-top:120px;font-size:18pt;">문의글 비밀번호 확인</h2>
	<form action="checkPassword" method="post" class="question-form" style="text-align:center;margin-top:5px;">
        <input type="hidden" name="question_num" value="${questionVO.question_num}">
        <input type="password" name="question_passwd" placeholder="비밀번호를 입력해주세요." style="height:40px;width:320px;">
        <button type="submit" class="btn btn-dark" style="height:40px;width:60px;font-size:10pt;margin-bottom:4.5px;">확인</button>
    </form>
</div>