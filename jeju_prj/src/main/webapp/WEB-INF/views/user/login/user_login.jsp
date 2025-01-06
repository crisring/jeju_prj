<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${site_kor}</title>

<!-- Bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
.container {
	margin-top: 80px;
	margin-bottom: 80px;
	width: 500px;
	height: 500px;
	padding: 20px;
	border-radius: 8px;
	text-align: center;
}

.logo {
	font-size: 28px;
	font-weight: bold;
	color: #ff4c4c;
	margin-bottom: 10px;
}
</style>

<script type="text/javascript">
	function normalLogin() {
		window.location.href = "/login/loginProcess";
	}
</script>
</head>

<body>
	<!-- 헤더 -->
	<c:import url="../common/jsp/header.jsp" />

	<!-- 로그인 컨텐츠 -->
	<div class="container">
		<div style="text-align: center">
			<img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고"
				id="logo" style="display: block; margin: 0 auto;">
			<p class="text-muted">로그인/회원가입</p>
		</div>
		<div class="d-grid" style="margin-top: 50px">
			<a href="/login/oauth/kakao"> <img
				src="/common/user/images/kakao_login_medium_wide.png"
				style="width: 100%; height: 100%;">
			</a> <br>
			<button class="btn btn-light btn-lg" onclick="normalLogin()">일반회원
				로그인/회원가입</button>
		</div>
	</div>

	<!-- 푸터 -->
	<c:import url="../common/jsp/footer.jsp" />
</body>
</html>
