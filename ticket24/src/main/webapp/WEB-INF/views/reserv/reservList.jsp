<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 시작 -->
<div class="container">
	<h2>날짜 선택</h2>
	<hr size="1" width="100%">
	<div class="row" style="margin-top: 30px;">
		<div class="col">
			<div class="ds"></div>
		</div>
		<div class="vr vrline" style="padding-right:0;padding-left:0;"></div>
		<div class=" col">
			<div class="row date_box">
			<div style="margin-bottom: 20px;">선택 날짜 <button class="btn btn-primary" id="clear_button" style="height: 43px;">초기화</button> </div>
				<table id="date-table"style="height: 250px;">
				</table>
			</div>
			<div class="row submit_box">
			<form method="post" action="/reserv/list" style="height:250px; padding-top: 25px;border: 1px solid;">
				<p class="gray-font">평일 : <span id="weekday">0</span>일</p>
				<p class="gray-font">주말 : <span id="weekend">0</span>일</p>
				<p>합계 : <span id="result">0</span>원</p>
				<input type="hidden" name="dateArray" id="dateArray" >
				<div class="d-grid gap-2 mt-4" style="padding:0 30px 0 30px;">
					<input class="btn btn-primary" type="submit" value="신청하기">
				</div>
				
			</form>
			</div>
		</div>
	</div>
</div>
<!-- 끝 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/flatpickr.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<script type="text/javascript">
$('#reserv').addClass('active');
	flatpickr.localize(flatpickr.l10ns.ko);
	let dateSelector = document.querySelector('.ds');
	let dateArray = [];
	
	appendDate();
	function appendDate(){
	dateSelector.flatpickr({
		local : 'ko',
		mode:"multiple",
		disable:[<c:forEach var="date" items="${date}">"${date}",</c:forEach>],
		inline: true,
		dateFormat: "Y-m-d",
		minDate: new Date().fp_incr(14),
	    maxDate: new Date().fp_incr(90),
		onChange: function(selectedDates, dateStr, instance) {
			let result = 0;
			let weekendCount = 0;
			let weekdayCount = 0;
			dateArray = [];
			$('#date-table').empty();
			let df = selectedDates;
			df.sort(function(a, b) {
			    return a - b;
			});
			dateArray = df.map(function(date) {
			    let year = date.getFullYear();
			    let month = ('0' + (date.getMonth() + 1)).slice(-2);
			    let day = ('0' + date.getDate()).slice(-2);
			    let d = date.getDay();
			    return year + '-' + month + '-' + day;
			});
			dateArray2 = df.map(function(date) {
			    let year = date.getFullYear();
			    let month = ('0' + (date.getMonth() + 1)).slice(-2);
			    let day = ('0' + date.getDate()).slice(-2);
			    let d = date.getDay();
			    switch (d) {
		        case 0:
		            d = "일요일";
		            weekendCount++;
		            break;
		        case 1:
		        	 d = "월요일";
		        	 weekdayCount++;
		            break;
		        case 2:
		        	 d = "화요일";
		        	 weekdayCount++;
		            break;
		        case 3:
		        	 d = "수요일";
		        	 weekdayCount++;
		            break;
		        case 4:
		        	 d = "목요일";
		        	 weekdayCount++;
		            break;
		        case 5:
		        	 d = "금요일";
		        	 weekdayCount++;
		            break;
		        case 6:
		        	 d = "토요일";
		        	 weekendCount++;
		            break;
			    }
			    return year + '-' + month + '-' + day + ' ' + d;
			});
			output = '';
			for(let i=0;i<dateArray2.length;i++){
				output += '<tr><td>';
				output += dateArray2[i];
				output += '</td></tr>';
			}
			
			$('#result').html((weekdayCount*300000 + weekendCount*400000).toLocaleString());
			$('#weekday').html(weekdayCount);
			$('#weekend').html(weekendCount);
			$('#dateArray').val(dateArray);
			$('#date-table').append(output);
		}
	});
	}
	// 문자열을 Date 객체로 변환하는 함수
	function parseDateString(dateString) {
	  return new Date(dateString);
	}

	$("#clear_button").click(function() {
		dateSelector.flatpickr().clear();
		dateArray = '';
		dateArray2 = '';
		$('#dateArray').val(dateArray);
		$('#date-table').empty();
		appendDate();
	});
	function sumResult(){
		
	}
</script>
    