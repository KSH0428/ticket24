<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 결제 시작 -->
<div>
	<h2>대관 결제</h2>
	<hr size="1" width="100%">
	<form:form action="reservation" id="reservation_form" modelAttribute="reservHallVO">
	<div class="row">
	<div class="col" style="margin-left: 20px; margin-top: 20px;">
		<c:forEach var="date" items="${reservation_date}">
			<input type="hidden" name="reservation_date" value="${date}"/>
		</c:forEach>
			<div class="row mb-3">
				<h4>결제자 정보</h4>
				<div style="padding-right:30px;">
					<hr style="width:100%;">
				</div>
				<form:label  class="col-form-label form-col" path="reservation_name">결제인</form:label>
				<div class="col-sm-9">
				<form:input class="form-control" path="reservation_name"/>
				<span id="message_name"></span>
				<form:errors path="reservation_name" cssClass="error-color"/>
				</div>
			</div>
			<div class="row mb-3">
				<form:label class="col-form-label form-col" path="reservation_phone">연락처</form:label>
				<div class="col-sm-9">
				<form:input class="form-control" path="reservation_phone"/>
				<span id="message_phone"></span>
				<form:errors path="reservation_phone" cssClass="error-color"/>
				</div>
			</div>
			<div class="row mb-3">
				<form:label class="col-form-label form-col" path="reservation_email">이메일</form:label>
				<div class="col-sm-9">
				<form:input class="form-control" path="reservation_email"/>
				<span id="message_email"></span>
				<form:errors path="reservation_email" cssClass="error-color"/>
				</div>
			</div>
			<br>
			<div class="row mb-3">
				<h4>신청일자</h4>
				<div style="padding-right:30px;">
				<hr style="width:100%;">
				</div>
				<table id="date-table"style="height: 200px;">
				<c:forEach var="reservation_date" items="${date.reservation_date}">
				<tr><td><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일" value="${reservation_date}"/></td></tr>
				</c:forEach>
				</table>
			</div>
			
		</div>
 			<div class="vr vrline" style="padding-right:0;padding-left:0;"></div>
		<div class="col payment-box"  style=" min-height:400px;">
			<h4>결제 정보</h4>
			<div>
				<hr size="1" width="100%">
			</div>
				<span class="gray-font">평일 : <span class="span-right">${weekdayCount}일</span></span><br>
				<span class="gray-font">주말 : <span class="span-right">${weekendCount}일</span></span><br>
				<span style="margin-top: 5px;">총 결제금액 : <span class="span-right" style="color: blue;"><fmt:formatNumber value="${payment.reservation_price}" pattern="#,###" />원</span></span>
			<div>
				<hr size="1" width="100%">
			</div>
			<div class="payment-method">
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="payment_method" id="card">
				  <label class="form-check-label" for="card">
				    신용카드
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="payment_method" id="trans">
				  <label class="form-check-label" for="trans">
				    실시간계좌이체
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="payment_method" id="vbank">
				  <label class="form-check-label" for="vbank">
				    가상계좌
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="payment_method" id="phone" >
				  <label class="form-check-label" for="phone">
				    휴대폰소액결제
				  </label>
				</div>
			</div>
			<div style="float: none;margin-top: 30px;">
				<hr size="1" width="100%">
			</div>
			</div>
		</div>
	</form:form>
	
</div>
<!-- 결제 끝 -->
    