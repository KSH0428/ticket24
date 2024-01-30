<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 시작 -->
<div class="container">
	<h2>날짜 선택</h2>
	<div class="row" style="margin-top: 30px;">
		<div class="col">
			<div class="ds"></div>
		</div>
		<div class=" col">
			<div class="row date_box">
			<div style="margin-bottom: 20px;">선택 날짜</div>
			<hr size="1" width="100%">
				<table id="date-table"style="height: 250px;">
				</table>
			</div>
			<div class="row submit_box">
			<form method="post" action="/reserv/list" style="height:250px; padding-top: 70px;">
				<p>합계 : 0원</p>
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
	var dateSelector = document.querySelector('.ds');
	let dateArray = [];
	dateSelector.flatpickr({
		local : 'ko',
		mode:"multiple",
		disable:[<c:forEach var="date" items="${date}">"${date}",</c:forEach>],
		inline: true,
		dateFormat: "Y-m-d",
		onChange: function(selectedDates, dateStr, instance) {
			dateArray = [];
			$('#date-table').empty();
			let df = selectedDates;
			df.sort(function(a, b) {
			    return a - b;
			});
			dateArray = df.map(function(date) {
			    var year = date.getFullYear();
			    var month = ('0' + (date.getMonth() + 1)).slice(-2);
			    var day = ('0' + date.getDate()).slice(-2);
			    return year + '-' + month + '-' + day;
			});
			output = '';
			for(let i=0;i<dateArray.length;i++){
				output += '<tr><td>';
				output += dateArray[i];
				output += '</td></tr>';
			}
			$('#dateArray').val(dateArray);
			$('#date-table').append(output);
		}
	});
	// 문자열을 Date 객체로 변환하는 함수
	function parseDateString(dateString) {
	  return new Date(dateString);
	}
	
</script>
    