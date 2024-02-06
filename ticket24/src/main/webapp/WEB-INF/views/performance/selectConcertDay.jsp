<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
$(function() {
	//Ajax로 공연 회차 정보 가져오기
	
    let dates = [];
	let round = [];
	let c_round_num = [];
	let last_seleted_c_round_num;
    
	$.ajax({
		url: 'concertRound',
		type: 'post',
		data: {concert_num:${concert.concert_num}},
		dataType: 'json',
		success:function(param){
			for(var i = 0; i < param.length; i++){
				dates[i] = param[i].year+'-'+param[i].month+'-'+ param[i].day;
				c_round_num[i] = param[i].c_round_num;
				round[i] = param[i].concert_time;
			}
			
			let date1 = new Date(dates[0]);
			let date2;
			
			if(param.length == 2)
				date2 = new Date(dates[1]);
			else
				date2 = date1;
			
			 $("#datepicker").datepicker({
			        dateFormat: 'yy-mm-dd' 
			        ,showOtherMonths: false
			        ,showMonthAfterYear:true 
			        ,changeYear: false 
			        ,changeMonth: false                
			        ,showOn: "both" 
			        ,buttonImageOnly: true 
			        ,buttonText: "선택"              
			        ,yearSuffix: "." 
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
			    	
			    	 ,onSelect : function(dateString){
			    		$('#datepicker').val(dateString);
			    		
			    		
			    		//날짜 선택 태그가 존재하는지 확인
				    	let existingTag = $("#selected-Date");
				    	let existingTag1 = $("#selected-round-btn");
				    	let num;
				    	
				    	//존재한다면 삭제
				    	if(existingTag.length > 0){
				    		existingTag.remove();
				    	}
				    	if(existingTag1.length > 0){
				    		existingTag1.remove();
				    	}
			    		
				    	//select-concert-round-text에 날짜 값 넣기
			    		$('#select-concert-round-text').append("<span id='selected-Date'>"+dateString+"</span>");
				    	
				    	
				    	//해당 날짜의 인덱스 구하기
				    	//먼저 1회차 2회차 날짜가 같은지 비교
				    	var count = 0;
				    	for(var i = 0; i < dates.length; i++){
				    		if(dates[i] == dateString){
								count++;
								num = i;
			 				}
				    	}

				    	if(count == 2){
				    		//ID : concert-time-item에 태그 추가
	    					$('#selected-round-list').append("<button id='selected-round-btn'><span></span></button>");
	    					//span 태그에 날짜 입력
	    					$('#selected-round-btn span').append(round[0]);
	    					$('#selected-round-list').append("<button id='selected-round-btn2'><span></span></button>");
	    					$('#selected-round-btn2 span').append(round[1]);
				    	} else {
				    		//ID : concert-time-item에 태그 추가
	    					$('#selected-round-list').append("<button id='selected-round-btn'><span></span></button>");
	    					//span 태그에 날짜 입력
	    					$('#selected-round-btn span').append(round[num]);
				    	}
				    		
				    }
			     });
					
		},
		error:function(){
			alert('통신 오류');
		}
	});
	
	//달의 마지막 날을 읽어온다.
	function getLastDayOfMonth(year, month) {
 		//month는 0부터 시작하므로, 1을 더해줌
  		const lastDay = new Date(year, month + 1, 0).getDate();
  		return lastDay;
	}
	
	//회차 날짜 번호 클릭 이벤트
	$(document).on('click', '#selected-round-btn', function() {
		//CSS 테두리 색깔 변경
		$('#selected-round-btn').css({
		    'border': 'none',
		   	'background-color' : '#FA5858',
		   	'color' : 'white'
		});
		$('#selected-round-btn2').css({
		    'border-color': '#dcdde1',
		    'background-color' : '#F0F0F0',
		    'color' : 'black'
		});
		
		let num ;
		let count = 0;
		for(var i=0; i<dates.length; i++){
			if(dates[i] == $('#datepicker').val()){
				num = i;
				count++;
			}
		}
		
		if(count == 2) num = 0;
		
		$('#seatsNum').text('');
		$('#seatsNum').text(getRemainingSeats(c_round_num[num]));
		
		
		/* 버튼 활성화 */
		/*
		$('#reserve-btn').css({
			'border' : '1px solid #fa2828',
		    "background-color" : '#fa2828'
		});
		$('#reserve-btn').prop("disabled", false);
		*/
		//현재 콘서트 회차 번호 갱신
		last_seleted_c_round_num = c_round_num[num];
	});
	
	$(document).on('click', '#selected-round-btn2', function() {
		//CSS 테두리 색깔 변경
		$('#selected-round-btn2').css({
		    'border': 'none',
		   	'background-color' : '#FA5858',
		   	'color' : 'white'
		});
		$('#selected-round-btn').css({
		    'border-color': '#dcdde1',
		    'background-color' : '#F0F0F0',
		    'color' : 'black'
		});
		
		$('#seatsNum').text('');
		$('#seatsNum').text(getRemainingSeats(c_round_num[1]));
		
		
		/* 버튼 활성화 */
		/*
		$('#reserve-btn').css({
			'border' : '1px solid #fa2828',
		    "background-color" : '#fa2828'
		});
		$('#reserve-btn').prop("disabled", false);
		*/
		//현재 콘서트 회차 번호 갱신
		last_seleted_c_round_num = c_round_num[num];
	});
	
	//공연 회차 좌석 정보 얻어오기
	function getRemainingSeats(num){
		
		let result_seat;
		$.ajax({
			url: 'concertRemainingSeats',
			type: 'post',
			data: {c_round_num:num},
			//return 값을 이용하기 위해선 ajax를 비동기로 바꿔야 한다.
			async: false,
			dataType: 'json',
			success:function(param){
				result_seat = param;
			},
			error:function(){
				alert('통신 오류');
			}
		});
		
		return result_seat;
	}
	
	//클릭 이벤트 강제 발생
	//예전에 클릭한 회차 정보를 얻어와서 팝업창에서 유지하도록 한다.
	
	// 특정 날짜 클릭 이벤트
    $("#selectDateBtn").click(function(){
        var targetDate = ${round.year} + "-" + ${round.month} + "-" + ${round.day};
        //$("#datepicker").datepicker("setDate", targetDate);
        $("#datepicker").datepicker("setDate", "2024-02-28").get(0).click();
    });
	
	//강제 이벤트
	 $("td:contains('" + ${round.day} + "')").click(function() {
            alert("클릭된 요소의 텍스트는: " + $(this).text());
            // 클릭된 요소에 대한 추가적인 처리를 여기에 작성할 수 있습니다.
        });
    $("#selectDateBtn").get(0).click();
});

</script>

<!-- datepicker 영역 -->
<div class="select-concert-datepicker-container">
	<div class="select-concert-datepicker-container-header">관람일 선택</div>
	<div id="datepicker" class="calendar"></div>
</div>
<!-- 회차 선택 -->
<div class="select-concert-round-container">
	<div class="select-concert-round-container-header">회차선택</div>
	<div style="padding: 30px 20px;">
		<div id="select-concert-round-text" style="margin-bottom: 30px;">
			<span class="select-concert-round-info">선택날짜</span>
			<!-- 선택한 날짜를 화면에 표시 -->
			<!-- <span id="selected-Date"></span> -->
		</div>
		<div class="selected-round-container">
			<div class="select-concert-round-info">회차선택</div>
			<ul id="selected-round-list">
				<!-- 해당 회차 추가 -->
			</ul>
		</div>
		<div class="selected-remaining-seats">
			<div class="select-concert-round-info">잔여석</div>
			<ul id="selected-remaining-seats-list">
				<span id="seatsNum"></span>
			</ul>
		</div>
	</div>
</div>
<!-- 유의사항 -->
<div class="note-container">
	유의사항(후순위)
	<button id="selectDateBtn">Select Specific Date</button>
</div>