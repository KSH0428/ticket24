<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 내용 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>티켓 양도 글 수정</h2>
	<form:form action="update" modelAttribute="ticketVO" id="update_form" enctype="multipart/form-data">
	<form:hidden path="ticket_num"/>
	<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
			<form:label path="ticket_category">카테고리</form:label>
            <form:select path="ticket_category">
                <form:option value="1">뮤지컬</form:option>
                <form:option value="2">공연</form:option>
                <form:option value="3">콘서트</form:option>
                <form:option value="4">클래식</form:option>
            </form:select>
		</li>
		 <li>
			<form:label path="ticket_name">공연명</form:label>
			<form:input path="ticket_name"/>
			<form:errors path="ticket_name" cssClass="error-color"/>
		</li>
		 <li>
			<form:label path="ticket_date">공연일</form:label>
			<form:input path="temp_date" id="date" type="date"/>
			<form:input path="temp_time" id="time" type="time"/>
			<form:errors path="ticket_date" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_place">공연 장소</form:label>
			<form:input path="ticket_place"/>
			<form:errors path="ticket_place" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_seat">좌석 정보</form:label>
			<form:input path="ticket_seat"/>
			<form:errors path="ticket_seat" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_quantity">티켓 수량</form:label>
			<form:input path="ticket_quantity" type="number" min="1" size="3"/>장
			<form:errors path="ticket_quantity" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_price">티켓 가격</form:label>
			<form:input path="ticket_price" type="number" maxlength="30"/>원
			<form:errors path="ticket_price" cssClass="error-color"/>
		</li>
		<li>
			<form:label path="ticket_account">계좌 번호</form:label>
			<form:input path="ticket_account"/>
			<form:errors path="ticket_account" cssClass="error-color"/>
		</li>
		<li>
			<label>상품 특이사항</label>
			<form:checkbox path="f_ticket_special1" value="1"/>재관람 티켓
			<form:checkbox path="f_ticket_special1" value="2"/>18세 이상 입장 가능
			<form:checkbox path="f_ticket_special1" value="3"/>할인티켓 - 학생
			<form:checkbox path="f_ticket_special1" value="4"/>할인티켓 - 장애인
			<br>
			<form:checkbox path="f_ticket_special1" value="5"/>할인티켓 - 경로자
			<form:checkbox path="f_ticket_special1" value="6"/>여성 명의
			<form:checkbox path="f_ticket_special1" value="7"/>남성명의
			<form:checkbox path="f_ticket_special1" value="8"/>조기입장
			</li>
			<li>
			<label>좌석 특이사항</label>
			<form:checkbox path="f_ticket_special2" value="1"/>시야 제한석
			<form:checkbox path="f_ticket_special2" value="2"/>통로석
			<form:checkbox path="f_ticket_special2" value="3"/>스피커 옆
			<form:checkbox path="f_ticket_special2" value="4"/>스탠딩 한정
			<form:checkbox path="f_ticket_special2" value="5"/>가변석
			</li>
				<li>
		<li><b>내용</b></li>
		<li>
			<form:textarea path="ticket_content"/>
			<form:errors path="ticket_content" cssClass="error-color"/>
			<script>
				function MyCustomUploadAdapterPlugin(editor){
					editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						return new UploadAdapter(loader);
					}
				}
				
				ClassicEditor
					.create(document.querySelector('#ticket_content'),{
						extraPlugins:[MyCustomUploadAdapterPlugin]
					})
					.then(editor => {
						window.editor = editor;
					})
					.catch(error => {
						console.error(error);
					})
			</script>
		</li>
		<li>
    <form:label path="upload">파일업로드1</form:label>
    <input type="file" name="upload" id="upload">
    <c:if test="${!empty ticketVO.ticket_filename1}">
        <div class="file_detail">(${ticketVO.ticket_filename1})파일이 등록되어 있습니다.
            <input type="button" value="파일삭제" class="file_del" data-filenum="1">
        </div>
    </c:if>
    <form:label path="upload2">파일업로2</form:label>
    <input type="file" name="upload2" id="upload2">
    <c:if test="${!empty ticketVO.ticket_filename2}">
        <div class="file_detail">(${ticketVO.ticket_filename2})파일이 등록되어 있습니다.
            <input type="button" value="파일삭제" class="file_del" data-filenum="2">
        </div>
    </c:if>
    <form:label path="upload3">파일업로드3</form:label>
    <input type="file" name="upload3" id="upload3">
    <c:if test="${!empty ticketVO.ticket_filename3}">
        <div class="file_detail">(${ticketVO.ticket_filename3})파일이 등록되어 있습니다.
            <input type="button" value="파일삭제" class="file_del" data-filenum="3">
        </div>
    </c:if>
    <form:label path="upload4">파일업로드4</form:label>
    <input type="file" name="upload4" id="upload4">
    <c:if test="${!empty ticketVO.ticket_filename4}">
        <div class="file_detail">(${ticketVO.ticket_filename4})파일이 등록되어 있습니다.
            <input type="button" value="파일삭제" class="file_del" data-filenum="4">
        </div>
    </c:if>
    <script type="text/javascript">
        $(function(){
            $('.file_del').click(function(){
            	let choice_file =  $(this);
                let file_num = choice_file.attr('data-filenum');
                let choice = confirm('파일을 삭제하시겠습니까?');
                if(choice){
                    $.ajax({
                        url:'deleteFile',
                        data:{ticket_num:${ticketVO.ticket_num},file_num:file_num},
                        type:'post',
                        dataType:'json',
                        success:function(param){
                            if(param.result == 'logout'){
                                alert('로그인 후 사용하세요');
                            }else if(param.result == 'success'){
                            	choice_file.parent().hide();                                        
                            }else{
                                alert('파일 삭제 오류 발생');
                            }
                        },
                        error:function(){
                            alert('네트워크 오류 발생');
                        }
                    });
                }
            });
        });
    </script>
</li>
 		<li>
		<label>보유여부</label>
		<form:radiobutton path="ticket_status" value="1"/>보유중
		<form:radiobutton path="ticket_status" value="2"/>판매 완료
		</li>
		<li>
    <label>총 가격</label>
    <span id="totalPrice">0</span>원
   <script>
    // 페이지가 로드될 때 총 가격을 계산하여 표시하는 함수
    function calculateTotalPrice() {
        var quantity = parseInt(document.querySelector("[name='ticket_quantity']").value);
        var price = parseInt(document.querySelector("[name='ticket_price']").value);
        var totalPrice = quantity * price;
        
        // 총 가격을 표시하는 span 요소에 결과 값을 업데이트
        var totalPriceFormatted = totalPrice.toLocaleString(); // 쉼표를 추가한 형태로 변환
        document.getElementById("totalPrice").innerText = totalPriceFormatted;
    }

    // 티켓 수량과 가격이 변경될 때마다 총 가격을 계산하여 업데이트
    document.querySelector("[name='ticket_quantity']").addEventListener("change", calculateTotalPrice);
    document.querySelector("[name='ticket_price']").addEventListener("change", calculateTotalPrice);

    // 페이지 로드 시 한번 실행하여 초기 총 가격을 설정
    calculateTotalPrice();
</script>  
	</li>
	</ul>
	<div class="align-center">
		<form:button>전송</form:button>
		<input type="button" value="글 상세" onclick="location.href='detail?ticket_num=${ticketVO.ticket_num}'">
	</div>
	</form:form>
</div>

<!-- 내용 끝 -->