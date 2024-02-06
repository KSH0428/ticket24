<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<!-- 내용 시작 -->
<div class="page-main">
<div class="container overflow-hidden">
	<div class="row gy-5 justify-content-md-center">
	<br> <br>
	<p class="fs-2 fw-bold">장바구니</p>
	<br> <br><br> <br>
				<table class="table">
				 <thead class="align-center table-dark text-light">
					<tr class="fs-6">
						<th>전체선택</th>
						<th>상품명</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>상품금액</th>
						<th>주문/삭제</th>
					</tr>
					</thead>
					<c:forEach var="mdCart" items="${list}">
					 <tbody class="table-group-divider">
						<tr>
							<td class="align-center">
							<div class="form-check d-flex justify-content-center">
							  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							  <label class="form-check-label" for="flexCheckDefault"></label>
							</div>
							</td>
							<td class="align-center">${mdCart.mdVO.md_name}</td>
							<td class="align-center">${mdCart.order_quantity}</td>
							<td class="align-center">${mdCart.mdVO.md_price}</td>
							<td class="align-center">${mdCart.sub_price}</td>
							<td class="align-center">
							<div class="d-grid gap-2 col-6 mx-auto">
							  <button class="btn btn-secondary btn-sm text-light" type="button"
							     	onclick="location.href='#'">주문</button>
							  <button class="btn btn-light btn-outline-dark btn-sm" type="button"
							  		onclick="location.href='#'">삭제</button>
							</div>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<div>
					총 주문 금액 : ${map.getTotal} , 배송비 : ${map.fee} => 총 지불 금액 : ${map.allSum}
				</div>
				</div>
			</div>
		</div>
		<br> <br><br> <br>
		<br> <br><br> <br>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
		

		<!-- 내용 끝 -->