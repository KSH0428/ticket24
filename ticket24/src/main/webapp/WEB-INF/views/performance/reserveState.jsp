<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function() {
	$(document).on('click', '#btn-next-step1', function() {
		$('#step1, #btn-step1').css({
			'display':'none'
		});
		$('#step2, #btn-step2').css({
			'display':'block'
		});
	});
	$(document).on('click', '#btn-prev-step2', function() {
		$('#step2, #btn-step2').css({
			'display':'none'
		});
		$('#step1, #btn-step1').css({
			'display':'block'
		});
	});
});
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
			</li>
			<li>
				<span class="reserve-state-body-text">남은 좌석</span>
				<span id="reserve-state-remainging-seats" class="reserve-state-body-text2">${round.total_seat}석</span>
			</li>
		</ul>
	</div>
	
	<!-- 구분선 -->
	<div class="dividing-line"></div>
	<div class="reserve-state-payment">
		<h3>결제내역</h3>
		<ul>
			<li>
				<span class="reserve-state-ticket-payment-text">금액</span>
				<span class="reserve-state-selected-ticket-price">0</span>				
			</li>
			<li>
				<span class="reserve-state-ticket-payment-text">총 금액</span>
				<span class="reserve-state-selected-ticket-price">0</span>				
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
		<span id="total-payment-number">10000</span>
		<span class="total-payment-text">원</span>
	</span>
	<div id="btn-step1" class="button-area">
		<button id="btn-next-step1">다음 단계</button>
	</div>
	<div id="btn-step2" class="button-area" style="display:none;">
		<button id="btn-prev-step2">이전 단계</button>
		<button id="btn-next-step2">다음 단계</button>
	</div>
</div>
	