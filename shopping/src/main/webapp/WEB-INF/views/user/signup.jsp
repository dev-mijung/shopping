<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuri Shopping</title>
</head>
<body>
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/JavaScript"
		src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	아이디 *
	<input type="text" id="user_id" value="">
	<button type="button" id="checkId">중복확인</button>
	<button type="button" id="reset">다시입력</button>
	<span id="id_span"></span>

	<br> 이름 *
	<input type="text" id="user_name" value="">

	<br> 패스워드 *
	<input type="password" id="user_passwd" value="">
	<br> 패스워드 확인 *
	<input type="password" id="user_passwd2" value="">
	<span id="passwd_span"></span>

	<br> 전화번호
	<input type='text' id='user_tel' value="">
	<br> 예) 010-0000-0000
	<br> 우편번호
	<input type='text' id='user_zip' value="">
	<input type='button' onclick='DaumPostcode()' value='우편번호 찾기'>
	<br> 주소
	<input type='text' id='user_address' value="">

	<!-- ----- DAUM 우편번호 API 시작 ----- -->
	<!-- iframe 기법 → 특정 영역만큼 타 사이트 띄우기 -->
	<div id="wrap"
		style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 110px; position: relative">
		<img
			src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png"
			id="btnFoldWrap"
			style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
			onclick="foldDaumPostcode()" alt="접기 버튼">
	</div>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

	<script>
		// 우편번호 찾기 화면을 넣을 element
		var element_wrap = document.getElementById('wrap');

		function foldDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_wrap.style.display = 'none';
		}

		function DaumPostcode() {
			// 현재 scroll 위치를 저장해놓는다.
			var currentScroll = Math.max(document.body.scrollTop,
					document.documentElement.scrollTop);
			new daum.Postcode({
				oncomplete : function(data) {
					// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullAddr = data.address; // 최종 주소 변수
					var extraAddr = ''; // 조합형 주소 변수

					// 기본 주소가 도로명 타입일때 조합한다.
					if (data.addressType === 'R') {
						//법정동명이 있을 경우 추가한다.
						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						// 건물명이 있을 경우 추가한다.
						if (data.buildingName !== '') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')'
								: '');
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('user_zip').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('user_address').value = fullAddr;

					// iframe을 넣은 element를 안보이게 한다.
					// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
					element_wrap.style.display = 'none';

					// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
					document.body.scrollTop = currentScroll;

					//$('#mem_addr2').focus();
				},
				// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
				onresize : function(size) {
					element_wrap.style.height = size.height + 'px';
				},
				width : '100%',
				height : '100%'
			}).embed(element_wrap);

			// iframe을 넣은 element를 보이게 한다.
			element_wrap.style.display = 'block';
		}
	</script>
	<!-- ----- DAUM 우편번호 API 종료----- -->
	<br>
	<br>

	<button type="button" id="send">가입</button>
	<button type="button">취소</button>
	
	
	<script type="text/javascript">
		$(document).ready(function() {
							$("#checkId").click(function() {
												//console.log('체크아이디');
												var user_id = $("#user_id").val();
												//console.log(user_id);
												if ($.trim(user_id).length == 0) {
													//console.log('확인');
													var html = "<tr><td colspan='3' style='color: green'>ID를 입력해주세요</td></tr>";
													//console.log(html);
													$("#id_span").empty();
													$("#id_span").append(html);
												} else {
													$.ajax({
																url : './checkID',
																type : 'get',
																cache : false,
																async : true,
																dataType : 'json',
																data : {
																	"user_id" : user_id
																},
																success : function(data) {
																	console.log(data);
																	if (data.cnt == 0) {
																		//$("#user_id").attr("readonly",true);
																		var html = "<tr><td colspan='3' style='color: green'>사용 가능</td></tr>";
																		$("#id_span").empty();
																		$("#id_span").append(html);
																	} else {
																		var html = "<tr><td colspan='3' style='color: red'>사용 불가능</td></tr>";
																		$("#id_span").empty();
																		$("#id_span").append(html);
																	}
																},
																error : function(
																		request,
																		status,
																		error) {
																	var msg = 'ERROR<br><br>';
																	msg += '<strong>request.status</strong><br>'
																			+ request.status
																			+ '<hr>';
																	msg += '<strong>error</strong><br>'
																			+ error
																			+ '<hr>';
																	console
																			.log(msg);
																}
															});
												}

											});

							$("#reset").click(function() {
								var user_id = $("#user_id").val("").focus();
								$("#id_span").empty();
							});

							$("#send").click(function() {
								var user_passwd = $("#user_passwd").val();
								var user_passwd2 = $("#user_passwd2").val();
	
								if (user_passwd != user_passwd2) {
									var html = "<tr><td colspan='3' style='color: red'>비밀번호가 일치되지 않습니다.</td></tr>";
									$("#passwd_span").append(html);
									//alert('비밀번호가 일치하지 않습니다.');
								} else {
									var user_password = user_passwd;
									var user_name = $("#user_name").val();
									var user_id = $("#user_id").val();
									var user_tel = $("#user_tel").val();
									var user_zip = $("#user_zip").val();
									var user_address = $("#user_address").val();
									
									//console.log(user_password);
									//console.log(user_name);
									//console.log(user_tel);
									//console.log(user_zip);
									//console.log(user_address);
								    
								$.ajax({
									url : './signup',
									type : 'post',
									cache : false,
									async : true,
									dataType : 'json',
									data : {
										"user_id" : user_id,
										"user_name" : user_name,
										"user_passwd" : user_password,
										"user_tel" : user_tel,
										"user_zip" : user_zip,
										"user_address" : user_address
									},
									success : function(data) {
										console.log(data);
										if (data.cnt == 0) {
											//$("#user_id").attr("readonly",true);
											console.log('회원가입 실패');
										} else {
											console.log('회원가입 성공');
											location.href="./../"; //home으로 이동
										}
									},
									error : function(
											request,
											status,
											error) {
										var msg = 'ERROR<br><br>';
										msg += '<strong>request.status</strong><br>'
												+ request.status
												+ '<hr>';
										msg += '<strong>error</strong><br>'
												+ error
												+ '<hr>';
										console
												.log(msg);
									}
								});
								}
								
								
								
							});

						});
	</script>
</body>
</html>