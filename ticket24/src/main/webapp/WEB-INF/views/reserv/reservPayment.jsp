<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 결제 시작 -->
<div>
	<h2>대관 결제</h2>
	<hr size="1" width="100%">
	<form:form action="reservation" id="reservation_form" modelAttribute="reservHallVO">
	<div class="row">
	<div class="col" style="margin-left: 20px; margin-top: 20px;">
		<c:forEach var="date" items="${reservation_date}">
			<input type="hidden" name="reservation_date" value="${date}"/>
		</c:forEach>
			<div class="row mb-3">
				<h4>결제자 정보</h4>
				<div style="padding-right:30px;">
					<hr style="width:100%;">
				</div>
				<form:label  class="col-form-label form-col" path="reservation_name">결제인</form:label>
				<div class="col-sm-9">
				<form:input class="form-control" path="reservation_name"/>
				<span id="message_name"></span>
				<form:errors path="reservation_name" cssClass="error-color"/>
				</div>
			</div>
			<div class="row mb-3">
				<form:label class="col-form-label form-col" path="reservation_phone">연락처</form:label>
				<div class="col-sm-9">
				<form:input class="form-control" path="reservation_phone"/>
				<span id="message_phone"></span>
				<form:errors path="reservation_phone" cssClass="error-color"/>
				</div>
			</div>
			<div class="row mb-3">
				<form:label class="col-form-label form-col" path="reservation_email">이메일</form:label>
				<div class="col-sm-9">
				<form:input class="form-control" path="reservation_email"/>
				<span id="message_email"></span>
				<form:errors path="reservation_email" cssClass="error-color"/>
				</div>
			</div>
			<br>
			<div class="row mb-3">
				<h4>신청일자</h4>
				<div style="padding-right:30px;">
				<hr style="width:100%; margin-bottom: 5px;">
				</div>
				<div>
				<table id="date-table"style="height: 200px;">
				<c:forEach var="reservation_date" items="${date.reservation_date}">
				<tr><td><fmt:formatDate pattern="yyyy년 MM월 dd일 E요일" value="${reservation_date}"/></td></tr>
				</c:forEach>
				</table>
				</div>
			</div>
			
		</div>
 			<div class="vr vrline" style="padding-right:0;padding-left:0;"></div>
		<div class="col payment-box"  style=" min-height:400px;">
			<h4>결제 정보</h4>
			<div>
				<hr size="1" width="100%">
			</div>
				<span class="gray-font">평일 : <span class="span-right">${weekdayCount}일</span></span><br>
				<span class="gray-font">주말 : <span class="span-right">${weekendCount}일</span></span><br>
				<span style="margin-top: 5px;">총 결제금액 : <span class="span-right" style="color: blue;"><fmt:formatNumber value="${payment.reservation_price}" pattern="#,###" />원</span></span>
			<div>
				<hr size="1" width="100%" style="margin-top: 40px;">
			</div>
			<div class="payment-method">
				<div class="form-check">
				  <input class="form-check-input payment-check" type="radio" name="payment_method" id="card">
				  <label class="form-check-label" for="card">
				    신용카드
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input payment-check" type="radio" name="payment_method" id="trans">
				  <label class="form-check-label" for="trans">
				    실시간계좌이체
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input payment-check" type="radio" name="payment_method" id="vbank">
				  <label class="form-check-label" for="vbank">
				    가상계좌
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input payment-check" type="radio" name="payment_method" id="phone" >
				  <label class="form-check-label" for="phone">
				    휴대폰소액결제
				  </label>
				</div>
			</div>
			<div style="clear: both;padding-top: 18px;">
				<hr  width="100%" >
			</div>
			<div class="form-check purchase">
			  <input class="form-check-input" type="checkbox" value="" id="purchase_consent">
			  <label class="form-check-label" for="purchase_consent" style="line-height: 2.3;">
			    구매조건 확인 및 결제진행에 동의
			  </label>
				<div class="d-grid gap-2 mt-4">
				  <button class="btn btn-warning" type="button" id="payment">결제하기</button>
				</div>
			</div>
		</div>
		</div>
	</form:form>
	
</div>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
$('#reservList').addClass('active');
<!-- 유효성 검사 시작 -->
$(document).ready(function(){
    $("#payment").click(function(){
    	let isChecked = false;
        isChecked = $(".payment-check:checked").length > 0;
        if (!isChecked) {
            alert("적어도 하나의 결제 방법을 선택해주세요.");
            return;
        }
        isChecked = $("#purchase_consent:checked").length > 0;
        if (!isChecked) {
            alert("구매조건 확인 및 결제진행에 동의해주세요.");
            return;
        }
        
        requestPay();
    });
    
});	

<!-- 유효성 검사 끝 -->   


/* 결제 시작 */
var IMP = window.IMP;
IMP.init('imp06364606');
function requestPay() {
	
	//결제시작
	IMP.request_pay({
      pg: "html5_inicis",
      pay_method: $('input[type="radio"]:checked').attr('id'),
      merchant_uid: 'ticket_hall'+new Date().getTime(),   // 주문번호
      name: "TICKET24 아트센터",
      amount: ${payment.reservation_price},                         // 숫자 타입
      buyer_email: $('#reservation_email').val(),
      buyer_name: $('#reservation_name').val(),
      buyer_tel: $('#reservation_phone').val(),
    }, function (rsp) { // callback
    	 if (rsp.success) {
    		 paymentVerify(rsp);
    		 payment(rsp)
   		} else {
   		      var msg = '결제에 실패하였습니다.';
   		      msg += '에러내용 : ' + rsp.error_msg;
   		      alert(msg);
   		}
    });
    //결제완료
 }
 function paymentVerify(rsp){
	 $.ajax({
         type: 'POST',
         url: '/verify/' + rsp.imp_uid
      }).done(function(data) {
          if(rsp.paid_amount === data.response.amount){
              
          } else {
              alert("결제 실패");
          }
      });
 }
 function payment(rsp){
	$.ajax({
		url:'../reserv/updatePayment',
		type:'post',
		data:{reservation_num:${payment.reservation_num},payment_name:rsp.buyer_name,payment_phone:rsp.buyer_tel,payment_email:rsp.buyer_email,payment_method:rsp.pay_method,merchant_uid:rsp.merchant_uid,imp_uid:rsp.imp_uid,paid_at:rsp.paid_at},
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
<!-- 결제 끝 -->
    