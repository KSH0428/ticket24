<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<style>
input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
.file-label {
    display: inline-block;
    color: #fff;
    background-color: #999999;
    cursor: pointer;
    margin-top: 3px;
    vertical-align: middle;
    text-align: center;
}
</style>

<div class="container" >
	<h2>예약 정보</h2>
	<hr size="1" width="100%">
	<form:form action="reservation" id="reservation_form" enctype="multipart/form-data" modelAttribute="reservHallVO">
	<div class="row">
	<div class="col" style="margin-left: 20px; margin-top: 20px;">
		<c:forEach var="date" items="${reservation_date}">
			<form:hidden path="reservation_date" value="${date}"/>
		</c:forEach>
			<div class="row mb-3">
				<form:label  class="col-form-label form-col" path="reservation_name">단체명</form:label>
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
			<div>
				<label >진행 상황 수신 방법</label><br>
				<input type="checkbox" name="receive"> <span style="font-size: 15px">문자</span>
				<input type="checkbox" name="receive"> <span style="font-size: 15px">이메일</span>
			</div>
			<div class="row mb-3">
				<div style="width: 67%;float: left;"><label style="width: 100%;" class="form-col col-form-label">신청서 <span style="font-size: 15px;color: gray">*최대 3개만 등록할 수 있습니다.</span></label></div><div style="float:left;width: 30%" id="uploadSpace"></div>
				<div class="col-sm-9">
				<br>
				<div id="uploadList"></div>
				</div>
			</div>
		</div>
 			<div class="vr vrline" style="padding-right:0;padding-left:0;"></div>
		<div class="col date_box"  style=" min-height:400px;">
		<div>선택 날짜</div>
			<hr size="1" width="100%">
				<table id="date-table" class="striped-table2" style="height: 400px; display: table;">
				<c:forEach var="reservation_date" items="${reservation_date}">
				<tr><td>${reservation_date}</td></tr>
				</c:forEach>
				</table>
		</div>
		</div>
		<div class="row align-center">
			<input type="submit" class="btn btn-warning" value="예약">
		</div>
	</form:form>
	
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#reserv').addClass('active');
	let cnt = 0;
	//초기 파일 업로드 생성
	createFile();
	
	//업로드 버튼 생성
	function createFile() {
		let output = '';
		output += '<label class="file-label btn btn-warning" for="upload'+cnt+'">파일업로드</label>'
		output += '<input type="file" name="upload" class="upload" id="upload'+cnt+'">'
		$('#uploadSpace').append(output);
		cnt++
	}
	function deleteFile(index) {
		$(this).remove();
	}
	$(document).on('change', '.upload', function() {
		let output = '';
		let fileId = $(this).attr('id');
		output += '<p class="file_btn">'+$(this).val().split('\\').pop()
		output += ' <button type="button" data-id="'+fileId+'" class="btn-close delete-btn"></button>'
		output += '</p>'
		$('#uploadList').append(output);
		$('label[for="'+fileId+'"]').remove();
		createFile();
	});
	$(document).on('click', '.delete-btn', function() {
		let fileId = $(this).attr('data-id')
		$(this).parent().remove();
		$('input[id="'+fileId+'"]').remove();
	});
	function insertfile(files) {
		let output = '';

		output += '<p>'
				+ files.name
				+ '<input type="button" value="파일 삭제" onclick="deleteFile()"><input type="file" class="upload" id="upload'+cnt+'"></p><br>'
		$('#uploadList').append(output);
		cnt + 1;
	}
	
	$('#reservation_form').submit(function(){
		let upload = $('[name="upload"]');
		if(upload.val().length<1){
			alert('신청서를 등록해주세요');
			return false;
		}
		if(upload.length>3){
			alert('신청서는 최대 3개만 등록할 수 있습니다.');
			return false;
		}
		var isAtLeastOneChecked = $("input[name='receive']:checked").length > 0;
        if (!isAtLeastOneChecked) {
            alert("하나 이상의 수신 방법을 선택해주세요.");
            return false; // 넘어가지 않음
        }
	});
});
</script>




