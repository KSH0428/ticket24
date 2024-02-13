<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script>
let last_seleted_c_round_num;
$(function() {
	//Ajax로 공연 회차 정보 가져오기
	
    let dates = [];
	let round = [];
	let c_round_num = [];
	
    
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
			        ,buttonImageOnly: false
			        ,buttonText: "선택"              
			        ,yearSuffix: "." 
			        //getYear()하면 잘못된 년도가 들어가서 일단 2024년 적음
			 		,minDate:new Date('2024',date1.getMonth(),'1')
			        ,maxDate:new Date('2024',date2.getMonth(),getLastDayOfMonth(date2.getYear(),date2.getMonth()))
			 		//설정한 값으로 기본 날짜를 선택
			 		,defaultDate: ${round.year} + "-" + ${round.month} + "-" + ${round.day}
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
			    		
			         //날짜 선택하면 발생하는 이벤트
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
				    		
				    	/* onselect 끝 */
				    }
			    	 
			    	 
			     });
			 
			 //datepicker가 로드 된 후 해당 버튼을 클릭
			 //기본 셋팅을 해준다.
			 $('#selectDateBtn').click();
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
		
		if(count == 2) {
			/* alert("같은 날짜"); */
			num = 0;
		}
		
		$('#seatsNum').text('');
		$('#seatsNum').text(getRemainingSeats(c_round_num[num]));
		
		//상태창에 갱신된 정보 반영하기
		//날짜
		$("#reserve-state-selected-date").text($("#selected-Date").text());
		//시간
		$("#reserve-state-selected-time").text($("#selected-round-btn").text());
		//좌석수
    	$("#reserve-state-remainging-seats").text($("#seatsNum").text());
		
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
		
		//회차 번호 저장하기
		$('#lastRoundNum').val(last_seleted_c_round_num);
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
		
		
		//상태창에 갱신된 정보 반영하기
		//날짜
		$("#reserve-state-selected-date").text($("#selected-Date").text());
		//시간
		$("#reserve-state-selected-time").text($("#selected-round-btn2").text());
		//좌석수
    	$("#reserve-state-remainging-seats").text($("#seatsNum").text());
		
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
		
		//회차 번호 저장하기
		$('#lastRoundNum').val(last_seleted_c_round_num);
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
	
	//예전에 클릭한 회차 정보를 얻어와서 팝업창에서 유지하도록 한다.
	// 특정 날짜 클릭 이벤트
    $("#selectDateBtn").on('click',function(){
    	
    	const str = "${round.concert_time}";
        //활성화된 datepicker의 날짜를 클릭
        $(".ui-state-active").click();
        //선택된 회차를
        if($("#selected-round-btn span").text() == str){
        	$("#selected-round-btn").click();      	
        }else if($("#selected-round-btn2 span").text() == str){
        	$("#selected-round-btn2").click();
        }
        //step2의 좌석함수 갱신된 회차 정보를 쓰기 위해서
        createSeats(6, 10);
    });
	
});




</script>

<!-- 관람일/회차 선택 -->
<div id="step1">
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
		<div class="note-container-header">유의사항</div>
		<div class="note-container-content">
			<ul style="list-style:none;">
				<li>- 안내되어 있는 잔여석은 결제 진행 중인 좌석을 포함하고 있어 예매 가능 좌석과 다를 수 있습니다.</li>
				<li>- 할인은 자동선택 되지 않으니, <u>적용 받고자 하는 할인이 있는 경우 직접 선택</u>해주시기 바랍니다.</li>
				<li>- 예매 취소 시  <u>예매수수료는 예매 당일 밤 12시 이전까지 환불되며, 그 이후 기간에는 환불되지 않습니다.</u></li>
				<li>- 예매 취소 시점에 따라 취소수수료가 부과될 수 있습니다. 예매 후 취소마감시간과 함께 취소수수료를 꼭 확인해주시기 바랍니다.</li>
				<li>- 1인당 <u>최대 2매</u> 예매 가능합니다.</li>
			</ul>
		</div>
		<button style="display:none;" id="selectDateBtn">업로드 버튼</button>
	</div>
	
	
</div>

<!-- =========================================================================== -->
<!-- step2 좌석 선택 -->

<script>


