<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
$(function() {
	$(document).on('click', '#btn-next-step1', function() {
		/* button 처리 */
		$('#step1, #btn-step1').css({
			'display':'none'
		});
		$('#step2, #btn-step2').css({
			'display':'block'
		});
		/* header 처리 */
		$('#header-menu-step1').css({
			'background-color' : '#bebebe'
		});
		$('#concert-header-menu-step1-01').css({
			'color' : '#dcdcdc'
		});
		$('#concert-header-menu-step1-02').css({
			'color' : 'white'
		});
		$('#header-menu-step2').css({
			'background-color' : 'white'
		});
		$('#concert-header-menu-step2-01').css({
			'color' : '#32AAFF'
		});
		$('#concert-header-menu-step2-02').css({
			'color' : 'black'
		});
	});
	$(document).on('click', '#btn-prev-step2', function() {
		/* button 처리 */
		$('#step2, #btn-step2').css({
			'display':'none'
		});
		$('#step1, #btn-step1').css({
			'display':'block'
		});
		/* header 처리 */
		$('#header-menu-step2').css({
			'background-color' : '#bebebe'
		});
		$('#concert-header-menu-step2-01').css({
			'color' : '#dcdcdc'
		});
		$('#concert-header-menu-step2-02').css({
			'color' : 'white'
		});
		$('#header-menu-step1').css({
			'background-color' : 'white'
		});
		$('#concert-header-menu-step1-01').css({
			'color' : '#32AAFF'
		});
		$('#concert-header-menu-step1-02').css({
			'color' : 'black'
		});
	});
	$(document).on('click', '#btn-next-step2', function() {
		/* button 처리 */
		$('#step2, #btn-step2').css({
			'display':'none'
		});
		$('#step3, #btn-step3').css({
			'display':'block'
		});
		/* header 처리 */
		$('#header-menu-step2').css({
			'background-color' : '#aaaaaa'
		});
		$('#concert-header-menu-step2-01').css({
			'color' : '#d2d2d2'
		});
		$('#concert-header-menu-step2-02').css({
			'color' : 'white'
		});
		$('#header-menu-step3').css({
			'background-color' : 'white'
		});
		$('#concert-header-menu-step3-01').css({
			'color' : '#32AAFF'
		});
		$('#concert-header-menu-step3-02').css({
			'color' : 'black'
		});
	});
	$(document).on('click', '#btn-prev-step3', function() {
		/* button 처리 */
		$('#step3, #btn-step3').css({
			'display':'none'
		});
		$('#step2, #btn-step2').css({
			'display':'block'
		});
		/* header 처리 */
		$('#header-menu-step3').css({
			'background-color' : '#bebebe'
		});
		$('#concert-header-menu-step3-01').css({
			'color' : '#dcdcdc'
		});
		$('#concert-header-menu-step3-02').css({
			'color' : 'white'
		});
		$('#header-menu-step2').css({
			'background-color' : 'white'
		});
		$('#concert-header-menu-step2-01').css({
			'color' : '#32AAFF'
		});
		$('#concert-header-menu-step2-02').css({
			'color' : 'black'
		});
	});
});
/* 결제 시작 */
var IMP = window.IMP;
IMP.init('imp06364606');
function requestPay() {
	
	//결제시작
	IMP.request_pay({
      pg: "html5_inicis",
      pay_method: 'card',
      merchant_uid: 'ticket_hall'+new Date().getTime(),   // 주문번호
      name: "TICKET24 아트센터",
      amount: 100,                         // 숫자 타입
      /* buyer_email: $('#reservation_email').val(),
      buyer_name: $('#reservation_name').val(),
      buyer_tel: $('#reservation_phone').val(), */
    }, function (rsp) { // callback
    	 if (rsp.success) {
    		 paymentVerify(rsp);
   		} else {
   		      var msg = '결제에 실패하였습니다.';
   		      msg += '에러내용 : ' + rsp.error_msg;
   		      alert(msg);
   		}
    });
    //결제완료
 }
 function paymentVerify(rsp){
	 $.ajax({
         type: 'POST',
         url: '/verify/' + rsp.imp_uid
      }).done(function(data) {
          if(rsp.paid_amount === data.response.amount){
              alert('결제 성공')
          } else {
              alert("결제 실패");
          }
      });
 }
 /* function payment(rsp){
	$.ajax({
		url:'../reserv/updatePayment',
		type:'post',
		data:{reservation_num:1,payment_name:rsp.buyer_name,payment_phone:rsp.buyer_tel,payment_email:rsp.buyer_email,payment_method:rsp.pay_method,merchant_uid:rsp.merchant_uid,imp_uid:rsp.imp_uid,paid_at:rsp.paid_at},
		dataType:'json',
		success:function(param){
			if(param.result=='success'){
				 var msg = '결제가 완료되었습니다.';
	   		     alert(msg);
	   		     location.href = 'reservDetail?reservation_num=${payment.reservation_num}'
			}else{
				alert('결제 오류 : 문의처에 문의해주세요.');
			}
		},
		error:function(){
			alert('결제 오류 : 문의처에 문의해주세요.');
		}
	});
 } */
