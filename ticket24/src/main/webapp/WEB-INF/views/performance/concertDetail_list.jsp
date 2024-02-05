<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콘서트 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ysw.css">
<!-- css 파일 무시 -->
<script type="text/javascript">
	//document.querySelector('link[href="${pageContext.request.contextPath}/css/ysw.css"]').remove();
</script>
<!-- datePicker 시작 -->
<!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- datePicker 끝 -->
<script>
$(function() {

	
	//Ajax로 공연 회차 정보 가져오기
	
    let dates = [];
	let round = [];
    
	$.ajax({
		url: 'concertRound',
		type: 'post',
		data: {concert_num:${concert.concert_num}},
		dataType: 'json',
		success:function(param){
			for(var i = 0; i < param.length; i++){
				dates[i] = param[i].year+'-'+param[i].month+'-'+ param[i].day;
				
				round[i] = param[i].concert_time;
			}
			
			let date1 = new Date(dates[0]);
			let date2;
			
			if(param.length == 2)
				date2 = new Date(dates[1]);
			else
				date2 = date1;
			console.log(new Date(date1.getYear(),date1.getMonth(),1));
			
			 $("#datepicker").datepicker({
			        dateFormat: 'yy-mm-dd' //달력 날짜 형태
			        ,showOtherMonths: false //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			        ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
			        ,changeYear: false //option값 년 선택 가능
			        ,changeMonth: false //option값  월 선택 가능                
			        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			        ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
			        ,buttonText: "선택" //버튼 호버 텍스트              
			        ,yearSuffix: "." //달력의 년도 부분 뒤 텍스트
			        /*
			 		,minDate:date1
			        ,maxDate:date2
			        */
			        //getYear()하면 잘못된 년도가 들어가서 일단 2024년 적음
			 		,minDate:new Date('2024',date1.getMonth(),'1')
			        ,maxDate:new Date('2024',date2.getMonth(),getLastDayOfMonth(date2.getYear(),date2.getMonth()))
			        //달력 달 약자
			        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			    	//달력 달
			        ,monthNames: ['01','02','03','04','05','06','07','08','09','10','11','12']
			    	//달력 요일 약자
			        ,dayNamesMin: ['일','월','화','수','목','금','토']
			    	//달력 요일
			        ,dayNames: ['일','월','화','수','목','금','토'] 
					
			 
			 
			    	//공연 날짜만 클릭할 수 있도록하기
			    	,beforeShowDay: function(date) {
			            // 선택 가능한 날짜인 경우 [true, ''] 반환
			            var formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
			            if (dates.indexOf(formattedDate) !== -1) {
			              return [true, ''];
			            }
			            return [false, ''];
			          }
			    	
			    	 ,onSelect : function(dateString, inst){
			    		 
				    		//해당 날짜의 인덱스 구하기
				    		var num = dates.indexOf(dateString);
				    		
				    		//날짜 선택 태그가 존재하는지 확인
				    		var existingTag = $("#concert-time-btn");
				    		
				    		//존재한다면 삭제한다
				    		if(existingTag.length > 0){
				    			existingTag.remove();
				    		}
				    		//ID : concert-time-item에 태그 추가
				    		$('#concert-time-item').append("<button id='concert-time-btn'><span class='time-box'></span></button>");
				    		//span 태그에 날짜 입력
				    		$('#concert-time-item span').append(round[num]);
				    		
				    		/*
				    		//해당 날짜의 회차 정보 수신하기
				    		for(var i = 0; i < dates.length; i++){
				    			if(dates[i] == dateString){
				    				alert(round[i]);
				    			}
				    		}*/
				    	}
			     });
					
		},
		error:function(){
			alert('에이젝스 오류');
		}
	});
	
	//달의 마지막 날을 읽어온다.
	function getLastDayOfMonth(year, month) {
 		//month는 0부터 시작하므로, 1을 더해줌
  		const lastDay = new Date(year, month + 1, 0).getDate();
  		return lastDay;
	}
	
	//회차 날짜 번호 클릭 이벤트
	$(document).on('click', '#concert-time-btn', function() {
		//CSS 테두리 색깔 변경
		$('#concert-time-btn').css({
		    'border-color': '#242428'
		});
	});

	
});


