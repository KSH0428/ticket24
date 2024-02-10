<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ���� ���� -->
<div class="page-main">
	<h2>Ƽ�Ͼ絵 ���</h2>
	<form action="list" id="search_form" method="get">
	<ul class="search">
	<li>
		<select name="keyfield" id="keyfield">
				<option value="1"<c:if test="${param.keyfield == 1}">selected</c:if>>������</option>
				<option value="2"<c:if test="${param.keyfield == 2}">selected</c:if>>����</option>
				<option value="3"<c:if test="${param.keyfield == 3}">selected</c:if>>������+����</option>
		</select>
		</li>
				<li>
			<input type="search" name="keyword" id="keyword" value="${param.keyword}">
		</li>
		<li>
			<input type="submit" value="ã��">
			<input type="button" value="���" onclick="location.href='list'">
		</li>
		</ul>
		</form>
			<c:if test="${count == 0}">
				<div class="result-display">ǥ���� �Խù��� �����ϴ�.</div>
			</c:if>
			<c:if test="${count > 0}">
			<table class="striped-table">
				<tr>
					<th>��ȣ</th>
					<th>ī�װ�</th>
					<th>������</th>
				</tr>
				<c:forEach var="ticket" items="${list}">
					<td class="align-center">${ticket.ticket_num}</td>
					<td class="align-center"><c:if
						test="${ticket.ticket_category == 1}">������</c:if> <c:if
						test="${ticket.ticket_category == 2}">����</c:if> <c:if
						test="${ticket.ticket_category == 3}">�ܼ�Ʈ</c:if> <c:if
						test="${ticket.ticket_category == 4}">Ŭ����</c:if></td>
				<td><a href="detail?ticket_num=${ticketPay.ticket_num}">${ticket.ticket_name}</a></td>					
				</c:forEach>
			</table>
			<div class="align-center">${page}</div>
			</c:if>	
	</div>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(function(){
			//�˻� ��ȿ�� üũ
			$('#search_form').submit(function(){
				if($('#keyword').val().trim()==''){
				alert('�˻�� �Է��ϼ���');
				$('#keyword').val('').focus();
				return false;
			}
			});//end of submit
			
			//���ļ���
			$('#order').change(function(){
				if(${!empty param.ticket_category}){
					location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword').val();
				}else{
					location.href='list?keyfield='+$('#keyfield').val()+'&keyword='+$('#keyword');
				}
			});
		});
		
		</script>
<!-- ���� �� -->