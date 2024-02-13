<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<!-- 내용 시작 -->
<div class="page-main">
<div class="content-main">
			<div class="container d-flex justify-content-center">
				<div class="col-8 col8md-4">
				<br><br>
	<h2 class="fw-bold">상품 등록</h2>
	<br><br>
	<form id="regMd_form" accept-charset="UTF-8" role="form" action="regMd" method="post" enctype="multipart/form-data">
		<ul>
		 	<li class="form-floating mb-3">
				<input type="text" name="md_name" id="md_name" 
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="상품명"> <label for="md_name">상품명</label>
			</li>
		 
			<li class="form-floating mb-3">
				<input type="text" name="md_price" id="md_price" maxlength="12"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="가격"> <label for="md_name">가격(숫자만 입력)</label>
			</li>
			<li class="form-floating mb-3">
				<input type="text" name="md_quantity" id="md_quantity" maxlength="12"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="수량"> <label for="md_quantity">수량</label>
			</li>
			<li class="form-floating mb-3">
				<input type="file" name="upload1" id="upload1" class="form-control"/>
			</li>
			<li class="form-floating mb-3">
				<input type="file" name="upload2" id="upload2" class="form-control"/>
			</li>
			<li class="form-floating mb-3">
				<input type="text" name="md_detail" id="md_detail" 
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="상품설명"> <label for="md_detail">상품설명</label>
			</li>
			
		</ul>
		<div class="align-center">
			<button class="btn default-btn btn-dark" type="submit">등록</button>
			<input type="button" value="홈으로" class="btn default-btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/md/list'">
		</div>
	</form>
	<br><br><br><br><br><br>
	</div>
	</div>
	</div>
</div>
<!-- 내용 끝 -->