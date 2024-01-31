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
			<form:input path="ticket_name" placeholder="공연명을 입력하세요"/>
			<form:errors path="ticket_name" cssClass="error-color"/>
		</li>
		 <li>
			<form:label path="ticket_date">공연일</form:label>
			<form:input path="temp_date" id="date" type="date"/>
			<form:input path="temp_time" id="time" type="time"/>
			<form:errors path="ticket_date" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_place">공연 장소</form:label>
			<form:input path="ticket_place" placeholder="공연 장소를 입력하세요"/>
			<form:errors path="ticket_place" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_seat">좌석 정보</form:label>
			<form:input path="ticket_seat" placeholder="좌석정보를 입력하세요"/>
			<form:errors path="ticket_seat" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_quantity">티켓 수량</form:label>
			<form:input path="ticket_quantity" type="number" min="1" size="3" placeholder="수량을 입력하세요"/>장
			<form:errors path="ticket_quantity" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_price">티켓 가격</form:label>
			<form:input path="ticket_price" type="number" maxlength="30" placeholder="가격을 입력하세요"/>원
			<form:errors path="ticket_price" cssClass="error-color"/>
		</li>
		
	 </ul>
	 </form:form>
</div>
<!-- 내용 끝 -->