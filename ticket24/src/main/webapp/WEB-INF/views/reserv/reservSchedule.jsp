<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 대관일정 시작 -->
<div>
	<h2>대관일정</h2>
	<hr width="100%">
	 <div id='calendar'></div>
</div>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>
<script>
$('#reservSchedule').addClass('active');
document.addEventListener('DOMContentLoaded', function () {
       $(function () {
           var request = $.ajax({
               url: "../calendar-admin", // 변경하기
               method: "GET",
               dataType: "json"
           });

           request.done(function (data) {
               console.log(data); // log 로 데이터 찍어주기.
               var calendarEl = document.getElementById('calendar');

         	  var calendar = new FullCalendar.Calendar(calendarEl, {
	       		locale: "ko",
	       		timeZone: 'UTC',
	       	    initialView: 'dayGridMonth',
	       	    events: '/api/demo-feeds/events.json',
	       	    editable: true,
	       	    selectable: true,
	            events: data
               });

               calendar.render();
           });

           request.fail(function( jqXHR, textStatus ) {
               alert( "Request failed: " + textStatus );
           });
       });

}); 

</script>
<!-- 대관일정 끝 -->
    
    