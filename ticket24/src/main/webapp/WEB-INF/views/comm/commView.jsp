<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="page-main">
	<h2>${comm.comm_title}</h2>
	<ul class="detail-info">
		<li>
			<img src="${pageContext.request.contextPath}/member/viewProfile?mem_num=${comm.mem_num}" width="40" height="40" class="my-photo">
			</li>
			<li>
				<c:if test="${empty comm.mem_nickname}">${comm.mem_id}</c:if>
				<c:if test="${!empty comm.mem_nickname}">${comm.mem_nickname}</c:if>
				<br>
				<c:if test="${!empty comm.comm_modifydate}">
				최근 수정일 : ${comm.comm_modifydate}
				</c:if>
				<c:if test="${empty comm.comm_modifydate}">
				작성일 : ${comm.comm_regdate}
				</c:if>
				조회 : ${comm.comm_hit}
			</li>
		</ul>
		<c:if test="${!empty comm.comm_filename}">
		<ul>
			<li>첨부파일 : <a href="file?comm_num=${comm.comm_num}">${comm.comm_filename}</a></li>
		</ul>
		</c:if>
		<hr size="1"width="100%">
		<c:if test="${fn:endsWith(comm.comm_filename,'.jpg') ||
				  fn:endsWith(comm.comm_filename,'.JPG') ||					
				  fn:endsWith(comm.comm_filename,'.jpeg') ||
				  fn:endsWith(comm.comm_filename,'.JPEG') ||
				  fn:endsWith(comm.comm_filename,'.gif') ||	
				  fn:endsWith(comm.comm_filename,'.GIF') ||
				  fn:endsWith(comm.comm_filename,'.png') ||
				  fn:endsWith(comm.comm_filename,'.PNG')}">
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${comm.comm_filename}" class="detail-img">
		</div>
		</c:if>
		<div class="detail-content">
			${comm.comm_content}
		</div>
		<%-- 좋아요 --%>
		<%-- 댓글수 --%>
		<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == comm.mem_num}">
		<input type="button" value="수정" 
		  onclick="location.href='update?comm_num=${comm.comm_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='delete?comm_num=${comm.comm_num}';
				}
			};
		</script>  
		</c:if>
		<input type="button" value="목록" onclick="location.href='list'">
	</div>
		<!-- 댓글 시작 -->
		<!-- 댓글 목록 출력 시작 -->
		<!-- 댓글 목록 출력 끝 -->
		<!-- 댓글 끝 -->
</div>
<!-- 내용 끝 -->