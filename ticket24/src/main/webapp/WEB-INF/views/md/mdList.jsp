<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<!-- 내용 시작 -->
<div class="page-main">
	<br><br>
	<h2 class="align-center fw-bolder">MD Shop</h2>
	<div class="align-right">
	  <input type="button" value="MD 등록" class="btn btn-outline-secondary"
	  			onclick="location.href='${pageContext.request.contextPath}/md/regMd'">
		<input type="button" value="장바구니" 
	  			class="btn btn-outline-secondary" 
	  			onclick="location.href='${pageContext.request.contextPath}/mdCart/cartList'">	  
	  	<input type="button" value="MD 구매내역 확인" 
	  			class="btn btn-outline-secondary" onclick="location.href='#'">
	</div> 
	<br><hr><br><br>
	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword"
				                                  value="${param.keyword}" placeholder="검색어 입력">
				
				<!-- <input type="text" class="search-bar" name="keyword" id="keyword" value="${param.keyword}"
				 placeholder="검색어 입력">  -->
  			
			</li>
			<li>
				<input type="submit" value="검색" class="btn btn-dark">
			</li>
		</ul>
		<div class="align-right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>높은가격순</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>낮은가격순</option>
			</select>
		</div>
	</form>
	
	
	<!-- 검색 부분 시작 -->
	<form action="list" id="search_form" method="get">
		<div class="search">
			<select name="keyfield" id="keyfield">
				<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품번호</option>
				<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>상품명</option>
			</select>
			
  			<input type="text" class="search-bar" name="keyword" id="keyword" value="${param.keyword}" placeholder="검색어 입력">
  			<img class="search-btn" id="search-btn" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
 			
 			<!-- 이미지 클릭하면 submit 이벤트 발생 -->
  			<script>
        		function submitForm() {
           		 document.getElementById("search_form").submit();
       			}

       			// 이미지 클릭 이벤트에 함수 할당
        		document.getElementById("search-btn").addEventListener("click", submitForm);
   			</script>
		</div>
		
	</form>
<!-- 검색 부분 끝 -->
	
	
	<c:if test="${count == 0}">
	<div class="result-display">표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	
	<br><br><br>
	
	<div class="container overflow-hidden">
	<div class="row gy-5 justify-content-md-center">
	<c:forEach var="md" items="${list}">
	<div class="card border-white" style="width: 18rem;">
	<div class="p-3">
	<p class="card-text fs-6">no.${md.md_num}</p>	
	  <img src="${pageContext.request.contextPath}/upload/${md.md_photo1}" class="bd-placeholder-img card-img-top" width="100%" height="170">        
	  <div class="card-body">
	  	<br>
	    <p class="card-text fs-6">${md.md_name}</p>
	    <span>
	    <span class="card-text text-danger fs-5"> 
	    <fmt:formatNumber value="${md.md_price}" />원</span> 
	    </span>
	    <br><br>
	    <div class="d-grid">
	    <input type="button" value="상세보기" class="btn btn-dark btn-sm me-md-2" 
	    		onclick="location.href=location.href='detail?md_num=${md.md_num}'">
	    </div>
	  </div>
	  <div class="card-body d-grid d-md-flex justify-content-md-end">
	    <input type="button" value="MD수정" class="btn btn-outline-primary btn-sm me-md-2" 
	    		onclick="location.href=location.href='update?md_num=${md.md_num}'">
		<input type="button" value="MD삭제" class="btn btn-outline-primary btn-sm" 
				onclick="location.href='delete?md_num=${md.md_num}'">
	  </div>
	  </div>
	</div>
	</c:forEach>
	</div>
	</div>
	
	<br><br><br>
	<div class="align-center">${page}</div>
	<br><br><br>
	</c:if>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//검색 유효성 체크
	$('#search_form').submit(function(){
		if($('#keyword').val().trim()==''){
			alert('검색어를 입력하세요!');
			$('#keyword').val('').focus();
			return false;
		}
	});//end of submit
	
	//정렬 선택
	$('#order').change(function(){
		location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val()+'&order='+$('#order').val();
	});
	
});	
</script>
<!-- 내용 끝 -->











