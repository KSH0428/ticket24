<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<body>
<div class="main">
	<div class="findId">
		<c:choose>
			<c:when test="${empty mem_id}">
			<p>해당 정보로 가입 되어있는 아이디가 없습니다.</p><br>
			</c:when>
	        <c:otherwise>
	            <p>회원님의 아이디는 <span style="font-size: 20px;">'${mem_id.mem_id}'</span> 입니다.</p>
	        </c:otherwise>
		</c:choose>
		<div>
			<input type="button" class="idf-btn" value="로그인" onclick="location.href='login'">
			<input type="button" class="idf-btn" value="비밀번호 찾기" onclick="location.href='findPwCheck'">
			<input type="button" class="idf-btn" value="메인으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
	</div>
</div>
</body>
</html>
