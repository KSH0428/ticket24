<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title"/></title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cmj.css">
</head>
<body>
<div id="main">
	<div id="main_header">
		<tiles:insertAttribute name="header"/>
	</div>
	<div id="main_banner container" style="margin-bottom: 50px;">
		<tiles:insertAttribute name="banner"/>
	</div>
	<div class="side-height container">
		<div id="page_nav">
			<tiles:insertAttribute name="nav"/>
		</div>
		<div id="page_body">
			<tiles:insertAttribute name="body"/>
		</div>
	</div>
	<div id="main_footer" class="page_clear">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>





