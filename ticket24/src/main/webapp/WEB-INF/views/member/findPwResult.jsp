<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 이메일 발송</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<body>
<div class="main">
	<div class="findId">
	            <p style="text-align:center">이메일로 임시비밀번호를 발송해드렸습니다. <br> 로그인 후 비밀번호를 변경해주세요.</p>
		<div>
			<input type="button" class="idf-btn" value="로그인" onclick="location.href='login'">
			<input type="button" class="idf-btn" value="메인으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
	</div>
</div>
</body>
</html>
