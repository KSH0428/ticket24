<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mdReview.fav.js"></script>
<div class="page-main">
	<h2>${mdReview.md_title}</h2>
	<ul class="detail-info">
			<li>
				<c:if test="${empty mdReview.mem_nickname}">${mdReview.mem_id}</c:if>
				<c:if test="${!empty mdReview.mem_nickname}">${mdReview.mem_nickname}</c:if>
				<br>
				<c:if test="${!empty mdReview.md_mdate}">
				최근 수정일 : ${mdReview.md_mdate}
				</c:if>
				<c:if test="${empty mdReview.md_mdate}">
				작성일 : ${mdReview.md_regdate}
				</c:if>
			</li>
		</ul>
		<hr size="1" width="100%">
		<c:if test="${fn:endsWith(mdReview.md_filename,'.jpg') ||
				  fn:endsWith(mdReview.md_filename,'.JPG') ||					
				  fn:endsWith(mdReview.md_filename,'.jpeg') ||
				  fn:endsWith(mdReview.md_filename,'.JPEG') ||
				  fn:endsWith(mdReview.md_filename,'.gif') ||	
				  fn:endsWith(mdReview.md_filename,'.GIF') ||
				  fn:endsWith(mdReview.md_filename,'.png') ||
				  fn:endsWith(mdReview.md_filename,'.PNG')}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${mdReview.md_filename}" 
			class="detail-img" style="width: 100px; height: 100px;">	
			
		</div>
		</c:if>
		<div class="detail-content">
			${md.md_content}
	
</div>
<!-- 내용 끝 -->