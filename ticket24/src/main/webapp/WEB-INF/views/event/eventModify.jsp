<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>

<h2 style="text-align:center;">이벤트 수정</h2>
<div class="question-main">
    <form:form action="/event/update" modelAttribute="eventVO" enctype="multipart/form-data" class="question-form">
        <form:errors element="div" cssClass="error-color"/>
        <form:hidden path="event_num"/>
        <div class="row mb-3">
            <div class="col-md-2">
                <label for="event_title" class="form-label">제목</label>
            </div>
            <div class="col-md-10">
                <form:input path="event_title" class="form-control"/>
                <form:errors path="event_title" cssClass="error-color"/>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-2">
                <label for="event_content" class="form-label">내용</label>
            </div>
            <div class="col-md-10">
                <form:textarea path="event_content" class="form-control"/>
                <form:errors path="event_content" cssClass="error-color"/>
                <script>
                    function MyCustomUploadAdapterPlugin(editor){
                        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
                            return new UploadAdapter(loader);
                        }
                    }

                    ClassicEditor
                        .create(document.querySelector('#event_content'),{
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
		    <div class="col-md-6">
		        <div class="form-group">
		            <label for="upload1">썸네일 사진</label>
		            <input type="file" name="upload1" id="upload1" class="form-control"/>
		        	<c:if test="${!empty eventVO.event_photo1}">
					<div id="file_detail">(${eventVO.event_photo1})파일이 등록되어 있습니다.
						<input type="button" value="파일삭제" id="file_del">
					</div>
					<script type="text/javascript">
						$(function(){
							$('#file_del').click(function(){
								let choice = confirm('삭제하시겠습니까?');
								if(choice){
									$.ajax({
										url:'deleteFile',
										data:{question_num:${questionVO.question_num}},
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
		        </div>
		    </div>
		    <div class="col-md-6">
		        <div class="form-group">
		            <label for="upload2">본문 대표 사진</label>
		            <input type="file" name="upload2" id="upload2" class="form-control"/>
		        	<c:if test="${!empty eventVO.event_photo2}">
					<div id="file_detail">(${eventVO.event_photo2})파일이 등록되어 있습니다.
						<input type="button" value="파일삭제" id="file_del">
					</div>
					<script type="text/javascript">
						$(function(){
							$('#file_del').click(function(){
								let choice = confirm('삭제하시겠습니까?');
								if(choice){
									$.ajax({
										url:'deleteFile',
										data:{question_num:${questionVO.question_num}},
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
		        </div>
		    </div>
		</div>
		
		<div class="row mb-3">
		    <div class="col-md-2">
		        <label class="form-label">기간</label>
		    </div>
		    <div class="col-md-10">
		        <div class="row align-items-center">
		            <div class="col-md-2">
		                <label for="event_start" class="form-label">시작일:</label>
		            </div>
		            <div class="col-md-3">
		                <input type="date" name="event_start" id="event_start" class="form-control" value="${eventVO.event_start}">
		            </div>
		            <div class="col-md-1">
		                <b>~</b>
		            </div>
		            <div class="col-md-2">
		                <label for="event_end" class="form-label">종료일:</label>
		            </div>
		            <div class="col-md-3">
		                <input type="date" name="event_end" id="event_end" class="form-control" value="${eventVO.event_end}">
		            </div>
		        </div>
		    </div>
		</div>
		
        <div class="row mb-3">
            <div class="col-md-2">
                <label for="event_point" class="form-label">적립금</label>
            </div>
            <div class="col-md-4">
                <input type="number" name="event_point" id="event_point" class="form-control" value="${eventVO.event_point}">
                <form:errors path="event_point" cssClass="error-color"/>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">수정</button>
                    <input type="button" value="목록" onclick="location.href='list'" class="btn btn-default"/>
                </div>
            </div>
        </div>
    </form:form>
</div>