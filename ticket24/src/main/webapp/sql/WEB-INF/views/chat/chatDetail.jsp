<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.chat.js"></script>
<div id="chatDetail" class="page-main">
	<div id="chatting_message"></div>
	<form method="post" id="detail_form">
		<input type="hidden" name="chatroom_num" id="chatroom_num" value="${param.chatroom_num}">
		<ul>
			<li>
				<textarea rows="5" cols="40" name="message" id="message"></textarea>
			</li>
		</ul>
		<div id="message_btn">
			<input type="submit" value="전송">
		</div>
	</form>
</div>