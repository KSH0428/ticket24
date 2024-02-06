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
<body style="margin: 0">
<div id="popup-container">
	<div id="popup-header">
		<tiles:insertAttribute name="header"/>
	</div>
	<div id="popup-body">
		<tiles:insertAttribute name="body"/>
	</div>
	<div id="popup-sidebar">
		<tiles:insertAttribute name="sidebar"/>
	</div>
</div>
</body>
</html>