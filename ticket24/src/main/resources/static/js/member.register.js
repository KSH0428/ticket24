$(function(){
	/*----------------------------
	*			회원가입
	*----------------------------*/
	//아이디 중복 여부 저장 변수 : 0은 아이디 중복 또는 중복 체크 미실행, 1은 아이디 미중복
	let checkId = 0;
	
	//아이디 중복 체크
	$('#confirmId').click(function(){
		if($('#mem_id').val().trim()==''){
			$('#message_id').css('color','red').text('아이디를 입력하세요');
			$('#mem_id').val('').focus();
			return; //submit이면 return false, click은 return
		}
		
		//서버와 통신
		$.ajax({
			url:'confirmId',
			type:'post',
			data:{mem_id:$('#mem_id').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'idNotFound'){
					$('#message_id').css('color','#000').text('등록 가능 Id');
					checkId = 1;
				}else if(param.result == 'idDuplicated'){
					$('#message_id').css('color','red').text('중복된 ID');
					$('#mem_id').val('').focus();
					checkId = 0;
				}else if(param.result == 'notMatchPattern'){
					$('#message_id').css('color','red').text('영문,숫자만 4~12자 입력')
					$('#mem_id').val('').focus();
					checkId = 0;
				}else{
					checkId = 0;
					alert('ID 중복 체크 오류');
				}
			},
			error:function(){
				checkId=0;
				alert('네트워크 오류 발생')
			}
		});//end of ajax
	});//end of click
	
	//아이디 중복 안내 메시지 초기화 및 아이디 중복 값 초기화
	$('#member_register #mem_id').keydown(function(){//공백이 있으면 후손 선택자
		checkId=0;
		$('#message_id').text('');
	});//end of keydown
	
	//submit 이벤트 발생시 아이디 중복 체크 여부 확인
	$('#member_register').submit(function(event){
		if(checkId == 0){
			$('#message_id').css('color','red').text('아이디 중복 체크 필수');
			if($('#mem_id').val().trim()==''){
				$('#mem_id').val('').focus();
			}
			return false;
		}
		if($('#mem_ckemail').val() !== code) {
        $('#mail-check-warn').text('인증번호가 일치하지 않습니다.').css('color','red');
        event.preventDefault(); // 폼 제출을 막음
        }
	});//end of submit
	
    // 비밀번호 확인 필드 값이 변경될 때마다 일치 여부를 확인
 	$('#mem_passwd, #mem_ckpasswd').keyup(function() {
        // 입력된 비밀번호와 비밀번호 확인 값 가져오기
        let password = $('#mem_passwd').val();
        let confirmPassword = $('#mem_ckpasswd').val();
        
        // 비밀번호와 비밀번호 확인 값이 다를 경우
        if (password !== confirmPassword) {
            // 비밀번호 확인 메시지 표시
            $('#checkText').text('비밀번호가 일치하지 않습니다.').css('color','red');
        } else {
            // 일치할 경우 메시지 초기화
            $('#checkText').text('비밀번호 일치').css('color','green');
        }
    });

	$('#mem_phone').on('input', function() {
            let phoneNumber = $(this).val().replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거
            let formattedPhoneNumber = formatPhoneNumber(phoneNumber); // 휴대폰 번호 형식에 맞게 포맷팅
            
            $(this).val(formattedPhoneNumber); // 입력란에 포맷팅된 번호 적용
        });

    // 휴대폰 번호 포맷팅 함수
    function formatPhoneNumber(phoneNumber) {
        let formattedPhoneNumber = '';

        if (phoneNumber.length === 10) { // 0101234567 형식
            formattedPhoneNumber = phoneNumber.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        } else if (phoneNumber.length === 11) { // 010-1234-5678 형식
            formattedPhoneNumber = phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
        } else { // 그 외의 경우
            formattedPhoneNumber = phoneNumber;
        }

        return formattedPhoneNumber;
    }
	
	$('#emailBtn').click(function() {
	    let email = $('#mem_email').val(); // 이메일 주소값 얻어오기
	    let checkInput = $('#mem_ckemail'); // 인증번호 입력하는곳 
		
		if($('#mem_email').val().trim()==''){
			$('#mem_email').val('').focus();
			alert('이메일을 입력해주세요');
			return;
		}
		
	    $.ajax({
	        type : 'get',
	        url : 'mailCheck?mem_email=' + email, // URL에 직접 이메일 주소를 추가
	        success : function (data) {
	            checkInput.attr('disabled',false);
	            code = data;
	            alert('인증번호가 전송되었습니다. 이메일을 확인해주세요.');
			},
			error:function(){
				alert('네트워크 오류 발생')
			}
	    }); // end ajax
	}); // end send email
	
	// 인증번호 비교 
	$('#mem_ckemail').keyup(function () {
	    let inputCode = $(this).val();
	    
	    if (inputCode === code) {
			$('#mail-check-warn').text('인증번호가 일치합니다.').css('color','green');
	    } else {
			$('#mail-check-warn').text('인증번호가 일치하지 않습니다.').css('color','red');
		}
    });
});