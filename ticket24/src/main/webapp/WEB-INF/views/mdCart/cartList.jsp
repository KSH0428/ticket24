<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
type="text/javascript"></script>  
<!-- 내용 시작 -->
<h2>장바구니</h2>




<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 끝 -->

<!-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mdCart.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/template/header.jsp"/>
	<div class="content-main">
		<h2>장바구니</h2>
		<c:if test="${empty list}">
		<div class="result-display">
			장바구니에 담은 상품이 없습니다.
		</div>
		</c:if>
		<c:if test="${!empty list}">
		 <form id="cart_order" action="${pageContext.request.contextPath}/order/orderForm.do" method="post">
			<table>
				<tr>
					<th>상품명</th>
					<th>수량</th>
					<th>상품가격</th>
					<th>합계</th>
				</tr>
				<c:forEach var="cart" items="${list}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/md/detail.do?md_num=${mdCart.md_num}">
							<img src="${pageContext.request.contextPath}/upload/${mdCart.mdVO.photo1}" width="50">
							${mdCart.mdVO.md_name}
						</a>
					</td>
					<td class="align-center">
						<input type="number" name="order_quantity" min="1"
						 max="${mdCart.mdVO.md_quantity}" autocomplete="off"
						 value="${mdCart.order_quantity}" class="quantity-width">
						<br> 
						<input type="button" value="변경" class="cart-modify" 
						 data-cartnum="${mdCart.md_cart_num}" data-itemnum="${mdCart.md_num}">
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${mdCart.mdVO.md_price}"/>원
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${mdCart.sub_total}"/>원
						<br>
						<input type="button" value="삭제" class="cart-del"
						                        data-cartnum="${mdCart.md_cart_num}">
					</td>
				</tr>	
				</c:forEach>
				<tr>
					<td colspan="3" class="align-right"><b>총구매금액</b></td>
					<td class="align-center"><fmt:formatNumber value="${all_total}"/>원</td>
				</tr>
			</table>
			<div class="align-center cart-submit">
				<input type="submit" value="구매하기">
			</div>
			</form>
		</c:if>
	</div>
</div>
</body>
</html>
 -->





