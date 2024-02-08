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
<h2 class="h2">1:1문의</h2>
	<img src="${pageContext.request.contextPath}/images/question.jpg" class="qa">
	<table class="table table-bordered">
		<tr>
			<th class="active">제목</th>
			<td colspan="3">${question.question_title}</td>
		</tr>
		<tr>
			<th class="active">작성자</th>
			<td colspan="3">
			<c:if test="${empty question.mem_nickname}">${question.mem_id}</c:if>
			<c:if test="${!empty question.mem_nickname}">${question.mem_nickname}</c:if>
			</td>
		</tr>
		<tr>
			<th class="active">날짜</th>
			<td>
			<c:if test="${!empty question.question_modifydate}">
			최근 수정일 : ${question.question_modifydate}
			</c:if>
			<c:if test="${empty question.question_modifydate}">
			작성일 : ${question.question_regdate}
			</c:if>
			</td>
			<th class="active">조회수</th>
			<td>${question.question_hit}</td>
		</tr>
		<tr>
			<td colspan="4">
			<c:if test="${fn:endsWith(question.question_photo,'.jpg') ||
				  fn:endsWith(question.question_photo,'.JPG') ||					
				  fn:endsWith(question.question_photo,'.jpeg') ||
				  fn:endsWith(question.question_photo,'.JPEG') ||
				  fn:endsWith(question.question_photo,'.gif') ||	
				  fn:endsWith(question.question_photo,'.GIF') ||
				  fn:endsWith(question.question_photo,'.png') ||
				  fn:endsWith(question.question_photo,'.PNG')}">
			<div class="align-center">
				<img src="${pageContext.request.contextPath}/upload/${question.question_photo}" class="detail-img" height="300">
			</div>
			</c:if>
			<div class="detail-content" style="height:250px;">
				${question.question_content}
			</div>
			<div class="align-right">
				<c:if test="${!empty user && user.mem_num  == question.mem_num}">
				<input type="button" value="수정" onclick="location.href='update?question_num=${question.question_num}'">
				<input type="button" value="삭제" id="delete_btn">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
						if(choice){
							location.href='delete?question_num=${question.question_num}';
						}
					};
				</script> 
				</c:if>
			</div>
			</td>
		</tr>
	</table>
	<br>
	<hr size="1" width="90%" style="margin-left:60px;"><br><br>
	<img src="${pageContext.request.contextPath}/images/answer.jpg" class="qa">
	<form:form action="adminWrite" modelAttribute="questionVO" enctype="multipart/form-data" class="answer question-form">
		<form:hidden path="question_num" value="${question.question_num}"/>
		<form:errors element="div" cssClass="error-color"/>
        <div class="row mb-3">
            <div class="col-md-1">
                <label for="question_title" class="form-label">제목</label>
            </div>
            <div class="col-md-10">
                <form:input path="question_title" class="form-control"/>
                <form:errors path="question_title" cssClass="error-color"/>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-1">
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
		<div class="row" style="text-align:right;">
            <div class="col-md-6">
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">전송</button>
                    <input type="button" value="목록" onclick="location.href='list'" class="btn btn-default"/>
                </div>
            </div>
        </div>
	</form:form>
</div>

