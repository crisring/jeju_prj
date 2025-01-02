<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 로그인</title>

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column; /* 세로 정렬 */
	min-height: 100vh;
	background-color: #f8f9fa;
}

.login-container {
	width: 360px;
	background-color: #fff;
	padding: 40px 30px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	text-align: center;
	margin: auto; /* 수직 중앙 배치 */
}

.logo {
	margin-bottom: 20px;
}

.logo img {
	width: 150px;
}

.login-container input[type="text"], .login-container input[type="password"]
	{
	width: 100%;
	height: 40px;
	margin-bottom: 16px;
	padding: 0 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

.login-container input[type="checkbox"] {
	margin-right: 5px;
}

.login-container .checkbox-container {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
	font-size: 14px;
	color: #555;
}

.login-container .login-btn {
	width: 100%;
	height: 44px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
}

.login-container .login-btn:hover {
	background-color: #0056b3;
}

.login-container .links {
	margin-top: 15px;
	font-size: 13px;
	color: #555;
}

.login-container .links a {
	color: #007bff;
	text-decoration: none;
	margin: 0 5px;
}

.login-container .links a:hover {
	text-decoration: underline;
}

footer {
	width: 100%;
	background-color: #f8f9fa;
	text-align: center;
	padding: 10px 0;
	color: #555;
	font-size: 13px;
}
</style>
<script type="text/javascript">
	$(function() {

		// 로그인 버튼 클릭 이벤트 등록
		$('#btnLogin').click(function() {

			var admin_id = $('#admin_id').val().trim();
			var password = $('#password').val().trim();

			if (chkNull(admin_id, password)) {
				login(admin_id, password);
			}
		});
	});

	// 필수 입력값 확인 함수
	function chkNull(admin_id, password) {

		// 아이디 필수 입력 확인
		if (admin_id === "") {
			alert('아이디는 필수 입력 사항입니다!');
			$('#admin_id').focus(); // 포커스 이동
			return false;
		}

		// 비밀번호 필수 입력 확인
		if (password === "") {
			alert('비밀번호는 필수 입력 사항입니다!');
			$('#password').focus();
			return false;
		}

		return true;
	}

	function login(admin_id, password) {
		// AJAX 요청을 위한 파라미터 객체
		var param = {
			admin_id : admin_id,
			password : password
		};

		$.ajax({
			url : "/admin/loginProcess",
			method : "POST",
			data : JSON.stringify(param),
			contentType : "application/json",
			dataType : "JSON",
			success : function(response) {
				if (response.loginFlag) {
					alert(response.admin_id + "님 로그인 성공!");
					window.location.href = '/admin/dashboard';
				} else {
					alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				}
			},
			error : function(xhr) {
				alert("에러 발생: " + xhr.status);
			}
		});
	}
</script>



</head>
<body>
	<div class="login-container">
		<div class="logo">
			<img src="/common/svg/logo.svg" alt="제주어때 관리자">
			<h2>관리자 로그인</h2>
		</div>
		<input type="text" placeholder="아이디" id="admin_id" name="admin_id">
		<input type="password" placeholder="비밀번호" id="password"
			name="password">
		<div class="checkbox-container"></div>
		<input type="button" class="login-btn" value="로그인" id="btnLogin">
	</div>
	<footer>
		<jsp:include page="../common/footer.jsp" />
	</footer>
</body>
</html>
