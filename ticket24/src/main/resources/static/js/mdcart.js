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
	
	/*---------------------
	 * 장바구니 표시 공통 함수
     *---------------------*/
	/*function displayCart(param){
		let output;
		if(param.status == 'yesFav'){
			output = '../images/fav02.gif';
		}else if(param.status == 'noFav'){
			output = '../images/fav01.gif';
		}else{
			alert('좋아요 표시 오류 발생');
		}
		//문서 객체에 추가
		$('#output_fav').attr('src',output);
		$('#output_fcount').text(param.count);
	}*/
	
	/*//초기 데이터 표시
	selectCart($('#output_cart').attr('data-num'));*/
});









