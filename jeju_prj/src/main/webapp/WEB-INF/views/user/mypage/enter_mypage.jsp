<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주어때</title>

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
	width: 500px;
	height: 500px;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 80px;
}

.frm {
	margin-top: 30px;
}

.bld {
	font-weight: bold;
}
</style>

<script>
	$(document).ready(function() {
		$('input[value="들어가기"]').on('click', function() {
			var $name = $('#name');
			var nameVal = $.trim($name.val());

			if (nameVal === '') {
				alert('비밀번호를 입력해주세요.');
				$name.focus();
				return;
			}

			// 비밀번호가 정상적으로 입력되었을 경우
			// 여기서 원하는 동작 (ex: 페이지 이동, 폼 전송 등)
			alert('마이페이지로 들어갑니다.');
		});
	});
</script>

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../common/jsp/header.jsp" />

	<!-- 로그인 컨텐츠 -->
	<div class="container">
		<div style="text-align: center">
			<img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고"
				id="logo" style="display: block; margin: 0 auto;">
			<h5 class="bld">마이페이지</h5>
			<p class="text-muted">
				XXX회원님 마이페이지에 들어가기전 <br>비밀번호를 입력해주세요.
			</p>
		</div>
		<div style="margin-bottom: 50px">
			<label class="form-label bld">비밀번호</label> <input type="password"
				class="form-control" placeholder="비밀번호 입력" name="name" id="name">
			<div style="text-align: center;">
				<input type="button" class="btn btn-info btn-lg frm" value="메인으로">
				<input type="button" class="btn btn-primary btn-lg frm" value="들어가기">
			</div>
		</div>
	</div>
	<!-- footer -->

	<jsp:include page="../common/jsp/footer.jsp" />
</body>
</html>

