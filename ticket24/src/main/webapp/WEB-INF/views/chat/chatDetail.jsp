<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ces.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.chat.js"></script>
<div id="chatDetail" class="page-main">
	<div id="chatHeader">
        <button id="exitButton">채팅 끝내기</button>
    </div>
	<script type="text/javascript">
    $(document).ready(function () {
        // 나가기 버튼 클릭 이벤트
        $('#exitButton').click(function () {
            // Ajax 요청
            $.ajax({
            	url:'deleteChat',
            	data:{chatroom_num:$("#chatroom_num").val()},
                type:'post',
                dataType:'json',
                success: function(param) {
                    if (param.result == 'success') {
                        // 채팅방 숨김
                        $('#chatDetail').hide();
                        window.location.href = '/chat/main';
                    } else {
                        alert("채팅방 나가기 실패");
                    }
                },
                error: function () {
                    alert("네트워크 오류 발생");
                }
            });
        });
    });
	</script>
    
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