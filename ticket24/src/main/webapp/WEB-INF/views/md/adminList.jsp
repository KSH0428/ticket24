<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>상품 등록</h2>
	<form:form action="list" id="md_list" modelAttribute="mdVO">
		<form:errors element="div" cssClass="error-color"/>	
		<!-- 상품표시여부, 상품명, 가격, 수량, 상품사진1, 상품사진2, 상품설명 -->
		<ul>
		<!-- 
			<li>
				<form:label path="md_status">상품표시여부</form:label>
				<form:input path="md_status"/>
				<form:errors path="md_status" cssClass="error-color"/>
			</li>
		 -->	
			<li>
				<form:label path="md_name">상품명</form:label>
				<form:input path="md_name"/>
				<form:errors path="md_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_price">가격</form:label>
				<form:input path="mem_price"/>
			</li>
			<li>
				<form:label path="mem_phone">전화번호</form:label>
				<form:input path="mem_phone"/>
				<form:errors path="mem_phone" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_email">이메일</form:label>
				<form:input path="mem_email"/>
				<form:errors path="mem_email" cssClass="error-color"/>
			</li>
			
			<li>
				<form:label path="mem_address2">상세주소</form:label>
				<form:input path="mem_address2"/>
				<form:errors path="mem_address2" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="홈으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
	</form:form>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.register.js"></script>

<!-- 내용 끝 -->