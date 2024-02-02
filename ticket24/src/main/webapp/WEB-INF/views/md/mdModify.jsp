<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<!-- 내용 시작 -->
<div class="page-main">
<div class="content-main">
			<div class="container d-flex justify-content-center">
				<div class="col-8 col8md-4">
	<br><br><br>
	<h2>MD상품수정</h2>
	<br>
	<form id="update_form" accept-charset="UTF-8"
			 role="form" action="update" method="post">
		<input type="hidden" name="md_num" value="${mdVO.md_num}">	 
		<!-- 상품표시여부, 상품명, 가격, 수량, 상품사진1, 상품사진2, 상품설명 -->
		<ul>
		 	<li class="form-floating mb-3">
				<input type="text" name="md_name" id="md_name" maxlength="12" value="${mdVO.md_name}"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="상품명"> <label for="md_name">상품명</label>
			</li>
		 
			<li class="form-floating mb-3">
				<input type="text" name="md_price" id="md_price" maxlength="12" value="${mdVO.md_price}"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="가격"> <label for="md_name">가격(숫자만 입력)</label>
			</li>
			<li class="form-floating mb-3">
				<input type="text" name="md_quantity" id="md_quantity" maxlength="12" value="${mdVO.md_quantity}"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="수량"> <label for="md_quantity">수량</label>
			</li>
			<li class="form-floating mb-3">
				<input type="text" name="md_photo1" id="md_photo1" maxlength="12" value="${mdVO.md_photo1}"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="상품사진(썸네일)"> <label for="md_photo1">상품사진(썸네일)</label>
				<input type="button" value="파일 첨부" class="default-btn">
			</li>
			<li class="form-floating mb-3">
				<input type="text" name="md_photo2" id="md_photo2" maxlength="12" value="${mdVO.md_photo2}"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="상품사진(상세페이지)"> <label for="md_photo2">상품사진(상세페이지)</label>
				<input type="button" value="파일 첨부" class="default-btn">
			</li>
			<li class="form-floating mb-3">
				<input type="text" name="md_detail" id="md_detail" maxlength="12" value="${mdVO.md_detail}"
				class="input-check form-control rounded-3 bg-body-tertiary border-0"
				placeholder="상품설명"> <label for="md_detail">상품설명</label>
			</li>
			

		</ul>
		<br><br>
		<div class="align-center">
			<button class="default-btn" type="button">수정</button>
			<input type="button" value="MD삭제" class="default-btn"
			   onclick="location.href=location.href='delete?md_num=${MdVO.md_num}'">
		</div>	
	</form>
	</div>
	</div>
	</div>
	
</div>

<!-- 내용 끝 -->


