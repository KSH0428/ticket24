<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 내용 시작 -->
<div class="page-main">
	<h2>상품 등록</h2>
	<form:form action="regMd" id="insertMd" modelAttribute="mdVO">	
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
			</li>
			<li>
				<form:label path="md_price">가격</form:label>
				<form:input path="md_price"/>
			</li>
				<li>
				<form:label path="md_quantity">수량</form:label>
				<form:input path="md_quantity"/>
			</li>
			<li>
				<form:label path="md_detail">상품설명</form:label>
				<form:textarea path="md_detail"/>
			</li>
			
		</ul>
		<div class="align-center">
			<form:button class="default-btn">등록</form:button>
			<input type="button" value="홈으로" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/main/main'">
		</div>
	</form:form>
</div>
<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
 -->
<!-- 내용 끝 -->