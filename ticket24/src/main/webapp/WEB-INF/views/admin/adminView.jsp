<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					<input type="button" value="전송" id="photo_submit">
					<input type="button" value="취소" id="photo_reset">
				</div>
			</li>
		</ul>
	</div>
	<div class="member-point">
		<ul>
			<li>
				'관리자 페이지' 입니다.
			</li>
		</ul>
	</div>
	<div class="mypage-button">
		<input type="button" value="관리자 정보 수정" onclick="location.href='update?mem_num=${member.mem_num}'">
		<input type="button" value="비밀번호 변경" onclick="location.href='passwdUpdate?mem_num=${member.mem_num}'">
	</div>
</div>
<!-- 내용 끝 -->