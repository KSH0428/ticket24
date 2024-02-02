$(function(){
	let message_socket; //웹소켓 식별자
	
	/*-----------------------
	 * 웹소켓 연결
     *-----------------------*/
	function connectWebSocket(){
		message_socket = new WebSocket("ws://localhost:8000/message-ws");
		message_socket.onopen=function(evt){
			console.log("채팅페이지 접속 : " + $('#chatDetail').length);
			if($('#chatDetail').length == 1){
				message_socket.send("msg:");
			}
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정
		message_socket.onmessage=function(evt){
			let data = evt.data;
			if($('#chatDetail').length == 1 && 
			                data.substring(0,4) == 'msg:'){
				selectMsg();
			}
		};
		message_socket.onclose=function(evt){
			//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
			//console.log('chat close');
		}
	}
	
	/*-----------------------
	 * 채팅하기
     *-----------------------*/
	//채팅 데이터 읽기
	function selectMsg(){
		//서버와 통신
		$.ajax({
			url:'../chat/chatDetailAjax',
			type:'post',
			data:{chatroom_num:$('#chatroom_num').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
					message_socket.close();
				}else if(param.result == 'success'){
					//메시지 표시 UI 초기화
					$('#chatting_message').empty();
					
					let send_date = '';
					$(param.list).each(function(index,item){
						let output = '';
						//날짜 추출
						if(send_date != item.send_date.split(' ')[0]){
							send_date = item.send_date.split(' ')[0];
							output += '<div class="date-position"><span>'+send_date+'</span></div>';
							
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
						}
						
						//문서 객체에 추가
						$('#chatting_message').append(output);
						//스크롤을 하단에 위치시킴
						$('#chatting_message').scrollTop($('#chatting_message')[0].scrollHeight);
					});
				}else{
					alert('채팅 메시지 읽기 오류 발생');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
				message_socket.close();
			}
		});
	}
	
	//메시지 입력 후 enter 이벤트 처리
	$('#message').keydown(function(event){
		if(event.keyCode == 13 && !event.shiftKey){
			$('#detail_form').trigger('submit');
		}
	});
	
	//채팅 메시지 등록
	$('#detail_form').submit(function(event){
		if($('#message').val().trim()==''){
			alert('메시지를 입력하세요');
			$('#message').val('').focus();
			return false;
		}
		
		if($('#message').val().length>1333){
			alert('메시지를 1333자까지만 입력 가능합니다.');
			return false;
		}
		
		//form 이하의 태그에 입력한 데이터를 모두 읽어옴
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
					message_socket.close();
				}else if(param.result == 'success'){
					//폼 초기화
					$('#message').val('').focus();
					//메시지가 저장되었다고 소켓에 신호를 보냄
					message_socket.send('msg:');
				}else{
					alert('채팅 메시지 등록 오류');
					message_socket.close();
				}
			},
			error:function(){
				alert('네트워크 오류');
				message_socket.close();
			}
		});		
		//기본 이벤트 제거
		event.preventDefault();
	});

});