let seat_count = 0;
//좌석을 만드는 함수
function createSeats(rows, cols) {
  var seatLayout = $("#seatLayout");
  /* alert(last_seleted_c_round_num); */
  
  //좌석 예약 정보를 배열로 받는다.
  let seatArray;
  
  $.ajax({
  		url: 'concertSeatListInfo',
  		type: 'post',
  		//return 값을 이용하기 위해선 ajax를 비동기로 바꿔야 한다.
		async: false,
		dataType: 'json',
  		data: {
  			concert_num:${concert.concert_num},
  			c_round_num:last_seleted_c_round_num
  		},
  		success:function(param){
  			seatArray= param;
  		},
  		error:function(){
			alert('통신 오류!!');
		}
	  });
  
  for (var i = 0; i < rows; i++) {
	  for (var j = 0; j < cols; j++) {
    	let seat;
    	if(j==0){
    		seat = $("<div>").addClass("rowOfSeats").append(i+1);
    		//seat = $("<div>").addClass("rowOfSeats");
    		seatLayout.append(seat);
    	}
    	
    	if(i<2){
    		if(j<3-i||j>6+i){
    			//공간을 차지하지만, 실제론 안보여지는 빈 좌석이다.
    			//seat = $("<div>").addClass("seat").addClass("seat-empty");
    			seat = $("<div>").addClass("seat seat-empty");
    		}else{
    			//seat = $("<div>").addClass("seat").attr('id', 'seat' + (++seat_count));
    			if(seatArray[seat_count++].status==0)
    				seat = $("<div>").addClass("seat seat-available").attr('id', 'seat' + (seat_count)).append(seat_count);
    			else
    				seat = $("<div>").addClass("seat seat-occupied").attr('id', 'seat' + (seat_count));
    		}
    	}else{
    		//seat = $("<div>").addClass("seat").attr('id', 'seat' + (++seat_count));
    		if(seatArray[seat_count++].status==0)
				seat = $("<div>").addClass("seat seat-available").attr('id', 'seat' + (seat_count)).append(seat_count);
			else
				seat = $("<div>").addClass("seat seat-occupied").attr('id', 'seat' + (seat_count));
    	}
      seatLayout.append(seat);
      
      $('.seat-occupied').css({
          "background-color": "#828282"
      });
      
     }
	 
	 seat = $("<div>").addClass("rowOfSeats").append(i+1);
		 seatLayout.append(seat)
     seatLayout.append("<br>"); // 줄바꿈
  }
}
//좌석 함수 끝



</script>
<div id="step2" style="display:none;">
	<div class="reserve-seats-conatiner">
		<div class="reserve-seats-header">
			STAGE
		</div>
		<div id="seatLayout"></div>
	</div>
</div>
<script>
	//카운트를 위한 클로저 생성
	let count=0;
	
	{
		let x = 0;
		count = function(y) { // globalFunc 함수는 클로저다.
		    return x = x + y;
		  }
	}
	
	//좌석을 클릭했을 경우(동적 이벤트) seat-empty는 제외
	$(document).on('click', '.seat-available', function(){
		//한 번 체크된 상태라면
		if ($(this).hasClass("checked")) {
			$(this).removeClass("checked");
			let inValue = $(this).attr("id");
			//id를 추출 후 아이디 넣음
			let seat_num = inValue.substring(4);
			$(this).text(seat_num);

			
			//테두리 효과 없앰
			$(this).css({
				'border' : 'none',
				'margin' : '10px'
			});
			count(-1);
			
			if($('.reserve-state-selected-tickets-detail-1').text() == seat_num){
				$('.reserve-state-selected-tickets-detail-1').remove();
			}else if($('.reserve-state-selected-tickets-detail-2').text() == seat_num){
				$('.reserve-state-selected-tickets-detail-2').remove();
			}

		}else {
			//처음 선택하는 경우
			//최대 매수는 2장
			if(count(0)==2){
				alert('최대 매수는 2장입니다.');
			}else {
				//텍스트 지우고 체크 표시
				$(this).text("").addClass("checked");
				$(this).css({
					'border' : '2px solid',
					'border-color' : 'black',
					//인근 요소들에 영향을 끼치지 않기 위해 기존 10에서 9로 낮춤
					'margin' : '8px'
				});
				count(1);
				
				if($('#reserve-state-selected-tickets-detail span').hasClass("reserve-state-selected-tickets-detail-1")) {
					$('#reserve-state-selected-tickets-detail').append("<span class='reserve-state-selected-tickets-detail-2'>"+$(this).attr("id").substring(4)+"</span>");
				}else {
					$('#reserve-state-selected-tickets-detail').append("<span class='reserve-state-selected-tickets-detail-1'>"+$(this).attr("id").substring(4)+"</span>");
				}
			}
		}
		/* console.log(count(0)); */
		//상태창에 선택 좌석 수, 좌석 정보 추가
		$('#reserve-state-selected-tickets').text(count(0) + ' 매');
		
		
		
	});

</script>

<!-- =========================================================================== -->
<!-- step3 가격/할인 -->
<div id="step3" style="display:none;">
</div>