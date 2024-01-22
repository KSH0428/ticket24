<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>회원 상세 정보<input type="button" value="회원 정보 수정" onclick="location.href='update'"></h2>
	<ul>
		<li>이름 : ${member.mem_name}</li>
		<li>별명 : ${member.mem_nickname}</li>
		<li>전화번호 : ${member.mem_phone}</li>
		<li>이메일 : ${member.mem_email}</li>
		<li>우편번호 : ${member.mem_zipcode}</li>
		<li>주소 : ${member.mem_address1} ${member.mem_address2}</li>
		<li>가입날짜 : ${member.reg_date}</li>
		<c:if test="${!empty member.modify_date}">
		<li>정보 수정일 : ${member.mem_modify_date}</li>
		</c:if>
	</ul>
</div>
<!-- 내용 끝 -->