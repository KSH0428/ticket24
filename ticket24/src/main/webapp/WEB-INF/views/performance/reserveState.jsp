<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<span class="reserve-state-body-text2">${round.year}-${round.month}-${round.day}</span>
			</li>
			<li>
				<span class="reserve-state-body-text">시간</span>
				<span class="reserve-state-body-text2">${round.concert_time}</span>
			</li>
			<li>
				<span class="reserve-state-body-text">남은 좌석</span>
				<span class="reserve-state-body-text2">${round.total_seat}석</span>
			</li>
		</ul>
	</div>
	
	<!-- 구분선 -->
	<div class="dividing-line"></div>
</div>