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
body {
	background-color: #fff;
	font-family: Arial, sans-serif;
	font-size: 1.1em;
}

.container {
	margin-top: 80px;
	width: 500px;
	padding: 20px;
	border-radius: 8px;
	font-size: 1rem;
	line-height: 1.5;
	margin-bottom: 80px;
}

.logo {
	font-size: 28px;
	font-weight: bold;
	color: #ff4c4c;
	margin-bottom: 10px;
}

.frm {
	margin-top: 30px;
}
</style>

<script>
	$(document).ready(function() {
		// "약관 전체동의" 체크박스 클릭 이벤트
		$('#selectAll').on('change', function() {
			const isChecked = $(this).is(':checked');
			// 모든 하위 체크박스를 전체 동의 체크박스 상태로 설정
			$('.required').prop('checked', isChecked);
		});

		// 개별 체크박스 클릭 이벤트
		$('.required').on('change', function() {
			const total = $('.required').length;
			const checked = $('.required:checked').length;

			$('#selectAll').prop('checked', total === checked);
		});

		// "다음" 버튼 클릭 이벤트
		$('#nextBtn').on('click', function() {
			const total = $('.required').length;
			const checked = $('.required:checked').length;

			if (total !== checked) {
				alert('필수 항목을 모두 체크해주세요.');
				return;
			}

			// 모든 필수 항목이 체크된 경우 다음 페이지로 이동
			location.href = "/member/joinFrm";
		});
	});
</script>
</head>

<body>
	<!-- 헤더 -->
	<c:import url="../common/jsp/header.jsp" />
	<!-- 약관 컨텐츠 -->
	<div class="container bg-white">
		<div style="text-align: center">
			<img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고"
				id="logo" style="display: block; margin: 0 auto;">
			<p class="text-muted">로그인/회원가입</p>
		</div>

		<h3 style="margin-top: 20px">
			초면에 실례지만,<br>약관동의가 필요해요.
		</h3>
		<div class="d-grid" style="margin-top: 50px">

			<!-- 전체 동의 -->
			<div class="form-check my-2">
				<input type="checkbox" class="form-check-input" id="selectAll">
				<label class="form-check-label fw-bold" for="selectAll">약관
					전체동의 (선택항목 포함)</label>
			</div>

			<!-- 개별 항목 1 -->
			<div class="form-check my-2">
				<input type="checkbox" class="required form-check-input" id="term1">
				<label class="form-check-label" for="term1">(필수) 이용약관</label>
				<button class="btn btn-link btn-sm ms-2 p-0" type="button"
					data-bs-toggle="collapse" data-bs-target="#term1Content"
					aria-expanded="false" aria-controls="term1Content">보기</button>
				<div class="collapse mt-2" id="term1Content">
					<div class="card card-body">
  <strong>제1조 (목적)</strong><br>
            본 약관은 [서비스 이름](이하 "회사")가 제공하는 서비스의 이용조건 및 절차, 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.<br><br>
            
            <strong>제2조 (정의)</strong><br>
            - <strong>서비스:</strong> 회사가 제공하는 온라인 및 오프라인 모든 서비스<br>
            - <strong>회원:</strong> 회사와 서비스 이용계약을 체결하고 회원 ID를 부여받은 자<br>
            - <strong>이용자:</strong> 회원 및 비회원을 포함한 모든 서비스 이용자<br><br>
            
            <strong>제3조 (회원가입)</strong><br>
            - 이용자는 회사의 요구에 따라 정확한 정보를 제공해야 합니다.<br>
            - 타인의 명의를 도용하거나 허위 정보를 제공할 경우 서비스 이용이 제한될 수 있습니다.<br><br>
            
         
</div>
				</div>
			</div>

			<!-- 개별 항목 2 -->
			<div class="form-check my-2">
				<input type="checkbox" class="required form-check-input" id="term2">
				<label class="form-check-label" for="term2">(필수) 만 14세 이상 확인</label>
				<button class="btn btn-link btn-sm ms-2 p-0" type="button"
					data-bs-toggle="collapse" data-bs-target="#term2Content"
					aria-expanded="false" aria-controls="term2Content">보기</button>
				<div class="collapse mt-2" id="term2Content">
					<div class="card card-body">
					
				  <strong>제1조 (대상)</strong><br>
            본 서비스는 만 14세 이상인 사용자만 이용할 수 있습니다.<br><br>
            
            <strong>제2조 (확인 및 제한)</strong><br>
            - 회원가입 시 본인이 만 14세 이상임을 확인해야 합니다.<br>
            - 만 14세 미만 사용자의 가입은 제한됩니다.<br><br>
            
            <strong>제3조 (허위 정보)</strong><br>
            - 만 14세 미만 사용자가 허위로 정보를 입력하거나 가입한 경우, 서비스 이용은 즉시 중단되며 관련 정보는 삭제됩니다.<br><br>
            
            <strong>제4조 (추가 확인)</strong><br>
            - 회사는 필요에 따라 만 14세 이상 여부를 확인하기 위해 추가 증빙 서류를 요청할 수 있습니다.
					
					
					</div>
				</div>
			</div>

			<!-- 개별 항목 3 -->
			<div class="form-check my-2">
				<input type="checkbox" class="required form-check-input" id="term3">
				<label class="form-check-label" for="term3">(필수) 개인정보 수집 및
					이용 동의</label>
				<button class="btn btn-link btn-sm ms-2 p-0" type="button"
					data-bs-toggle="collapse" data-bs-target="#term3Content"
					aria-expanded="false" aria-controls="term3Content">보기</button>
				<div class="collapse mt-2" id="term3Content">
					<div class="card card-body">
				<strong>제1조 (개인정보의 수집 목적)</strong><br>
            - 회원가입 및 서비스 제공<br>
            - 고객 상담 및 불만 처리<br>
            - 맞춤형 서비스 제공<br><br>
            
            <strong>제2조 (수집하는 개인정보 항목)</strong><br>
            - <strong>필수 항목:</strong> 이름, 이메일, 휴대전화번호<br>
            - <strong>선택 항목:</strong> 생년월일, 주소<br><br>
            
            <strong>제3조 (보유 및 이용기간)</strong><br>
            - 회원 탈퇴 시 즉시 파기됩니다.<br>
            - 법령에 따라 일정 기간 보관이 필요한 경우 관련 법령을 따릅니다.<br><br>
						
						</div>
				</div>
			</div>

			<input type="button" class="btn btn-primary btn-lg frm" value="다음"
				id="nextBtn">
		</div>
	</div>
	<c:import url="../common/jsp/footer.jsp" />
</body>
</html>