/* 결제 끝 */
</script>

<div class="reserve-state-container">
	<!-- 상품 정보 -->
	<div class="reserve-state-header">
		<p class="header-img-container">
			<img src="${concert.img_poster}">
		</p>
		<span class="header-img-container-title">
			<span>${concert.concert_title}</span>
		</span>
		<span class="header-img-container-date">
			<span>${concert.period}</span>
		</span>
		<span class="header-img-container-hall">
			<span>${concert.concert_hall}</span>
		</span>
	</div>
	<!-- 구분선 -->
	<div class="dividing-line"></div>
	<div class="reserve-state-body">
		<h3>선택 내역</h3>
		<ul>
			<li>
				<span class="reserve-state-body-text">날짜</span>
				<span id="reserve-state-selected-date" class="reserve-state-body-text2">${round.year}-${round.month}-${round.day}</span>
			</li>
			<li>
				<span class="reserve-state-body-text">시간</span>
				<span id="reserve-state-selected-time" class="reserve-state-body-text2">${round.concert_time}</span>
				<button style="display:none;" id="lastRoundNum" value=""></button>
			</li>
			<li>
				<span class="reserve-state-body-text">남은 좌석</span>
				<span id="reserve-state-remainging-seats" class="reserve-state-body-text2">${round.total_seat}석</span>
			</li>
			<li>
				<span class="reserve-state-body-text">선택 매수</span>
				<span id="reserve-state-selected-tickets" class="reserve-state-body-text2">0 매</span>
			</li>
			<li>
				<span class="reserve-state-body-text">선택 좌석</span>
				<span id="reserve-state-selected-tickets-detail" class="reserve-state-body-text2"></span>
			</li>
		</ul>
	</div>
	
	<!-- 구분선 -->
	<div class="dividing-line"></div>
	<div class="reserve-state-payment">
		<h3>결제내역</h3>
		<ul>
	<!-- 		<li>
				<span class="reserve-state-ticket-payment-text">금액</span>
				<span class="reserve-state-selected-ticket-price">0</span>				
			</li> -->
			<li>
				<span class="reserve-state-ticket-payment-text">총 금액</span>
				<span id="reserve-state-total-price" class="reserve-state-selected-ticket-price">0</span>				
			</li>
		</ul>
		
		<!-- 점선 -->
		<div class="dividing-dotted-line"></div>
		<div class="reserve-state-payment2">
			<ul>
				<li>
					<span class="reserve-state-ticket-payment-text">할인금액</span>
					<span class="reserve-state-selected-ticket-price">0</span>
				</li>
			</ul>
		</div>
	</div>
	
	<span class="total-payment">
		<span style="margin-left:5px; float:left">최종결제금액</span>
		<span id="total-payment-number"></span>
		<span class="total-payment-text">원</span>
	</span>
	<div id="btn-step1" class="button-area">
		<button id="btn-next-step1">다음 단계</button>
	</div>
	<div id="btn-step2" class="button-area" style="display:none;">
		<button id="btn-prev-step2">이전 단계</button>
		<button id="btn-next-step2">다음 단계</button>
	</div>
	<div id="btn-step3" class="button-area" style="display:none;">
		<button id="btn-prev-step3">이전 단계</button>
		<button id="btn-next-step3" onclick="requestPay()">결제하기</button>
	</div>
</div>
	