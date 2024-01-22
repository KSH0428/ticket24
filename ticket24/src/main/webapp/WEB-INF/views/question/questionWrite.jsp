<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="container">
    <h2 style="text-align:center;">1:1 문의 작성</h2>

    <form:form action="write" modelAttribute="questionVO" enctype="multipart/form-data">
        <form:errors element="div" cssClass="error-color"/>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="question_category">카테고리</label>
                    <form:radiobutton path="question_category" value="1"/>상품
                    <form:radiobutton path="question_category" value="2"/>주문
                    <form:radiobutton path="question_category" value="3"/>배송
                    <form:radiobutton path="question_category" value="4"/>기타
                </div>
            </div>
        </div>

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
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="upload">첨부파일</label>
                    <input type="file" name="upload" id="upload"/>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="question_lock">공개 여부</label>
                    <form:radiobutton path="question_lock" value="1" onclick="hidePasswordInput()"/>공개
                    <form:radiobutton path="question_lock" value="2" onclick="showPasswordInput()"/>비밀
                    <div id="questionPasswd" style="display:none;">
                        <label for="question_passwd">비밀번호</label>
                        <form:input path="question_passwd" class="form-control"/>
                    </div>
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
