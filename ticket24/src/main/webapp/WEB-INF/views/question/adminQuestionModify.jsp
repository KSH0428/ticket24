<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<div class="page-main">
	<h3>1:1 문의 답변 수정 [관리자]</h3>
	<form:form action="adminUpdate" modelAttribute="questionVO" enctype="multipart/form-data">
		<form:hidden path="question_num"/>
		<form:errors element="div" cssClass="error-color" />
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="question_title">제목</label>
					<form:input path="question_title" class="form-control"/>
					<form:errors path="question_title" cssClass="error-color" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label for="question_content">내용</label>
					<form:textarea path="question_content" class="form-control" />
					<form:errors path="question_content" cssClass="error-color" />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<button type="submit" class="btn btn-primary">전송</button>
					<input type="button" value="목록" onclick="location.href='list'"
						class="btn btn-default" />
				</div>
			</div>
		</div>
	</form:form>
</div>