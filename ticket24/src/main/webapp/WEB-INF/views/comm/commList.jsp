<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>게시판 목록</h2>
	<form action="list" id="searh_form" method="get">
	<ul class="search">
				<li>
			<select name="keyfield" id="keyfield">
				<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
				<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>ID+별명</option>
				<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
				<option value="4"<c:if test="${param.keyfield == 4}">selected</c:if>>제목+내용</option>
			</select>
		</li>
		<li>
			<input type="search" name="keyword"id="keyword" value="${param.keyword}">
		</li>
		<li>
			<input type="submit" value="찾기">
			<input type="button" value="목록" onclick="location.href='list'">
		</li>
		</ul>
		
	</form>
</div>
<!-- 내용 끝 -->