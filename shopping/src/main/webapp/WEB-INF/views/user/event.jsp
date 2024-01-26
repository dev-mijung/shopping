<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuri Shopping Event Page</title>
</head>
<body>
	이벤트 페이지 입니다. <a href="/">Home</a><br>
	
	${eventVO.event_name }<br><br>
	<img src="/resources/images/${eventVO.event_img }"><br>
	<br>
	이벤트 상세내용>><br><br>
	${eventVO.event_content }

</body>
</html>