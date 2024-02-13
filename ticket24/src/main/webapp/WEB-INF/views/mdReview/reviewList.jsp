<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 내용 시작 -->
<div class="page-main">
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col">
				<br><br>
				<h2 class="fw-bold">전체 리뷰</h2>
				<form action="reviewList" id="search_form" method="get">
					<div class="align-right">
						<select id="order" name="order">
							<option value="1"
								<c:if test="${param.order == 1}">selected</c:if>>최신순</option>
							<option value="2"
								<c:if test="${param.order == 2}">selected</c:if>>좋아요높은순</option>
							<option value="3"
								<c:if test="${param.order == 3}">selected</c:if>>좋아요낮은순</option>
						</select>
						<c:if test="${!empty user}">
							<input type="button" value="리뷰작성" class="btn btn-dark btn-lg"
								onclick="location.href='/mdReview/reviewWrite'">
						</c:if>
					</div>
				</form>
				<c:if test="${count == 0}">
					<div class="result-display">표시할 게시물이 없습니다.</div>
				</c:if>
				<c:if test="${count > 0}">
					<br>
					<br>
				
					<c:forEach var="mdReview" items="${list}">
						<div class="accordion">
							<div class="accordion-item">
								<h2 class="accordion-header">
									<button class="accordion-button" type="button"
										data-bs-toggle="collapse"
										data-bs-target="#panelsStayOpen-collapseOne"
										aria-expanded="true"
										aria-controls="panelsStayOpen-collapseOne">
										<h4 class="fs-4 text-primary">${mdReview.md_title}</h4>
									</button>
								</h2>
								<div class="accordion-collapse collapse show">
									<div class="accordion-body">
										<div>
											<span class="align-center fw-bold"> 
											<c:if test="${empty mdReview.mem_nickname}">${mdReview.mem_id}</c:if>
											<c:if test="${!empty mdReview.mem_nickname}">${mdReview.mem_nickname}</c:if>
											</span> <span class="float-end">${mdReview.md_regdate}</span>
										</div>
										<br> ${mdReview.md_content} <br>
										<br> <img
											src="${pageContext.request.contextPath}/upload/${mdReview.md_filename}"
											class="detail-img"> <br>
										<br>
										<span> <span class="float-end">이 리뷰가
												도움이 되었나요? 
												 <%-- 좋아요 --%> 
												<img id="output_fav" data-num="${mdReview.md_review_num}"
												src="${pageContext.request.contextPath}/images/fav01.gif"
												width="40"> <span id="output_fcount">
												${mdReview.fav_cnt}
												</span>
											</span>
										</span>
										<input type="button" value="수정"
										class="btn btn-outline-secondary"
										onclick="location.href='${pageContext.request.contextPath}/mdReview/update'">
													<input type="button" value="삭제"
										class="btn btn-outline-secondary"
										onclick="location.href='${pageContext.request.contextPath}/mdReview/delete'">	
									</div>
								</div>
							</div>
						</div>
						<br>
					</c:forEach>
					<div class="align-center">${page}</div>
				</c:if>
			</div>
			<br>
		</div>
	</div>
</div>
<br><br><br><br>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		//정렬 선택
		$('#order').change(
				function() {
					location.href = 'list?keyfield=' + $('#keyfield').val()
							+ '&keyword=' + $('#keyword').val() + '&order='
							+ $('#order').val();
				});

	});
</script>
<!-- 내용 끝 -->











