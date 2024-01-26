$(function(){
	/*----------------------------
	*			회원탈퇴
	*----------------------------*/
	$('#withdrawbtn').click(function(){
		let choice = confirm('정말 회원탈퇴하시겠습니까?');
		if(choice){
			location.href='${pageContext.request.contextPath}/main/main';
		}
	});
	$('#withdrawbtn').click(function(){
		if($('#mem_ckpasswd').val().trim()==''){
			$('#mem_ckpasswd').val('').focus();
			alert('비밀번호를 입력하세요');
			return; //submit이면 return false, click은 return
		}
	});
});