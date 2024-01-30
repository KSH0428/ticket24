<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<div class="box_tit">
	<p class="tit_event">${event.event_title}</p>
	<p class="data_info">기간 : <span>${event.event_start} ~ ${event.event_end}</span></p>
</div>