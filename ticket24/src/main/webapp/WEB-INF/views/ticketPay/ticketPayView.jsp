<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fn" uri ="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ���� ���� -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="page-main">
<h2>${ticket.ticket_name}</h2>
		<hr size="1"width="100%">
		<ul>
		<li>������ : ${ticket.ticket_name} , ������� : ${ticket.ticket_place } , ������ : ${ticket.ticket_date} </li>
		<li>�¼����� : ${ticket.ticket_seat}</li>
				<li> ��ǰ Ư�̻��� : 
			<c:forEach var="ticket_special1" items="${ticket.f_ticket_special1}" varStatus="status">
				<c:if test="${status.index > 0}">,</c:if>
				<c:if test="${ticket_special1 == 1}">����� Ƽ��</c:if> 
				<c:if test="${ticket_special1 == 2}">18�� �̻� ���� ����</c:if> 
				<c:if test="${ticket_special1 == 3}">����Ƽ�� - �л�</c:if> 
				<c:if test="${ticket_special1 == 4}">����Ƽ�� - �����</c:if>
				<c:if test="${ticket_special1 == 5}">����Ƽ�� - �����</c:if>
				<c:if test="${ticket_special1 == 6}">��������</c:if>
				<c:if test="${ticket_special1 == 7}">��������</c:if>
				<c:if test="${ticket_special1 == 8}">��������</c:if>
			</c:forEach>
		</li>
		<li> �¼� Ư�̻��� : 
			<c:forEach var="ticket_special2" items="${ticket.f_ticket_special2}" varStatus="status">
			    <c:if test="${status.index > 0}">,</c:if>
				<c:if test="${ticket_special2 == 1}">�þ� ���Ѽ�</c:if> 
				<c:if test="${ticket_special2 == 2}">��μ�</c:if> 
				<c:if test="${ticket_special2 == 3}">����Ŀ ��</c:if> 
				<c:if test="${ticket_special2 == 4}">���ĵ� ����</c:if> 
				<c:if test="${ticket_special2 == 5}">������</c:if>	
			</c:forEach>
											
		</li>
		<li>���� : ${ticket.ticket_quantity}�� , ���� :  <fmt:formatNumber value="${ticket.ticket_price}"/>�� ,
			 �� ���� : <c:set var="totalPrice" value="${ticket.ticket_quantity * ticket.ticket_price}" />
    		<fmt:formatNumber value="${totalPrice}" pattern="###,###"/>��</li>
    	<li>�Ա� ���� : ${ticket.ticket_account}</li>
		</ul>
</div>
<!-- ���� �� -->