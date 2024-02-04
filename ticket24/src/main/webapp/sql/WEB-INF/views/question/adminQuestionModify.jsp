<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>

<h2 style="text-align:center;">1:1 문의 답변 수정 [관리자]</h2>
<div class="question-main">
    <form:form action="adminUpdate" modelAttribute="questionVO" enctype="multipart/form-data" class="question-form">
        <form:errors element="div" cssClass="error-color"/>
		<form:hidden path="question_num"/>
        <div class="row mb-3">
            <div class="col-md-2">
                <label for="question_title" class="form-label">제목</label>
            </div>
            <div class="col-md-10">
                <form:input path="question_title" class="form-control"/>
                <form:errors path="question_title" cssClass="error-color"/>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-2">
                <label for="question_content" class="form-label">내용</label>
            </div>
            <div class="col-md-10">
                <form:textarea path="question_content" class="form-control"/>
                <form:errors path="question_content" cssClass="error-color"/>
                <script>
                    function MyCustomUploadAdapterPlugin(editor){
                        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                            return new UploadAdapter(loader);
                        }
                    }

                    ClassicEditor
                        .create(document.querySelector('#question_content'),{
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
                <button type="submit" class="btn btn-primary">수정</button>
                <input type="button" value="목록" onclick="location.href='list'" class="btn btn-default"/>
            </div>
        </div>
    </form:form>
</div>
