$(function(){
	let message_socket = new WebSocket("ws://localhost:8000/message-ws");
		message_socket.onopen = function(evt) {
				message_socket.send("usg:");
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		message_socket.onmessage = function(evt) {
			//메시지 알림
			let data = evt.data;
			if (data.substring(0, 4) == "usg:") {
				console.log('데이터 처리');
				selectList();
			}
		};
		message_socket.onclose = function(evt) {
			//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
		};	
				
	//초기 데이터(목록) 호출
	function selectList(){
		
		let form_data = $('#detail_form').serialize();
		$('#loading').show();
		$.ajax({
			url:'../chat/chatDetailAjax',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				//로딩 이미지 감추기
				$('#loading').hide();
				
				$('#chatting_message').empty();
				
				let send_date = '';
				$(param.list).each(function(index,item){
					let output = '';
					//날짜 추출
					if(send_date != item.send_date.split(' ')[0]){
						send_date = item.send_date.split(' ')[0];
						output += '<div class="date-position"><span>'+send_date+'</span></div>';
					}
					if(item.mem_num == param.user_num){
						output += '<div class="from-position">'+item.mem_id;
						output += '<div>';
					}else{
						output += '<div class="to-position">';
						output += '<div class="space-photo">';
						output += '<img src="../member/viewProfile?mem_num='+item.mem_num+'" width="40" height="40" class="my-photo">';
						output += '</div><div class="space-message">';
						output += item.mem_id;
					}
					output += '<div class="item">';
					output += item.read_check + '<span>' + item.message.replace(/\r\n/g,'<br>').replace(/\r/g,'<br>').replace(/\n/g,'<br>') + '</span>';
					//시간 추출
					output += '<div class="align-right">'+item.send_date.split(' ')[1]+'</div>';
					output += '</div>';
					output += '</div><div class="space-clear"></div>';
					output += '</div>';
					
					//문서 객체에 추가
					$('#chatting_message').append(output);
					//스크롤를 하단으로 위치시킴
					$('#chatting_message').scrollTop($("#chatting_message")[0].scrollHeight);
				});
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide();
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
	}
	
	//채팅 메시지 등록
	$('#detail_form').submit(function(event){
		if($('#message').val().trim()==''){
			alert('내용을 입력하세요');
			$('#message').val('').focus();
			return false;
		}
		
		//form 이하의 태그에 입력한 데이터를 모두 읽어옴(쿼리 스트링 형식으로 읽어옴)
		let form_data = $(this).serialize();		
		
		//서버와 통신
		$.ajax({
			url:'../chat/writeChat',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					$('#message').val('').focus();
					message_socket.send("usg:");
				}else{
					alert('채팅 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
		//기본 이벤트 제거
		event.preventDefault();
	});
	
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
			if(event.keyCode == 13 && !event.shiftKey) {
				$('#detail_form').trigger('submit');
			}
	});
});