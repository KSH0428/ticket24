<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/event.reply.js"></script>
<div class="event-main">
	<div class="box_tit">
		<p class="tit_event">${event.event_title}</p>
		<p class="data_info">기간 : <span>${event.event_start} ~ ${event.event_end}</span></p>
	</div>
	<div class="photo2">
		<img src="${pageContext.request.contextPath}/upload/${event.event_photo2}">
	</div>
	<div class="event_content">
		${event.event_content}
	</div>
	<br><br>
	<hr size="1" width="100%">
	<div class="event_list">
		<input type="button" value="목록" onclick="location.href='list'">
	</div>
	<div class="buttons">
	<c:if test="${user.mem_auth == 9}">
		<input type="button" value="수정" onclick="location.href='update?event_num=${event.event_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.href='delete?event_num=${event.event_num}';
				}
			};
		</script>
	</c:if>
	</div>
	<div id="reply_div">
		<span class="re-title">댓글</span>
		<form id="re_form">
			<input type="hidden" name="event_num" value="${event.event_num}" id="event_num">
			<textarea rows="3" cols="50" name="event_recontent" id="event_recontent" class="rep-content"
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
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="100" height="100">
	</div>
	<!-- 댓글 목록 출력 끝 -->
	<!-- 댓글 끝 -->	
</div>