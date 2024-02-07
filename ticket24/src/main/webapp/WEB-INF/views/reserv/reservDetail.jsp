<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib	prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- detail 시작 -->
<div>
	<h2>예약상세</h2>
	<hr size="1" width="100%">
	<ul class="detail_ul">
		<li><label>이름 (단체명) :</label> ${detail.reservation_name}</li>
		<li>연락처 : ${detail.reservation_phone}</li>
		<li>이메일 : ${detail.reservation_email}</li>
		<li>신청서 : <p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=1">${fn:substringAfter(detail.reservation_form1, '_')}</a></p>
				<c:if test="${!empty detail.reservation_form2}"><p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=2">${fn:substringAfter(detail.reservation_form2, '_')}</a></p></c:if>
				<c:if test="${!empty detail.reservation_form3}"><p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=3">${fn:substringAfter(detail.reservation_form3, '_')}</a></p></c:if>
		</li>
		<li><label style="float: left;width: 10%">예약일 :</label><div style="float: left;width: 88%"> ${detail.reservation_date}</div></li>
		<li style="clear: both;padding-top: 20px;">결제금액 : <fmt:formatNumber value="${result}" pattern="#,###" />원</li>
		<li>진행 현황 : 
		<c:if test="${detail.reservation_status==0}">신청완료</c:if>
		<c:if test="${detail.reservation_status==1}">심사대기</c:if>
		<c:if test="${detail.reservation_status==2}">결제대기 <button onclick="location.href='reservPayment?reservation_num=${detail.reservation_num}'">결제</button> </c:if>
		<c:if test="${detail.reservation_status==3}">결제완료 <button disabled="disabled" >결제완료</button></c:if>
		<c:if test="${detail.reservation_status==4}">신청취소</c:if>
		</li>
	</ul>
	<div class="align-right">
		<button class="btn btn-primary" onclick="location.href='/reserv/reservDelete?reservation_num=${detail.reservation_num}'">신청취소</button> 
		<button class="btn btn-primary" onclick="location.href='/reserv/reservList'">목록</button> 
	</div>
</div>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
$('#reservList').addClass('active');
/* 결제 시작 */
var IMP = window.IMP;
IMP.init('imp06364606');
function requestPay() {
    IMP.request_pay({
      pg: "html5_inicis",
      pay_method: 'vbank',
      merchant_uid: 'ticket_hall'+new Date().getTime(),   // 주문번호
      name: "TICKET24 아트센터",
      amount: 100,                         // 숫자 타입
      buyer_email: "gildong@gmail.com",
      buyer_name: "홍길동",
      buyer_tel: "010-4242-4242",
      buyer_addr: "서울특별시 강남구 신사동",
      buyer_postcode: "01181"
    }, function (rsp) { // callback
    	 if (rsp.success) {
   		     payment();
   		} else {
   		      var msg = '결제에 실패하였습니다.';
   		      msg += '에러내용 : ' + rsp.error_msg;
   		      alert(msg);
   		}
    });
 }
 function payment(){
	$.ajax({
		url:'../reserv/updatePayment',
		type:'post',
		data:{reservation_num:${payment.reservation_num}},
		dataType:'json',
		success:function(param){
			if(param.result=='success'){
				 var msg = '결제가 완료되었습니다.';
	   		     alert(msg);
	   		     location.href = 'reservDetail?reservation_num=${payment.reservation_num}'
			}else{
				alert('결제 오류 : 문의처에 문의해주세요.');
			}
		},
		error:function(){
			alert('결제 오류 : 문의처에 문의해주세요.');
		}
	});
 }
/* 결제 끝 */
</script>
<!-- detail 끝 -->
   