<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>


<div class="page-main">
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col">
	<br><br><br>
	<hr>
	<span>
	<img src="${pageContext.request.contextPath}/image_upload/809456_dog_miscellaneous_pet_icon.png"  
			style="width: 30px; height: 30px;">
	<span class="fw-bolder fs-2">리뷰 작성</span>
	</span>
	<p>이 상품의 품질에 대해서 얼마나 만족하시나요?</p>
	<hr>
	<form:form action="reviewWrite" modelAttribute="mdReviewVO" id="register_form"
	                                      enctype="multipart/form-data">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li class="list-style: none;">
				<form:label path="md_title">제목</form:label>
				<form:input path="md_title"/>
				<form:errors path="md_title" cssClass="error-color"/>
			</li>
			<li><b>내용</b></li>
			<li>
				<form:textarea path="md_content"/>
				<form:errors path="md_content" cssClass="error-color"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){
						editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor
					    .create(document.querySelector('#md_content'),{
					    	extraPlugins:[MyCustomUploadAdapterPlugin]
					    })
					    .then(editor => {
					    	window.editor = editor;
					    })
					    .catch(error => {
					    	console.error(error);
					    });					
				</script>
			</li>
			</ul>
			<hr><br>
		<ul>	
			<li>
				<form:label path="upload">파일업로드</form:label>
				<input type="file" name="upload" id="upload">
			</li>
		</ul>
		<br><hr>
		<div class="align-center">
			<form:button>리뷰 등록</form:button>
			<input type="button" value="목록" onclick="location.href='reviewList'">
		</div>	
</form:form>
</div>
	</div>
	</div>
</div>
<!-- 내용 끝 -->


