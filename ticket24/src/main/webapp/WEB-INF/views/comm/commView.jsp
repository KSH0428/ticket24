<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm.reply.js"></script>
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
		<div>
		<img id="output_fav" data-num="${comm.comm_num}" src="${pageContext.request.contextPath}/images/fav01.gif" width="40">
		<span id="output_fcount"></span>
		<%-- 댓글수 --%>
		<span id="output_rcount"></span>
		</div>
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
	<hr size="1" width="100%">
		<!-- 댓글 시작 -->
		<div id="reply_div">
			<span class="re-title">댓글 달기</span>
			<form id="re_form">
			<input type="hidden" name="comm_num" value="${comm.comm_num}" id="comm_num">
			<textarea rows="3" cols="50" name="comm_recontent"
				id="comm_recontent" class="rep-content"
				<c:if test="${empty user}">disabled="disabled"</c:if>
				><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>
				<c:if test="${!empty user}">
				<div id="re_first">
					<span class="letter-count">300/300</span>
				</div>
				<div id="re_second" class="align-right">
			    	<input type="submit" value="전송">
			    	</div>
				</c:if>
			</form>
		</div>
		<!-- 댓글 목록 출력 시작 -->
		<div id="output"></div>
		<div class="paging-button" style="dusplay:none;">
			<input type="button" value="더보기">
		</div>
		<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="100" height="100">
		</div>
		<!-- 댓글 목록 출력 끝 -->
		<!-- 댓글 끝 -->
</div>
<!-- 내용 끝 -->