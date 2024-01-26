<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>

<h2 style="text-align:center;">자주찾는질문 등록</h2>
<div class="question-main">
    <form:form action="write" modelAttribute="faqVO" enctype="multipart/form-data" class="question-form">
        <form:errors element="div" cssClass="error-color"/>

        <div class="row mb-3">
            <div class="col-md-2">
                <label for="faq_category" class="form-label">카테고리</label>
            </div>
            <div class="col-md-10">
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="faq_category" value="1" class="form-check-input"/>티켓예매
			    </div>
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="faq_category" value="2" class="form-check-input"/>취소/환불
			    </div>
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="faq_category" value="3" class="form-check-input"/>기타
			    </div>
			    <form:errors path="faq_category" cssClass="error-color"/>
			</div>
        </div>

        <div class="row mb-3">
            <div class="col-md-2">
                <label for="faq_title" class="form-label">제목</label>
            </div>
            <div class="col-md-10">
                <form:input path="faq_title" class="form-control"/>
                <form:errors path="faq_title" cssClass="error-color"/>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-2">
                <label for="faq_content" class="form-label">내용</label>
            </div>
            <div class="col-md-10">
                <form:textarea path="faq_content" class="form-control"/>
                <form:errors path="faq_content" cssClass="error-color"/>
                <script>
                    function MyCustomUploadAdapterPlugin(editor){
                        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                            return new UploadAdapter(loader);
                        }
                    }

                    ClassicEditor
                        .create(document.querySelector('#faq_content'),{
                            extraPlugins:[MyCustomUploadAdapterPlugin]
                        })
                        .then(editor => {
                            window.editor = editor;
                        })
                        .catch(error => {
                            console.error(error);
                        });
                </script>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-2"></div>
            <div class="col-md-10">
                <button type="submit" class="btn btn-primary">전송</button>
                <input type="button" value="목록" onclick="location.href='list'" class="btn btn-default"/>
            </div>
        </div>
    </form:form>
</div>
