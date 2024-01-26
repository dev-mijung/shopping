<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<style>
table {
	border: 1px solid black;
}

th, td {
	border: 1px solid black;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Nuri Shopping 상품 상세페이지</title>
</head>
<body>
	<input type="hidden" class="user_id" value="${user_id}">
	<input type="hidden" class="cate_img" value="${detail.cate_img}">
	<input type="hidden" class="cate_price" value="${detail.cate_price}">
	
	<table>
		<tr>
			<td><img src="/resources/images/${detail.cate_img}"></td>
			<td>
				<div class="cate_name">${detail.cate_name}</div>
				
				<div>가격: ${detail.cate_price}원</div>
			</td>
		</tr>
	</table>
	<br>
	<br>
	상품설명>><br><br>
	<div>${detail.cate_content}</div>
	<br><br>
	<button type="button" id="cart">장바구니</button>
	<button type="button" id="buy">구매하기</button>

<script type="text/javascript">
	$("#cart").click(function(){
		
		var user_id = $(".user_id").val();
		var cate_img = $(".cate_img").val();
		var cate_name = $(".cate_name").text();
		var cate_price = $(".cate_price").val();
		console.log('cate_price:' + cate_price);
		$.ajax({
			url : '/shop/addcart',
			type : 'post',
			dataType : 'json',
			data : {
			   "cate_idx" : ${param.cate_idx},
				"user_id" : user_id,
				"cart_name" : cate_name,
				"cart_img" : cate_img,
				"cart_price" : cate_price
			},
			success : function(data) {
				console.log("도착~");
				
				if(data == 1){
					alert('장바구니에 상품을 담았습니다.\n장바구니로 이동합니다.');
					location.href='./getcartlist?user_id=${user_id}';
				}
			},
			error : function(request,status,error) {
				var msg = 'ERROR<br><br>';
				msg += '<strong>request.status</strong><br>'
						+ request.status
						+ '<hr>';
				msg += '<strong>error</strong><br>'
						+ error
						+ '<hr>';
				console.log(msg);
			}
		});
	});
</script>
</body>
</html>