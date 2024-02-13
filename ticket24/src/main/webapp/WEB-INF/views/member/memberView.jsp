<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ceh.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/member.profile.js"></script>
<!-- 내용 시작 -->
<div class="memberinfo">
	<div class="member-photo">
		<ul>
			<li>
				<img src="${pageContext.request.contextPath}/member/photoView" width="200" height="200" class="my-photo">
				<div class="camera" id="photo_btn">
					<img src="${pageContext.request.contextPath}/image_upload/camera.png" width="35">
				</div>
			</li>
			<li>
				<div id="photo_choice" style="display:none;">
					<input type="file" id="upload" accept="image/gif,image/png,image/jpeg">
					<input type="button" value="전송" id="photo_submit" class="member-btn">
					<input type="button" value="취소" id="photo_reset" class="member-btn">
				</div>
			</li>
		</ul>
	</div>
	<div class="member-point">
		<ul>
			<li>
				'${member.mem_name}'님은 <c:if test="${member.mem_auth == 1}">'실버' 등급입니다.</c:if>
									    <c:if test="${member.mem_auth == 2}">'골드' 등급입니다.</c:if>
									    <c:if test="${member.mem_auth == 3}">'플래티넘' 등급입니다.</c:if>
									    <c:if test="${member.mem_auth == 9}">'관리자' 입니다.</c:if>
			</li>
			<li style="display:flex;">
				<br>적립금 : <fmt:formatNumber value="${all_point}" pattern="#,###" /> 원
			</li>
			<li>
				<input type="button" value="자세히보기" class="member-btn" onclick="location.href='point'">
			</li>
		</ul>
	</div>
	<div class="mypage-button">
		<input type="button" value="회원 정보 수정" class="member-btn" onclick="location.href='update?mem_num=${member.mem_num}'">
		<input type="button" value="비밀번호 변경" class="member-btn" onclick="location.href='passwdUpdate?mem_num=${member.mem_num}'">
	</div>
</div>
<!-- 내용 끝 -->