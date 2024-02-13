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
		<li>이름 (단체명) : ${detail.reservation_name}</li>
		<li>연락처 : ${detail.reservation_phone}</li>
		<li>이메일 : ${detail.reservation_email}</li>
		<li>신청서 : <p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=1">${fn:substringAfter(detail.reservation_form1, '_')}</a></p>
				<c:if test="${!empty detail.reservation_form2}"><p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=2">${fn:substringAfter(detail.reservation_form2, '_')}</a></p></c:if>
				<c:if test="${!empty detail.reservation_form3}"><p class="file_btn"><a href="file?reservation_num=${detail.reservation_num}&file_num=3">${fn:substringAfter(detail.reservation_form3, '_')}</a></p></c:if>
		</li>
		<li><label style="float: left;width: 10%">예약일 :</label><div style="float: left;width: 88%"> ${detail.reservation_date}</div></li>
		<li style="clear: both;padding-top: 20px;">결제금액 : <fmt:formatNumber value="${result}" pattern="#,###" />원</li>
		<li><label class="floatL">진행 현황 :  </label><select id="reservation_status" name="reservation_status" class="form-select form-select-lg mb-2 floatL" style="width: 30%;">
  			<option value="0" <c:if test="${detail.reservation_status==0}">selected</c:if>>신청완료</option>
  			<option value="1" <c:if test="${detail.reservation_status==1}">selected</c:if>>심사대기</option>
  			<option value="2" <c:if test="${detail.reservation_status==2}">selected</c:if>>결제대기</option>
  			<option value="3" <c:if test="${detail.reservation_status==3}">selected</c:if>>결제완료</option>
  			<option value="4" <c:if test="${detail.reservation_status==4}">selected</c:if>>신청취소</option>
		</select>
		<button id="change_btn" class="btn btn-secondary">변경</button>
		</li>
	</ul>
	<div class="align-right">
		<button class="btn btn-warning">신청취소</button> 
		<button class="btn btn-secondary">목록</button> 
	</div>
</div>
<script>
$('#reservListAdmin').addClass('active');
let inputDate = ${detail.reservation_date}
$('#change_btn').click(function(){
	let status = $('#reservation_status').val();
	$.ajax({
		url:'../reserv/updateStatus',
		type:'post',
		data:{reservation_num:${detail.reservation_num},reservation_status:status},
		dataType:'json',
		success:function(param){
			if(param.result=='logout'){
				alert('로그인 후 사용하세요');
			}else if(param.result = 'success'){
				alert('진행상황이 변경되었습니다.');
			}else{
				alert('변경 오류');
			}
		},
		error:function(){
			alert('네트워크 오류');
		}
	});
});
</script>
<!-- detail 끝 -->
   