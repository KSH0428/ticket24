<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ysw.css">
</head>
<body>
<div id="popup-container">
	<div id="popup-header">
		<%-- <tiles:insertAttribute name="header"/> --%>
		머리
	</div>
	<div id="popup-body">
		<%-- <tiles:insertAttribute name="body"/> --%>
		몸
	</div>
	<div id="popup-sidebar">
		<tiles:insertAttribute name="sidebar"/>
	</div>
</div>
</body>
</html>