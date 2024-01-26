<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Nuri Shopping Cart</title>
</head>
<body>
	<input type="hidden" class="user_id" value="${userInfo.user_id}">
	
	${userInfo.user_name}님의 장바구니 내역입니다.
	<table border="1">
		<c:forEach var="cart_list" items="${cart_list}" varStatus="status">
			<tr class="pd_tr">
				<td>
					<input type="checkbox" name="cart" id="cart" value="${cart_list.cart_idx}"><br>
					<input type="hidden" id="cart_price" value="${cart_list.cart_price }">
					<input type="hidden" id="cart_name" value="${cart_list.cart_name }">
					<input type="hidden" id="cart_img" value="${cart_list.cart_img }">
					<label class="cart_name" value="${cart_list.cart_name }">상품명 : ${cart_list.cart_name } </label><br>
					<img src="/resources/images/${cart_list.cart_img }" style="width:100px;"><br>
					가격 : ${cart_list.cart_price } 원
				</td>
			</tr>
		</c:forEach>
		<td colspan="3">
			<button type="button" id="pay" style="margin-left: 30px;">선택항목 결제하기</button>
		</td>
	</table>
	
<script type="text/javascript">
	// 결제페이지로 이동 
	$("#pay").click(function(){
		var cart_name = $("#cart_name").val();
		console.log('cart_name: ' + cart_name);
		
		var status = $("#status").val();
		console.log('status:' + status);
		
		var cart_img = $("#cart_img").val();
		
		var cart_price = $("#cart_price").val();
		console.log('cart_price:' + cart_price);
		
		var cnt = $("input[name='cart']:checked").length;
		//var arr = new Array();
		var checkArr = []; 
		var param = "";
		
		$("input[name='cart']:checked").each(function(){
			checkArr.push($(this).val()); 
		});
		
		
			$.ajax({
				url : '/shop/addpay',
				type : 'get',
				dataType : 'json',
				data : 
				 {
					"user_id" : ${userInfo.user_id},
					"checkArr" : checkArr
				},
				success : function(data) {
					console.log("도착~");
					
					if(data == 1){
						alert('구매완료 되었습니다.\n마이페이지로 이동합니다.');
						location.href='./mypage?user_id=${userInfo.user_id}';
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