<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>글쓰기</h2>
	<form:form action="write" modelAttribute="ticketVO" id="register_form" enctype="multipart/form-data">
	<form:errors element="div" cssClass="error-color"/>
	<ul>
	 <li>
	 	<form:label path="ticket_category">카테고리</form:label>
            <form:select path="ticket_category">
                <form:option value="1">뮤지컬</form:option>
                <form:option value="2">공연</form:option>
                <form:option value="3">콘서트</form:option>
                <form:option value="4">클래식</form:option>
            </form:select>
	 </li>
	  <li>
			<form:label path="ticket_name">공연명</form:label>
			<form:input path="ticket_name"/>
			<form:errors path="ticket_name" cssClass="error-color"/>
		</li>
		 <li>
			<form:label path="ticket_date">공연일</form:label>
			<form:input path="temp_date" id="date" type="date"/>
			<form:input path="temp_time" id="time" type="time"/>
			<form:errors path="ticket_date" cssClass="error-color"/>
		</li>
	 </ul>
	 </form:form>
</div>
<!-- 내용 끝 -->