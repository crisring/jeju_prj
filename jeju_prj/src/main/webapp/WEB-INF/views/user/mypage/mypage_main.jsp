<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주어때</title>

<!-- bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- bootstrap CDN 끝 -->
<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>




<style type="text/css">

/* 기본 스타일 */
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

/* 화면 너비가 1200px 이하일 때 */
@media screen and (max-width: 1200px) {
	#main {
		width: 90%;
		margin: 50px auto;
	}
	form .form-control {
		width: 100%; /* 입력 필드 너비를 100%로 조정 */
	}
}

/* 화면 너비가 768px 이하일 때 */
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

/* 화면 너비가 480px 이하일 때 */
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
$(function(){
} );//ready

</script>
<script>
function setActive(element) {
  // 모든 버튼에서 active 클래스 제거
  document.querySelectorAll("#sidebar .btn-outline-secondary").forEach((btn) => {
    btn.classList.remove("active");
  });

  // 클릭된 버튼에 active 클래스 추가
  element.classList.add("active");
}
</script>
</head>

<body>


	<div id="wrap">


		<div id="header">
			<jsp:include page="../common/jsp/header.jsp" />
		</div>
		<!-- sidebar import -->
		<jsp:include page="../common/jsp/mypage_sidebar.jsp" />



		<div id="main">
			<h5 class="bold">내 정보 관리</h5>
			<p class="bold">회원정보</p>
			<p>회원정보를 수정할 수 있어요</p>

			<form>

				<!-- 첫 번째 행 -->
				<div class="row mb-3">
					<div class="col-md-6">
						<label for="id" class="form-label">아이디</label> <input type="text"
							class="form-control w-75" id="id" placeholder="예시 아이디">
					</div>
					<div class="col-md-6">
						<label for="name" class="form-label">예약자 이름</label> <input
							type="text" class="form-control w-75" id="name"
							placeholder="예시 이름">
					</div>
				</div>

				<!-- 두 번째 행 -->
				<div class="row mb-3">
					<div class="col-md-6">
						<label for="tel" class="form-label">휴대폰 번호</label> <input
							type="text" class="form-control w-75" id="tel"
							placeholder="예시 전화번호">
					</div>
					<div class="col-md-6">
						<label for="birthdate" class="form-label">생년월일</label> <input
							type="date" class="form-control w-75" id="birthdate">
					</div>
				</div>

				<!-- 세 번째 행 -->
				<div class="row mb-3">
					<div class="col-md-6 d-flex align-items-center">
						<label class="form-label me-3">성별</label>
						<div class="form-check form-check-inline">
							<input type="radio" class="form-check-input" id="genderM"
								name="gender" value="m"> <label
								class="form-check-label me-3" for="genderM">남성</label>
						</div>
						<div class="form-check form-check-inline">
							<input type="radio" class="form-check-input" id="genderF"
								name="gender" value="f"> <label class="form-check-label"
								for="genderF">여성</label>
						</div>
					</div>
					<div class="col-md-6 d-flex align-items-center justify-content-end">
						<input type="button" style="margin-right: 85px"
							class="btn btn-outline-primary btn-lg" value="정보 수정하기">
					</div>
				</div>
			</form>

			<div style="border-bottom: 1px solid #DEE2E6"></div>


			<div>
				<p>
					이용을 원하지 않으신가요? <a href="#">회원탈퇴</a> <span
						style="text-align: right;"> 비밀번호 <a href="#">변경하기</a></span>
				</p>

			</div>


		</div>






		<div id="footer">
			<!-- header import -->
			<jsp:include page="../common/jsp/footer.jsp" />

		</div>


	</div>





</body>
</html>