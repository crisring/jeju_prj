<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주어때</title>

<!-- Bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- Bootstrap CDN 끝 -->

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- jQuery CDN 끝 -->

<style type="text/css">
/* 기존 스타일 유지 */
#main {
	width: 800px;
	height: auto; /* 높이를 자동으로 조정 */
	position: relative;
	margin-left: 630px;
	margin-top: 80px;
	margin-bottom: 80px;
}

form .form-control {
	width: 75%; /* 기본 너비 */
}

form label {
	font-weight: bold;
}

/* 반응형 스타일 유지 */
@media screen and (max-width: 1200px) {
	#main {
		width: 90%;
		margin: 50px auto;
	}
	form .form-control {
		width: 100%; /* 입력 필드 너비를 100%로 조정 */
	}
}

@media screen and (max-width: 768px) {
	#main {
		width: 100%;
		margin: 30px auto;
		padding: 10px; /* 내부 여백 추가 */
	}
	.row {
		flex-direction: column; /* 행을 세로 정렬 */
	}
	.row .col-md-6 {
		width: 100%; /* 각 열을 100%로 조정 */
		margin-bottom: 10px; /* 열 간격 추가 */
	}
	form label {
		margin-bottom: 5px;
	}
	.btn-outline-primary {
		width: 100%; /* 버튼 너비를 100%로 조정 */
		margin-right: 0; /* 오른쪽 여백 제거 */
	}
}

@media screen and (max-width: 480px) {
	body {
		font-size: 14px; /* 폰트 크기 축소 */
	}
	#main {
		padding: 0 10px;
	}
	.row .col-md-6 {
		padding: 0; /* 열 내부 패딩 제거 */
	}
	.btn-outline-primary {
		font-size: 12px; /* 버튼 폰트 크기 축소 */
	}
	p {
		font-size: 13px; /* 텍스트 크기 축소 */
	}
}

.bold {
	font-weight: bold;
}
</style>

<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		var birthInput = document.getElementById('birthdate');
		var birthValue = birthInput.value;
		if (birthValue && birthValue.length === 8) {
			var formattedBirth = birthValue.substring(0, 4) + '-'
					+ birthValue.substring(4, 6) + '-'
					+ birthValue.substring(6, 8);
			birthInput.value = formattedBirth;
		}
	});
</script>
</head>

<body>

	<div id="wrap">

		<div id="header">
			<jsp:include page="../common/jsp/header.jsp" />
		</div>
		<!-- Sidebar import -->
		<jsp:include page="../common/jsp/mypage_sidebar.jsp" />

		<div id="main">
			<h5 class="bold">내 정보 관리</h5>
			<p class="bold">회원정보</p>
			<p>회원정보를 수정할 수 있어요</p>

			<!--
            "수정하시겠습니까?"에서 확인 버튼을 누르면 폼 제출, 취소하면 제출 취소
        -->
			<form action="/mypage/modifyinfoProcess" method="post"
				onsubmit="return confirm('수정하시겠습니까?');">

				<!-- 첫 번째 행 -->
				<div class="row mb-3">
					<div class="col-md-6">
						<label for="id" class="form-label">아이디</label>
						<!-- 아이디(PK)는 수정 불가 -->
						<input type="text" class="form-control w-75" id="id"
							name="user_id" value="${user_info.user_id}" readonly>
					</div>
					<div class="col-md-6">
						<label for="name" class="form-label">예약자 이름</label> <input
							type="text" class="form-control w-75" id="name" name="user_name"
							value="${user_info.user_name}">
					</div>
				</div>

				<!-- 두 번째 행 -->
				<div class="row mb-3">
					<div class="col-md-6">
						<label for="tel" class="form-label">휴대폰 번호</label> <input
							type="text" class="form-control w-75" id="tel"
							name="phone_number" value="${user_info.phone_number}">
					</div>
					<div class="col-md-6">
						<label for="birthdate" class="form-label">생년월일</label> <input
							type="date" class="form-control w-75" id="birthdate" name="birth"
							value="${user_info.birth}">
					</div>
				</div>

				<!-- 세 번째 행 -->
				<div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label class="form-label me-3">성별</label>
						<div class="form-check form-check-inline">
							<input type="radio" class="form-check-input" id="genderM"
								name="gender" value="M"
								<c:if test="${user_info.gender == 'M'}">checked</c:if>>
							<label class="form-check-label me-3" for="genderM">남성</label>
						</div>
						<div class="form-check form-check-inline">
							<input type="radio" class="form-check-input" id="genderF"
								name="gender" value="W"
								<c:if test="${user_info.gender == 'W'}">checked</c:if>>
							<label class="form-check-label" for="genderF">여성</label>
						</div>
					</div>

					<!-- 수정 버튼 -->
					<div class="col-md-6 d-flex align-items-center justify-content-end">
						<!-- 확인 버튼을 누르면 폼 제출, 취소하면 제출 안 함 -->
						<input type="submit" style="margin-right: 85px"
							class="btn btn-outline-primary btn-lg" value="정보 수정하기">
					</div>
				</div>
			</form>

			<div style="border-bottom: 1px solid #DEE2E6"></div>

			<div>
				<p>
					이용을 원하지 않으신가요? <a href="/mypage/withdrawFrm">회원탈퇴</a> <span
						style="text-align: right;"> 비밀번호 <a
						href="/mypage/reset_pass">변경하기</a>
					</span>
				</p>
			</div>

		</div>
		<!-- end #main -->

		<div id="footer">
			<jsp:include page="../common/jsp/footer.jsp" />
		</div>

	</div>
	<!-- end #wrap -->
</body>
</html>
