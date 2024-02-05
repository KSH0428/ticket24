<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<c:choose>
		<c:when test="${empty mem_id}">
		<p>조회결과가 없습니다.</p>
		</c:when>
        <c:otherwise>
            <p>회원님의 아이디는 '${mem_id.mem_id}' 입니다.</p>
        </c:otherwise>
	</c:choose>
	<p>
	<input type="button" value="로그인" onclick="location.href='request.getContextPath()+"/member/login">
	<input type="button" value="비밀번호 찾기" onclick="location.href='request.getContextPath()+"/member/login">
</div>
</body>
</html>
