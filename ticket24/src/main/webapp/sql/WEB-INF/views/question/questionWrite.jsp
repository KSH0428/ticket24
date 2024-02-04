<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<h2 style="text-align:center;">1:1 문의 작성</h2>
<div class="question-main">
    <form:form action="write" modelAttribute="questionVO" enctype="multipart/form-data" class="question-form">
        <form:errors element="div" cssClass="error-color"/>

        <div class="row mb-3">
            <div class="col-md-2">
                <label for="question_category" class="form-label">카테고리</label>
            </div>
            <div class="col-md-10">
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="question_category" value="1" class="form-check-input"/>상품
			    </div>
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="question_category" value="2" class="form-check-input"/>주문
			    </div>
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="question_category" value="3" class="form-check-input"/>배송
			    </div>
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="question_category" value="4" class="form-check-input"/>기타
			    </div>
			    <form:errors path="question_category" cssClass="error-color"/>
			</div>
        </div>

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
            <div class="col-md-2">
                <div class="form-group">
                    <form:label path="upload"/>첨부파일
                    <input type="file" name="upload" id="upload"/>
                </div>
            </div>
        </div>
        
		<div class="row mb-3">
            <div class="col-md-2">
                <label for="question_category" class="form-label">카테고리</label>
            </div>
            <div class="col-md-10">
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="question_lock" value="1" class="form-check-input" onclick="hidePasswordInput()"/>공개
			    </div>
			    <div class="form-check form-check-inline">
			        <form:radiobutton path="question_lock" value="2" class="form-check-input" onclick="showPasswordInput()"/>비밀
			    </div>
			    <form:errors path="question_lock" cssClass="error-color"/>
			</div>
        </div>
        
        <div class="row mb-3" id="questionPasswd" style="display:none;">
            <div class="col-md-2">
                <label for="question_passwd" class="form-label">비밀번호</label>
            </div>
            <div class="col-md-10">
			    <div class="form-check form-check-inline">
			        <form:input path="question_passwd" class="form-control"/>
			        <form:errors path="question_passwd" cssClass="error-color"/>
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

<script>
    function showPasswordInput() {
        $("#questionPasswd").show();
    }

    function hidePasswordInput() {
        $("#questionPasswd").hide();
    }
</script>
