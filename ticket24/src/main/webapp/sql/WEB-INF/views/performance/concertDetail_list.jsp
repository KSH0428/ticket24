<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>콘서트 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ysw.css">
<!-- datePicker 시작 -->
<!--  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- datePicker 끝 -->
<script>
$(function() {
	//Ajax로 회차 정보 가져오기
	
    let dates = [];
    let y;
    let m;
    let d;
    
	$.ajax({
		url: 'concertRound',
		type: 'post',
		data: {concert_num:${concert.concert_num}},
		dataType: 'json',
		success:function(param){
			for(var i = 0; i < param.length; i++){
				
				dates[i] = param[i].year+'-'+param[i].month+'-'+ param[i].day;
				/*
				y = param[i].year;
				m = param[i].month;
				d = param[i].day;
				*/
			}
			
			let date1 = new Date(dates[0]);
			let date2;
			
			if(param.length == 2)
				date2 = new Date(dates[1]);
			else
				date2 = date1;
			
			
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
			        //,minDate:new Date(dates[0].year,dates[0].month-1,dates[0].day)
			 		,minDate:date1
			        ,maxDate:date2
			        //달력 달 약자
			        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			    	//달력 달
			        ,monthNames: ['01','02','03','04','05','06','07','08','09','10','11','12']
			    	//달력 요일 약자
			        ,dayNamesMin: ['일','월','화','수','목','금','토']
			    	//달력 요일
			        ,dayNames: ['일','월','화','수','목','금','토'] 
			    	//선택한 날짜 수신 예시)2024-02-01
			    	,onSelect : function(dateString){
			    		$("#date").val(dateString);
			    		console.log(dateString);
			    	}
			 
			    	//공연 날짜만 클릭할 수 있도록하기
			    	,beforeShowDay: function(date) {
			            // 선택 가능한 날짜인 경우 [true, ''] 반환
			            var formattedDate = $.datepicker.formatDate('yy-mm-dd', date);
			            if (dates.indexOf(formattedDate) !== -1) {
			              return [true, ''];
			            }
			            return [false, ''];
			          }
			     });
					
			 $("#datepicker").datepicker('setDate',new Date(dates[0]));
		},
		error:function(){
			alert('에이젝스 오류');
		}
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
	<!-- datePicker 시작 -->
	<!-- div 사용 이유 : datepicker를 처음부터 띄우기 위함 -->
	<div id="datepicker" class="calendar"></div>
	<!-- datePicker 끝 -->
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