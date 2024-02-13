<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- reservation 메뉴 시작 -->
<div class="side-bar">
	<ul class="nav nav-underline flex-column side-bar-menu">
	<li class="ul-label"><span>Ticket24<br>Art Center</span></li>	
	  <li class="nav-item">
	    <a class="nav-link" aria-current="page" href="reservMain"><i class="bi bi-suit-diamond-fill"></i> 시설소개</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="reservSchedule" href="reservSchedule"><i class="bi bi-suit-diamond-fill"></i> 대관일정</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="reserv" href="list"><i class="bi bi-suit-diamond-fill"></i> 대관예약</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" id="reservList" href="reservList"><i class="bi bi-suit-diamond-fill"></i> 예약확인</a>
	  </li>
	  <c:if test="${!empty user && user.mem_auth == 9}">
	  <li class="nav-item">
	    <a class="nav-link" id="reservListAdmin" href="reservListAdmin"><i class="bi bi-suit-diamond-fill"></i> [관리자]예약목록</a>
	  </li>
	  </c:if>
	</ul>
	<div class="file-list">
		<span style="font-weight: bold;font-size: 20px;">Download</span><br>
		<span>공연장 관련자료를 다운받으세요</span>
		<ul>
			<li><a href="sideFile?filename=무대도면.pdf"><i class="bi bi-box-arrow-in-down"></i> 무대도면</a></li>
			<li><a href="sideFile?filename=분장실도면.pdf"><i class="bi bi-box-arrow-in-down"></i> 분장실 도면</a></li>
			<li><a href="sideFile?filename=리허설룸도면.pdf"><i class="bi bi-box-arrow-in-down"></i> 리허설룸 도면</a></li>
			<li><a href="sideFile?filename=공연장장비목록.pdf"><i class="bi bi-box-arrow-in-down"></i> 공연장 장비 목록</a></li>
		</ul>
	</div>
</div>
<!-- reservation 메뉴 끝 -->







