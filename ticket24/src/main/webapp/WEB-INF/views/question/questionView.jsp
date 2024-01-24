<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="page-main">
	<h3>Q. ${question.question_title}</h3>
	<ul class="detail-info">
		<li>
			<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${question.mem_num}" width="40" height="40" class="my-photo">
			<c:if test="${empty question.mem_nickname}">${question.mem_id}</c:if>
			<c:if test="${!empty question.mem_nickname}">${question.mem_nickname}</c:if>
		</li>
	</ul>
	<ul style="text-align:right;">
		<li>
			<c:if test="${!empty question.question_modifydate}">
			최근 수정일 : ${question.question_modifydate}
			</c:if>
			<c:if test="${empty question.question_modifydate}">
			작성일 : ${question.question_regdate}
			</c:if>
			조회수 : ${question.question_hit}
			<c:if test="${!empty question.question_photo}">
			<li>첨부파일 : <a href="file?question_num=${question.question_num}">${question.question_photo}</a></li>
			</c:if>
			
		</li>
	</ul>
	<hr size="1" width="100%">
	<c:if test="${fn:endsWith(question.question_photo,'.jpg') ||
				  fn:endsWith(question.question_photo,'.JPG') ||					
				  fn:endsWith(question.question_photo,'.jpeg') ||
				  fn:endsWith(question.question_photo,'.JPEG') ||
				  fn:endsWith(question.question_photo,'.gif') ||	
				  fn:endsWith(question.question_photo,'.GIF') ||
				  fn:endsWith(question.question_photo,'.png') ||
				  fn:endsWith(question.question_photo,'.PNG')}">
	<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${question.question_photo}" class="detail-img">
	</div>
	</c:if>
	<div class="detail-content">
		${question.question_content}
	</div>
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num  == question.mem_num}">
		<input type="button" value="수정" onclick="location.href='update?question_num=${answer.question_num}'">
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
	<hr size="1" width="100%">
	<c:if test="${!empty answer}">
	<h3>A. ${answer.question_title}</h3>
	<ul class="detail-info">
		<li>
			<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${question.mem_num}" width="40" height="40" class="my-photo">
			<c:if test="${empty answer.mem_nickname}">${answer.mem_id}</c:if>
			<c:if test="${!empty answer.mem_nickname}">${answer.mem_nickname}</c:if>
		</li>
	</ul>
	<ul style="text-align:right;">
		<li>
			<c:if test="${!empty answer.question_modifydate}">
			최근 수정일 : ${answer.question_modifydate}
			</c:if>
			<c:if test="${empty answer.question_modifydate}">
			작성일 : ${answer.question_regdate}
			</c:if>
			조회수 : ${answer.question_hit}
		</li>
	</ul>
	<hr size="1" width="100%">
	<div class="detail-content">
		${answer.question_content}
	</div>
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num  == answer.mem_num}">
		<input type="button" value="수정" onclick="location.href='adminUpdate?question_num=${answer.question_num}'">
		<input type="button" value="삭제" id="delete_btn_answer">
		<script type="text/javascript">
			let delete_btn_answer = document.getElementById('delete_btn_answer');
			delete_btn_answer.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='adminDelete?question_num=${answer.question_renum}';
				}
			};
		</script> 
		</c:if>
	</div>
	<hr size="1" width="100%">
	</c:if>
	<div class="align-center">
		<c:if test="${!empty user && user.mem_auth == 9 && question.mem_auth != 9 && empty answer}">
		<input type="button" value="답변 작성" onclick="location.href='adminWrite?question_num=${question.question_num}'">
		</c:if>
	</div>
	<div class="align-right">
		<input type="button" value="목록" onclick="location.href='list'">
	</div>
</div>








