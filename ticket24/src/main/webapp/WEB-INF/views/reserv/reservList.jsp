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
			<div style="margin-bottom: 20px;">선택 날짜 <button id="clear_button">초기화</button> </div>
				<table id="date-table"style="height: 250px;">
				</table>
			</div>
			<div class="row submit_box">
			<form method="post" action="/reserv/list" style="color:white;height:250px; padding-top: 70px;border-radius: 30px;background-color: gray;">
				<p>합계 : <span id="result"></span>원</p>
				<input type="hidden" name="dateArray" id="dateArray" >
				<input class="btn btn-secondary btn-lg" type="submit" value="신청">
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
		onChange: function(selectedDates, dateStr, instance) {
			let result = 0;
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
		            result += 400000;
		            break;
		        case 1:
		        	 d = "월요일";
		        	 result += 300000;
		            break;
		        case 2:
		        	 d = "화요일";
		        	 result += 300000;
		            break;
		        case 3:
		        	 d = "수요일";
		        	 result += 300000;
		            break;
		        case 4:
		        	 d = "목요일";
		        	 result += 300000;
		            break;
		        case 5:
		        	 d = "금요일";
		        	 result += 300000;
		            break;
		        case 6:
		        	 d = "토요일";
		        	 result += 400000;
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
			
			$('#result').html(result.toLocaleString());
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
    