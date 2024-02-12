<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib	prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- detail 시작 -->
<div>
	<h2>예약상세</h2>
	<hr size="1" width="100%">
	<div class="detail_container">
    <div class="detail_left">
        <ul class="detail_ul">
            <li><label>이름 (단체명) :</label> ${detail.reservation_name}</li>
            <li>연락처 : ${detail.reservation_phone}</li>
            <li>이메일 : ${detail.reservation_email}</li>
            <li>신청서 : 
                <p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=1">${fn:substringAfter(detail.reservation_form1, '_')}</a></p>
                <c:if test="${!empty detail.reservation_form2}">
                    <p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=2">${fn:substringAfter(detail.reservation_form2, '_')}</a></p>
                </c:if>
                <c:if test="${!empty detail.reservation_form3}">
                    <p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=3">${fn:substringAfter(detail.reservation_form3, '_')}</a></p>
                </c:if>
            </li>
        </ul>
    </div>
	    <div class="detail_right">
	        <ul class="detail_ul">
	            <li><label style="float: left;">예약일 : </label><div style="float: left;width: 80%"> ${detail.reservation_date}</div></li>
	            <li style="clear: both;padding-top: 20px;">결제금액 : <fmt:formatNumber value="${result}" pattern="#,###" />원</li>
	            <li>진행 현황 : 
	                <c:if test="${detail.reservation_status==0}">신청완료</c:if>
	                <c:if test="${detail.reservation_status==1}">심사대기</c:if>
	                <c:if test="${detail.reservation_status==2}">결제대기 <button onclick="location.href='reservPayment?reservation_num=${detail.reservation_num}'">결제</button> </c:if>
	                <c:if test="${detail.reservation_status==3}">결제완료 <button disabled="disabled" >결제완료</button></c:if>
	                <c:if test="${detail.reservation_status==4}">신청취소</c:if>
	            </li>
	        </ul>
	    </div>
	</div>
	<div class="notice">
        <h3 style="text-align: center;">결제 및 취소 정책</h3>
        <h4>결제</h4>
        <p style="margin-left: 20px;line-height: 1.6;">결제는 심사종료일로부터 3일 이내에 완료되어야 합니다. 심사종료 후 3일 이내에 결제가 완료되지 않을 경우, 예약은 자동으로 취소됩니다. 결제가 취소되면 해당 일자는 다시 예약 가능한 상태로 변경됩니다.</p>
        <h4>결제 절차</h4>
        <ol>
            <li>예약한 일자는 심사종료일로부터 3일 동안 예약 유지됩니다.</li>
            <li>심사 후 3일 이내에 결제가 완료되어야 합니다.</li>
            <li>결제는 온라인 플랫폼을 통해 신용카드 또는 기타 결제 수단을 이용하여 진행됩니다.</li>
            <li>결제 완료 후에는 예약이 최종 확정되며, 해당 일자는 이용자의 명의로 예약됩니다.</li>
        </ol>
        <h4>취소 정책</h4>
        <ol>
            <li>결제를 완료하지 않은 예약은 주문일로부터 3일 후 자동으로 취소됩니다.</li>
            <li>예약 취소를 원하는 경우, 결제 전까지는 언제든지 가능합니다. 결제 후에는 취소가 불가능합니다.</li>
            <li>예약 취소는 온라인 플랫폼을 통해 신청할 수 있으며, 취소 수수료가 부과될 수 있습니다.</li>
            <li>결제 후에는 환불이 불가능하며, 취소는 예약 취소 정책에 따라 진행됩니다.</li>
        </ol>
        <p>위의 정책은 Ticket24 아트센터 대관 시 고객의 편의와 원활한 운영을 위해 마련되었습니다. 이용에 참고하시기 바랍니다.</p>
    </div>
	<div class="align-right">
		<button class="btn btn-warning" onclick="location.href='/reserv/reservDelete?reservation_num=${detail.reservation_num}'">신청취소</button> 
		<button class="btn btn-secondary" onclick="location.href='/reserv/reservList'">목록</button> 
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
   