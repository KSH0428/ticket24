<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 결제 시작 -->
<div class="page-main">
	<div class="container overflow-hidden">
		<div class="row gy-5 justify-content-md-center">
			<br> <br>
			<p class="fs-2 fw-bold text-primary">주문하시는 상품</p>
			<hr>
			<br>
			<table class="table">
				<thead class="align-center table-dark text-light">
					<tr class="fs-6">
						<th>상품명</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>소계금액</th>	
					</tr>
				</thead>
				<c:forEach var="mdCart" items="${list}">
					<tbody class="table-group-divider">
						<tr>
							<td class="align-center">${mdCart.mdVO.md_name}</td>
							<td class="align-center">
								<div class="d-grid gap-2 col-6 mx-auto">
								${mdCart.order_quantity}개
								</div>	
							</td>
							<td class="align-center">${mdCart.mdVO.md_price}</td>
							<td class="align-center">${mdCart.sub_price}</td>
						</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<div>
	 <img src="${pageContext.request.contextPath}/image_upload/exclamation.jpg">
	 <p>상품이 품절되는 경우 SMS 안내와 함께 자동 주문취소처리 및 환불 처리가 진행됩니다.</p>
	 <P class="text-danger">(주)티켓24는 MD Shop의 통신판매중개자로서 통신판매의 당사자가 아니므로, 개별 판매자가 등록한 오픈마켓 상품에 대해서 (주)티켓24는 일체 책임을 지지 않습니다.</P>
	</div>
	
	<!-- 총 주문금액 카드 -->
	
	<!-- 02.주문하시는 분 -->
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col">
			 	<h2 class="text-primary">02.주문하시는 분</h2>
				<div class="card" style="height: 37rem;">
					<!-- 주문자 -->
					<!-- 이메일 -->
					<!-- 휴대폰 -->
					<br> <br> <br>
				</div>
			</div>
			
			<!-- 03.받으실 분 -->
			<div class="col">
				<div class="card" style="height: 37rem;">
					<h2 class="text-primary">02.주문하시는 분</h2>
				<div class="card" style="height: 37rem;">
					<!-- 라디오: 기본/ ${mdOrder.md_receive_name}/ 변경버튼-->
					<hr>
					<!-- 받는 이름-->
					<!-- 받는 주소-->
					<!-- 전화번호 -->
					<!-- 배송 메세지(요청사항) 작성-->
					<br> <br> <br>
				</div>
			
				</div>
			</div>
	</div>
	
	<!-- 04.결제정보 입력 -->
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
	
	
</div>
<!-- 결제 끝 -->
    