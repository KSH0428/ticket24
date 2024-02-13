<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

<div class="question-main">
<h2 class="h2">고객센터</h2>
<!-- 상단 시작 -->
<ul class="nav list">
    <li class="nav-item border" style="width: 33.33%; background-color:#f2f2f2;"><a href="/faq/list" class="nav-link link-body-emphasis px-2">자주 찾는 질문</a></li>
    <li class="nav-item border" style="width: 33.33%;"><a href="/question/list" class="nav-link link-body-emphasis px-2">1:1 문의</a></li>
    <li class="nav-item border" style="width: 33.33%;"><a href="/chat/main" class="nav-link link-body-emphasis px-2">1:1 채팅</a></li>
</ul>
<!-- 상단 끝 -->
	<form action="list" id="search_form" method="get">
		<ul class="search">
			<li class="text1">
				자주 찾는 질문 검색
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" class="form-control" value="${param.keyword}" autocomplete="off">
			</li>
			<li>
				<input type="submit" value="찾기" class="btn btn-secondary sbtn">
			</li>
		</ul>
	</form>
	<div class="category-main">
		<ul class="category">
			<li><a href="list">전체</a></li>
			<li><a href="list?faq_category=1">티켓예매</a></li>
			<li><a href="list?faq_category=2">취소/환불</a></li>
			<li><a href="list?faq_category=3">기타</a></li>
		</ul>
		<c:if test="${user.mem_auth == 9}">
		<input type="button" value="질문 등록" onclick="location.href='write'" class="btn btn-warning float-end" style="width:78px;font-size:11pt;padding:0;">
		</c:if>
	</div>
	<table class="table">
		<tr class="table-secondary">
			<th width="70">번호</th>
			<th width="120">카테고리</th>
			<th class="title1">질문</th>
			<th width="120"></th>
		</tr>
		<c:if test="${count > 0}">
		<c:forEach var="faq" items="${list}" varStatus="loop">
		<tr>
			<td>${loop.index + 1}</td>
			<td>
				<c:if test="${faq.faq_category == 1}">티켓예매</c:if>
				<c:if test="${faq.faq_category == 2}">취소/환불</c:if>
				<c:if test="${faq.faq_category == 3}">기타</c:if>
			</td>
			<c:if test="${user.mem_auth != 9}">
			<td class="title2">
				<a href="#" class="faq-title" data-toggle="faq-content-${loop.index}">${faq.faq_title}</a>
				<div class="faq-content" id="faq-content-${loop.index}" style="display:none;"><br><b>[답변]</b>${faq.faq_content}</div>
			</td>
			<td></td>
			</c:if>
			<c:if test="${user.mem_auth == 9}">
			<td class="title2">
				<a href="#" class="faq-title" data-toggle="faq-content-${loop.index}">${faq.faq_title}</a>
				<div class="faq-content" id="faq-content-${loop.index}" style="display:none;"><br><b>[답변]</b>${faq.faq_content}</div>
			</td>
			<td style="text-align:right;">
				<input type="button" value="수정" class="btn btn-outline-secondary btn-sm" onclick="location.href='update?faq_num=${faq.faq_num}'">
				<input type="button" value="삭제" id="delete_btn" class="btn btn-outline-secondary btn-sm">
				<script type="text/javascript">
					let delete_btn = document.getElementById('delete_btn');
					delete_btn.onclick=function(){
						let choice = confirm('삭제하시겠습니까?');
						if(choice){
							location.href='delete?faq_num=${faq.faq_num}';
						}
					};
				</script>
			</td>
			</c:if>
		</tr>
		</c:forEach>
		</c:if>
	</table>
</div>
<c:if test="${param.faq_category == null or param.faq_category == '0'}">
<div style="text-align:center;">
	${page}
</div>
</c:if>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        let faqTitles = document.querySelectorAll('.faq-title');

        faqTitles.forEach(function (title) {
            title.addEventListener('click', function () {
                let contentId = this.getAttribute('data-toggle');
                let content = document.getElementById(contentId);
                
                if (content.style.display == 'none' || content.style.display == '') {
                    content.style.display = 'block';
                } else {
                    content.style.display = 'none';
                }
            });
        });
    });
</script>
