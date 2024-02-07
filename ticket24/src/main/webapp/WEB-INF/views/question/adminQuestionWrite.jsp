<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<div class="question-main">
	<hr size="1" width="100%">
	<h3>Q.${question.question_title}</h3>
	<ul class="detail-info">
		<li>
			<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${question.mem_num}" width="40" height="40" class="my-photo">
		</li>
		<li>
			<c:if test="${empty question.mem_nickname}">${question.mem_id}</c:if>
			<c:if test="${!empty question.mem_nickname}">${question.mem_nickname}</c:if>
		</li>
	</ul>
	<ul style="text-align:right;">
		<li>
			<c:if test="${!empty question.question_modifydate}">
			최근 수정일 : ${question.question_modifydate}
			</c:if>
			<c:if test="${empty question.question_modifydate}">
			작성일 : ${question.question_regdate}
			</c:if>
			조회수 : ${question.question_hit}
			<br>
		</li>
		<c:if test="${!empty question.question_photo}">
		<li>첨부파일 : <a href="file?question_num=${question.question_num}">${question.question_photo}</a></li>
		</c:if>
	</ul>
	<c:if test="${fn:endsWith(question.question_photo,'.jpg') ||
				  fn:endsWith(question.question_photo,'.JPG') ||					
				  fn:endsWith(question.question_photo,'.jpeg') ||
				  fn:endsWith(question.question_photo,'.JPEG') ||
				  fn:endsWith(question.question_photo,'.gif') ||	
				  fn:endsWith(question.question_photo,'.GIF') ||
				  fn:endsWith(question.question_photo,'.png') ||
				  fn:endsWith(question.question_photo,'.PNG')}">
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${question.question_photo}" class="detail-img">
	</div>
	</c:if>
	<div class="detail-content" style="text-align:center;">
		${question.question_content}
	</div>
	<hr size="1" width="100%">
	<h3>1:1 문의 답변 [관리자]</h3>
	<form:form action="adminWrite" modelAttribute="questionVO" enctype="multipart/form-data">
		<form:hidden path="question_num" value="${question.question_num}"/>
		<form:errors element="div" cssClass="error-color"/>
		 <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="question_title">제목</label>
                    <form:input path="question_title" class="form-control"/>
                    <form:errors path="question_title" cssClass="error-color"/>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="question_content">내용</label>
                    <form:textarea path="question_content" class="form-control"/>
                    <form:errors path="question_content" cssClass="error-color"/>
                </div>
            </div>
        </div>
		<div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">전송</button>
                    <input type="button" value="목록" onclick="location.href='list'" class="btn btn-default"/>
                </div>
            </div>
        </div>
	</form:form>
</div>