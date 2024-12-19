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
		$('input[value="확인"]').on('click', function() {
			var $currentPass = $('#pass');
			var $newPass = $('#newPass');
			var $newPassChk = $('#newPassChk');

			var currentPassVal = $.trim($currentPass.val());
			var newPassVal = $.trim($newPass.val());
			var newPassChkVal = $.trim($newPassChk.val());

			// 현재 비밀번호 확인
			if (currentPassVal === '') {
				alert('현재 비밀번호를 입력해주세요.');
				$currentPass.focus();
				return;
			}

			// 새 비밀번호 확인
			if (newPassVal === '') {
				alert('새 비밀번호를 입력해주세요.');
				$newPass.focus();
				return;
			}

			// 새 비밀번호와 확인란 비교
			if (newPassVal !== newPassChkVal) {
				alert('새 비밀번호와 비밀번호 확인이 일치하지 않습니다.');
				$newPassChk.focus();
				return;
			}

			// 모든 조건이 만족되었을 때
			alert('비밀번호가 재설정되었습니다.');
			// 여기서 원하는 동작 (ex: 서버로 데이터 전송)을 추가할 수 있습니다.
		});
	});
</script>

</head>
<body>
	<!--header import  -->
	<jsp:include page="../common/jsp/header.jsp" />

	<!-- 로그인 컨텐츠 -->
	<div class="container">
		<div style="text-align: center">
			<img src="http://localhost/second_prj/common/svg/logo.svg"
				alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
			<h5 class="bld">비밀번호 재설정</h5>
			<p class="text-muted">현재비밀번호와 새 비밀번호를 입력해주세요</p>
		</div>
		<div class="d-grid" style="margin-bottom: 50px">
			<label class="form-label bld">현재 비밀번호</label> <input type="password"
				class="form-control" placeholder="현재 비밀번호를 입력" name="pass" id="pass">
			<label class="form-label bld">새 비밀번호</label> <input type="password"
				class="form-control" placeholder="새 비밀번호를 입력" name="newPass"
				id="newPass"> <label class="form-label bld frm">새
				비밀번호 확인</label> <input type="password" class="form-control"
				placeholder="새 비밀번호를 확인" name="newPassChk" id="newPassChk">
			<input type="button" class="btn btn-primary btn-lg frm" value="확인">
		</div>
	</div>
	<!-- footer import -->
	<jsp:include page="../common/jsp/footer.jsp" />
</body>
</html>
