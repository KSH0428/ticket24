<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
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
</div>