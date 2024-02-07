<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<div class="event-main">
	<h2 class="h2">이벤트</h2>

	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list'">
			</li>
		</ul>
	</form>
	<c:if test="${user.mem_auth == 9}">
	<input type="button" value="이벤트 등록" onclick="location.href='write'" class="btn btn-warning float-end">
	</c:if>
	<br><br><br>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 이벤트가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
	<c:forEach var="event" items="${list}">
	
	  <a href="detail?event_num=${event.event_num}">
        <div class="col">
          <div class="card shadow-sm">
            <img src="${pageContext.request.contextPath}/upload/${event.event_photo1}" class="bd-placeholder-img card-img-top" width="100%" height="125">
            <div class="card-body">
              <p class="card-text"><b>${event.event_title}</b></p>
              <p class="card-text">이벤트 기간 : ${event.event_start} ~ ${event.event_end}</p>
              <p class="card-text">이벤트 혜택 : 
              	<c:choose>
              		<c:when test="${event.event_point == 0}"> </c:when>
                    <c:otherwise>적립금 ${event.event_point}원</c:otherwise>
                </c:choose>
              </p>
            </div>
          </div>
        </div>
      </a>
	</c:forEach>
    </div>		
	<br><br><br>
	<div class="align-center">${page}</div>
	<br><br><br>
	</c:if>

</div>
