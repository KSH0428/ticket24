<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>결제자 정보</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            text-align: center;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: center;
        }
        .align-center{
        	margin-top:50px;
        	text-align: center;
        }
    </style>
</head>
<body>

<table>
    <tr>
        <th colspan="2">결제자 정보</th>
    </tr>
    <tr>
        <td>이름</td>
        <td>${payment.payment_name }</td>
    </tr>
    <tr>
        <td>연락처</td>
        <td>${payment.payment_phone}</td>
    </tr>
    <tr>
        <td>이메일</td>
        <td>${payment.payment_email }</td>
    </tr>
    <tr>
        <td>결제번호</td>
        <td>${payment.imp_uid}</td>
    </tr>
    <tr>
        <td>판매자 결제번호</td>
        <td>${payment.merchant_uid}</td>
    </tr>
    <tr>
        <th colspan="2">결제정보</th>
    </tr>
    <tr>
        <td>결제방식</td>
        <td>
        	<c:if test="${payment.payment_method eq 'card'}">신용카드</c:if>
        	<c:if test="${payment.payment_method eq 'trans'}">실시간계좌이체</c:if>
        	<c:if test="${payment.payment_method eq 'vbank'}">가상계좌</c:if>
        	<c:if test="${payment.payment_method eq 'phone'}">휴대폰소액결제</c:if>
        </td>
    </tr>
    <tr>
        <td>결제금액</td>
        <td><fmt:formatNumber value="${payment.reservation_price}" pattern="#,###" />원</td>
    </tr>
</table>
<div class="align-center"><button onclick="window.close()">닫기</button> </div>
</body>
</html>
    