</script>
</head>
<body>
<div class="common-container">
	<div class="detail-container">
		<div class="img-container">
			<img width= 100%; height=100% src="${concert.img_poster}">
		</div>
		<div class="info-container">
			<c:if test="${concert.monopoly eq '단독'}">
			<div style="margin-bottom: 17px;">
				<span class="concert-monopoly">${concert.monopoly}</span>
			</div>
			</c:if>
			<div class="concert-title">
				<h1 class="concert-title-content">${concert.concert_title}</h1>
			</div>
			<div class="concert-info">
				<ul class="concert-info-l1" style="list-style: none">
					<li class="info">
						<span>장소</span>
						<div>${concert.concert_hall}</div>
					</li>
					<li class="info">
						<span>관람시간</span>
						<div>${concert.viewing_time}</div>
					</li>
					<li class="info">
						<span>공연기간</span>
						<div>${concert.period}</div>
					</li>
					<li class="info">
						<span>관람등급</span>
						<div>${concert.grade}</div>
					</li>
					<li class="info2">
						<span>출연진</span>
						<div>${concert.casting}</div>
					</li>
					<li class="info2">
						<span>공연 회차</span>
						<div>${concert.c_round_1}</div>
			
					</li>
					<c:if test="${concert.c_round_2!='null'}">
					<li class="info2">
						<span></span>
						<div>${concert.c_round_2}</div>
					</li>
					</c:if>
				</ul>
			</div>
			<div class="concert-price-info">
				<div>가격 미정</div>
			</div>
		</div>
	</div>
	
	<!-- 공연 예약 부분 -->
	<div class="concert-reserve-container">
		<div class="reserve-border">
			<div class="datepicker-container">
				<h3 class="date-header">
					<span class="reserve-step1">날짜선택</span>
				</h3>
				
				<!-- datePicker 시작 -->
				<!-- div 사용 이유 : datepicker를 처음부터 띄우기 위함 -->
				<div id="datepicker" class="calendar"></div>
				<!-- datePicker 끝 -->
			
			</div>
			<div class="reserveTime-container">
				<h3 class="date-header">
					<span class="reserve-step1">회차선택</span>
				</h3>
				<ul class="concert-time-list">
					<li id="concert-time-item"></li>
				</ul>
			</div>
			<div class="reserve-seat-info">
				<h3 class="date-header">
					<span class="reserve-step1">남은좌석</span>
				</h3>
			</div>
		</div>
	</div>
	
	<!-- sticky -->
	&nbsp;
	&nbsp;
	&nbsp;
	&nbsp;
	<!-- 공연 상세 이미지 -->
	<div class="concert-detail-img">
		<c:if test="${concert.image_1!='null'}">
		<div><img src="${concert.image_1}"></div>
		</c:if>
		<c:if test="${concert.image_2!='null'}">
		<div><img src="${concert.image_2}"></div>
		</c:if>
		<c:if test="${concert.image_3!='null'}">
		<div><img src="${concert.image_3}"></div>
		</c:if>
		<c:if test="${concert.image_4!='null'}">
		<div><img src="${concert.image_4}"></div>
		</c:if>
		<c:if test="${concert.image_5!='null'}">
		<div><img src="${concert.image_5}"></div>
		</c:if>
		<c:if test="${concert.image_6!='null'}">
		<div><img src="${concert.image_6}"></div>
		</c:if>
		<c:if test="${concert.image_7!='null'}">
		<div><img src="${concert.image_7}"></div>
		</c:if>
	</div>
</div>


</body>
</html>