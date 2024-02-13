$(function(){
	/*----------------------------------------
	* 장바구니 등록
	*----------------------------------------*/	
		$('#output_cart').click(function(){
			$.ajax({
			url:'/mdCart/addCart',
			type:'post',
			data:{md_cart_num:$('#output_cart').attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'success'){
					alert('상품을 장바구니에 담았습니다. \n 바로 확인하시겠습니까?');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
	});
	
	
});









