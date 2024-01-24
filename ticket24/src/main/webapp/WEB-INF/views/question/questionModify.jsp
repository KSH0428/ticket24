<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>1:1 문의 수정</h2>
	<form:form action="update" modelAttribute="questionVO" id="update_form" enctype="multipart/form-data">
		<form:hidden path="question_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="question_category">카테고리</form:label>
				<form:radiobutton path="question_category" value="1"/>상품
				<form:radiobutton path="question_category" value="2"/>주문
				<form:radiobutton path="question_category" value="3"/>배송
				<form:radiobutton path="question_category" value="4"/>기타
			</li>
			<li>
				<form:label path="question_title">제목</form:label>
				<form:input path="question_title"/>
				<form:errors path="question_title" cssClass="error-color"/>
			</li>
			<li><b>내용</b></li>
			<li>
				<form:textarea path="question_content"/>
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
			</li>
			<li>
				<form:label path="upload">첨부파일</form:label>
				<input type="file" name="upload" id="upload">
				<c:if test="${!empty questionVO.question_photo}">
				<div id="file_detail">(${questionVO.question_photo})파일이 등록되어 있습니다.
					<input type="button" value="파일삭제" id="file_del">
				</div>
				<script type="text/javascript">
					$(function(){
						$('#file_del').click(function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								$.ajax({
									url:'deleteFile',
									data:{question_num:${questionVO.question_num}
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
			<li>
				<form:label path="question_lock">공개 여부</form:label>
				<form:radiobutton path="question_lock" value="1" onclick="hidePasswordInput()"/>공개
				<form:radiobutton path="question_lock" value="2" onclick="showPasswordInput()"/>비밀
			</li>
			<li id="questionPasswd">
				<form:label path="question_passwd">비밀번호</form:label>
				<form:input path="question_passwd"/>
				<script>
					window.onload=function(){
						var isPasswd = true;
							
						if(isPasswd){
							showPasswordInput();
						}else{
							hidePasswordInput();
						}
					};
					
				    function showPasswordInput() {
				        document.getElementById("questionPasswd").style.display = "block";
				    }
				
				    function hidePasswordInput() {
				        document.getElementById("questionPasswd").style.display = "none";
				    }
				</script>
			</li>
		</ul>
		<div class="align-center">
			<form:button>전송</form:button>
			<input type="button" value="목록" onclick="location.href='list'">
		</div>
	</form:form>
</div>