<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>글 수정</h2>
	<form:form action="update" modelAttribute="commVO" id="update_form" enctype="multipart/form-data">
	<form:hidden path="comm_num"/>
	<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
            <form:label path="comm_category">카테고리</form:label>
            <form:select path="comm_category">
                <form:option value="1">자유게시판</form:option>
                <form:option value="2">뮤지컬</form:option>
                <form:option value="3">공연</form:option>
                <form:option value="4">콘서트</form:option>
                <form:option value="5">클래식</form:option>
            </form:select>
        </li>
		<li>
			<form:label path="comm_title">제목</form:label>
			<form:input path="comm_title"/>
			<form:errors path="comm_title" cssClass="error-color"/>
		</li>
		<li><b>내용</b></li>
		<li>
			<form:textarea path="comm_content"/>
			<form:errors path="comm_content" cssClass="error-color"/>
			<script>
				function MyCustomUploadAdapterPlugin(editor){
					editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						return new UploadAdapter(loader);
					}
				}
				
				ClassicEditor
					.create(document.querySelector('#comm_content'),{
						extraPlugins:[MyCustomUploadAdapterPlugin]
					})
					.then(editor => {
						window.editor = editor;
					})
					.catch(error => {
						console.error(error);
					})
			</script>
		</li>
		<li>
			<form:label path="upload">파일업로드</form:label>
			<input type="file" name="upload" id="upload">
			<c:if test="${!empty commVO.comm_filename }">
			<div id="file_detail">(${commVO.comm_filename})파일이 등록되어 있습니다.
				<input type="button" value="파일삭제" id="file_del">
			</div>
			<script type="text/javascript">
				$(function(){
					$('#file_del').click(function(){
						let choice = confirm('삭제하시겠습니까?');
						if(choice){
							$.ajax({
								url:'deleteFile',
								data:{comm_num:${commVO.comm_num}},
								type:'post',
								dataType:'json',
								success:function(param){
									if(param.result == 'logout'){
										alert('로그인 후 사용하세요');
									}else if(param.result == 'success'){
										$('#file_detail').hide();										
									}else{
										alert('파일 삭제 오류 발생');
									}
								},
								error:function(){
									alert('네트워크 오류 발생');
								}
							});
						}
					});
				});
			</script>
			</c:if>
		</li>
	</ul>
	<div class="align-center">
		<form:button>전송</form:button>
		<input type="button" value="글 상세" onclick="location.href='detail?comm_num=${commVO.comm_num}'">
	</div>
	</form:form>
</div>

<!-- 내용 끝 -->