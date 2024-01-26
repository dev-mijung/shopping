<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Nuri Shop MyPage</title>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<br>
<br>
${userInfo.user_name }님의 구매내역 입니다. 
<button type="button" id="goHome">메인페이지로</button>
<br>
<br>
	<table border="1" width="100%">
		<tr>
			<td>상품이미지</td>
			<td>주문날짜</td>
			<td>상품명</td>
			<td>가격</td>
		</tr>
		<tr>
		<c:forEach var="my_list" items="${my_list}" varStatus="status">
			<td><img src="/resources/images/${my_list.cate_img }"></td>
			<td>${my_list.pay_date }</td>
			<td>${my_list.cate_name }</td>
			<td>${my_list.cate_price }</td>
			<c:if test="${status.count % 1 == 0 }">
				<tr>
				</tr>
			</c:if>
		</c:forEach>
		</tr>
	</table>
<script type="text/javascript">
	$("#goHome").click(function(){
		location.href="/";
	});
</script>
</body>
</html>