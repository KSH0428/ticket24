<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<h2 style="text-align:center;">자주찾는질문 등록</h2>
<div>
    <form:form action="write" modelAttribute="faqVO" enctype="multipart/form-data">
        <form:errors element="div" cssClass="error-color"/>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="faq_category">카테고리</label>
                    <form:radiobutton path="faq_category" value="1"/>티켓예매
                    <form:radiobutton path="faq_category" value="2"/>취소/환불
                    <form:radiobutton path="faq_category" value="3"/>기타
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="faq_title">제목</label>
                    <form:input path="faq_title" class="form-control"/>
                    <form:errors path="faq_title" cssClass="error-color"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="faq_content">내용</label>
                    <form:textarea path="faq_content" class="form-control"/>
                    <form:errors path="faq_content" cssClass="error-color"/>
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
