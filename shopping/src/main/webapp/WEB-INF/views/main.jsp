<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">	
	/* banner */
	.banner {position: relative; width: 1040px; height: 410px; top: 50px;  margin:0 auto; padding:0; overflow: hidden;}
	.banner ul {position: absolute; margin: 0px; padding:0; list-style: none; }
	.banner ul li {float: left; width: 1040px; height: 410px; margin:0; padding:0;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Nuri Shopping</title>


</head>
<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>

	NuriShop
	<input type="text" class="cate_name" value="">
	<button type="button" class="search">검색</button>
	<c:if test="${sessionScope.user_id eq null }">
	   <button type="button" id="signup">회원가입</button>
	</c:if>
	<c:if test="${sessionScope.user_id ne null }">
		<button type="button" id="logout">로그아웃</button>
		<button type="button" id="mypage">마이페이지</button>
		<button type="button" id="goCart">장바구니</button>
	</c:if>
	<c:if test="${sessionScope.user_id eq null }">
		<button type="button" id="login">로그인</button>
	</c:if>
	<br><br>
	Category
	
	<input type="hidden" class="selectedCtg">
	
	<button type="button" class="menu" id="coffee" value="1">커피</button>
	<button type="button" class="menu" id="bread" value="2">빵</button>
	<button type="button" class="menu" id="electric" value="3">가전</button>
	<button type="button" class="menu" id="travel" value="4">여행</button>
	
	<div class="contents">
		<div class="banner">
			<ul>
				<!-- <li><img src="https://www.oasis.co.kr:48580/product/8127/detail/detail_8127_0_ab3eea51-ca46-4381-8d94-a0c73f106168.jpg" width="1040" height="410px"></li>
				<li><img src="https://www.oasis.co.kr:48580/product/8145/detail/detail_8145_0_25900c33-6ab0-483a-958a-42d2a2366c77.jpg" width="1040" height="410px"></li> -->
				<li>
					<a href="/shop/goevent?event_idx=1">
					<img src="http://static1.e-himart.co.kr/contents/content/display/cornerContents/imageBanner/2043/imageBanner_1610700473602.jpg" width="1040" height="410px">
					</a>
				</li>
				<li>
					<a href="/shop/goevent?event_idx=2">
					<img src="http://openimage.interpark.com/dia/images/115/33/201105033/a5d5719437be46b9b75a4877d71432cb.jpg" width="1040" height="410px">
					</a>	
				</li>
					
			</ul>
		</div>
	</div>
	
	<br><br><br><br><br><br>
	
	<div>
	정렬방식 :&nbsp;
	<select name="range" onchange="orderByValue(this.value)" id="range">
		<option>선택하세요</option>
		<option value="1">낮은가격순</option>
		<option value="2">높은가격순</option>
		<option value="3">최신등록순</option>
	</select>
	
		<table class="prod_tbl" border="1">
			<tr class="prod_tr1">
			<c:forEach var="list" items="${cate_list}" varStatus="status" >
				<td>
					<a href="/shop/getdetail?cate_idx=${list.cate_idx }">
						<img src="/resources/images/${list.cate_img }" width="80%" height="50%" >
					</a>
					<br>
						${list.cate_name}&nbsp;&nbsp;${list.cate_price }원<br>
				</td>
				<c:if test="${status.count % 3 == 0 }">
					<tr>						
				</c:if>
			</c:forEach>
			</tr>
			
		</table>
	</div>
	
<script type="text/javascript">

$(document).ready(function() {
	var $banner = $(".banner").find("ul");

	var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
	var $bannerHeight = $banner.children().outerHeight(); // 높이
	var $length = $banner.children().length;//이미지의 갯수
	var rollingId;

	//정해진 초마다 함수 실행
	rollingId = setInterval(function() { rollingStart(); }, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

	function rollingStart() {
		$banner.css("width", $bannerWidth * $length + "px");
		$banner.css("height", $bannerHeight + "px");
		//alert(bannerHeight);
		//배너의 좌측 위치를 옮겨 준다.
		$banner.animate({left: - $bannerWidth + "px"}, 1000, function() { //숫자는 롤링 진행되는 시간이다.
			//첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
			$(this).append("<li>" + $(this).find("li:first").html() + "</li>");
			//뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
			$(this).find("li:first").remove();
			//다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
			$(this).css("left", 0);
			//이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
		});
	}
}); 


	$("#signup").click(function(){
		location.href ="./shop/signup";
	});
	
	$("#login").click(function(){
		location.href ="./shop/login";
	});
	
	$("#logout").click(function(){
		location.href ="./shop/logout";
	})
	
	$("#mypage").click(function(){
		location.href ="./shop/mypage?user_idx=${user_idx}";
	})
	
	$("#goCart").click(function(){
	  location.href = "./shop/getcartlist?user_idx=${user_idx}";
	});
	
	$(".menu").click(function(){
		var selectedCtg = $(this).val();
		console.log("selectedCtg: " + selectedCtg);
		
		 $.ajax({
			url : '/shop/getproducts',
			type : 'get',
			dataType : 'json',
			data : {
				"category_idx" : selectedCtg
			},
			success : function(data) {
				$(".prod_tbl").children().remove();
				$(".prod_tbl").append("<tr class='prod_tr1'></tr>");
				$(".prod_tbl").append("<tr class='prod_tr2'></tr>");
				
				//생각
				for(var i=0; i<3; i++){
					$(".prod_tr1").append("<td class='prod_td" + i + "'></td>");
					$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
				}	
				
				for(var i=3; i<6; i++){
					$(".prod_tr2").append("<td class='prod_td" + i + "'></td>");
					$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
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
	
	
	$(".search").click(function(){
		var search = $(".cate_name").val();
		console.log("search: " + search);
		
		 $.ajax({
			url : '/shop/getsearch',
			type : 'get',
			dataType : 'json',
			data : {
				"cate_name" : search
			},
			success : function(data) {
				console.log('data:' + data);
				
				$(".prod_tbl").children().remove();
				$(".prod_tbl").append("<tr class='prod_tr1'></tr>");
				
				for(var i=0; i<data.length; i++){
					$(".prod_tr1").append("<td class='prod_td" + i + "'></td>");
					$(".prod_td" + i).append("<img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
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
	
	
	// 정렬
	function orderByValue(range){
		var menu_val = $(".menu").val();
		console.log('menu_val' + menu_val);
		// 낮은가격순으로 정렬
		if($("#range").val()==1){
			$.ajax({
				url : '/shop/priceasc',
				type : 'get',
				dataType : 'json',
				data : {
					"category_idx" : menu_val
				},
				success : function(data) {
					$(".prod_tbl").children().remove();
					$(".prod_tbl").append("<tr class='prod_tr1'></tr>");
					$(".prod_tbl").append("<tr class='prod_tr2'></tr>");
					
					//생각
					for(var i=0; i<3; i++){
						$(".prod_tr1").append("<td class='prod_td" + i + "'></td>");
						$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
					}	
					
					for(var i=3; i<6; i++){
						$(".prod_tr2").append("<td class='prod_td" + i + "'></td>");
						$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
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
		}
		
		
		// 높은가격순으로 정렬
		if($("#range").val()==2){
			$.ajax({
				url : '/shop/pricedesc',
				type : 'get',
				dataType : 'json',
				data : {
					"category_idx" : ${categrp_idx}
				},
				success : function(data) {
					$(".prod_tbl").children().remove();
					$(".prod_tbl").append("<tr class='prod_tr1'></tr>");
					$(".prod_tbl").append("<tr class='prod_tr2'></tr>");
					
					//생각
					for(var i=0; i<3; i++){
						$(".prod_tr1").append("<td class='prod_td" + i + "'></td>");
						$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
					}	
					
					for(var i=3; i<6; i++){
						$(".prod_tr2").append("<td class='prod_td" + i + "'></td>");
						$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
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
		}
		
		// 최신순으로 정렬
		if($("#range").val()==3){
			$.ajax({
				url : '/shop/orderbydate',
				type : 'get',
				dataType : 'json',
				data : {
					"category_idx" : ${categrp_idx}
				},
				success : function(data) {
					$(".prod_tbl").children().remove();
					$(".prod_tbl").append("<tr class='prod_tr1'></tr>");
					$(".prod_tbl").append("<tr class='prod_tr2'></tr>");
					
					//생각
					for(var i=0; i<3; i++){
						$(".prod_tr1").append("<td class='prod_td" + i + "'></td>");
						$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
					}	
					
					for(var i=3; i<6; i++){
						$(".prod_tr2").append("<td class='prod_td" + i + "'></td>");
						$(".prod_td" + i).append("<a href='/shop/getdetail?cate_idx="+data[i].cate_idx+"'><img src='/resources/images/" + data[i].cate_img + "' width='80%' height='50%'><br>가격&nbsp;&nbsp;"+data[i].cate_price+"원");
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
		}
	}
</script>
</body>
</html>