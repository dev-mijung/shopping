<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuri Shop Login</title>
</head>
<body>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/JavaScript"
		src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		
	<form name='frm' id='frm' method='post' action='./login'>
		<table border='1' style='widt: 30%;'>
			<tr>
				<td>ID</td>
				<td><input type='text' name='user_id' id='user_id' style='width:96%;'></td>
				<td rowspan='3'>
					<button type='submit' style='width: 60pt; height: 60pt'>로그인</button>
				</td>
			</tr>
			<tr>
				<td>PW</td>
				<td>
					<input type="password" name="user_passwd" id="user_passwd" style='widt: 96%;'>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>