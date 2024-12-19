<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>숙소 검색</title>
<style>
/* Reset styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	padding-top: 60px; /* 헤더 높이만큼 여백 추가 */
	padding-bottom: 60px; /* 푸터 높이만큼 여백 추가 */
}

.header {
	top: 0;
	left: 0;
	width: 100%;
	background-color: #f8f8f8;
	padding: 20px;
	text-align: center;
	z-index: 100;
}

/* Main content */
.main-container {
	display: flex;
	justify-content: space-between;
	padding: 20px;
	margin-top: 80px; /* 헤더 높이만큼 여백 추가 */
	gap: 30px; /* 간격을 좀 더 넓게 설정 */
	width: 100%; /* 전체 너비를 100%로 설정 */
	margin-left: auto;
	margin-right: auto;
	flex-wrap: wrap; /* 화면 크기에 맞게 자동으로 줄 바꿈 */
	flex-grow: 1; /* 본문 콘텐츠가 남은 공간을 차지하도록 설정 */
}

/* Filter section */
.filter-container {
	width: 30%;
	padding: 20px;
	background-color: white;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	position: relative;
	max-height: calc(100vh - 120px); /* 헤더와 푸터를 제외한 높이 */
	overflow-y: auto;
	flex-shrink: 0;
}

.filter-container h2 {
	font-size: 20px;
	margin-bottom: 20px;
}

.filter {
	margin-bottom: 20px;
}

.filter h3 {
	margin-bottom: 10px;
	font-size: 18px;
}

.filter label {
	display: block;
	margin-bottom: 5px;
}

.price-range {
	width: 100%;
}

.facility-btn {
	background-color: #f0f0f0;
	border: 1px solid #ddd;
	padding: 10px;
	margin: 5px;
	cursor: pointer;
}

.facility-btn:hover {
	background-color: #ddd;
}

/* Accommodation list section */
.accommodation-list {
	width: 65%;
	padding: 20px;
	background-color: white;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	max-height: calc(100vh - 120px); /* 화면에서 헤더와 푸터를 제외한 공간 */
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	flex-grow: 1;
}

.accommodation-item {
	display: flex;
	margin-bottom: 20px;
	background-color: white;
	padding: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.accommodation-item img {
	width: 150px;
	height: 100px;
	object-fit: cover;
	margin-right: 20px;
}

.accommodation-details {
	flex-grow: 1;
}

.accommodation-details h3 {
	font-size: 18px;
	margin-bottom: 10px;
}

.accommodation-details p {
	margin-bottom: 5px;
}

.price-btn {
	background-color: #ff4d4d;
	color: white;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
}

.price-btn:hover {
	background-color: #e60000;
}

.footer {
	bottom: 0;
	left: 0;
	width: 100%;
	background-color: #f8f8f8;
	padding: 20px;
	text-align: center;
	z-index: 100;
}

/* 화면 크기별 스타일 */
@media screen and (max-width: 1024px) {
	.filter-container, .accommodation-list {
		width: 100%; /* 작은 화면에서 필터와 숙소 목록이 세로로 배치되도록 변경 */
	}
	.main-container {
		flex-direction: column; /* 화면 크기가 작아지면 세로로 배치 */
		gap: 0; /* 세로로 배치될 때 간격 제거 */
	}
	.accommodation-item img {
		width: 100%; /* 작은 화면에서 이미지가 세로로 표시되도록 설정 */
		height: auto;
		margin-right: 0;
	}
}
</style>
</head>
<body>

	<!-- 헤더 -->
	<header class="header">
		<jsp:include page="../common/jsp/header.jsp" />
	</header>

	<!-- 본문 콘텐츠 -->
	<main class="main-container">
		<!-- 왼쪽 필터 섹션 -->
		<section class="filter-container">
			<h2>필터</h2>
			<div class="filter">
				<label for="matching-location"> <input type="checkbox"
					id="matching-location"> 매칭 숙소 제외
				</label>
			</div>
			<div class="filter">
				<h3>숙소 유형</h3>
				<label><input type="radio" name="accommodation-type"
					value="호텔"> 호텔</label> <label><input type="radio"
					name="accommodation-type" value="리조트"> 리조트</label> <label><input
					type="radio" name="accommodation-type" value="펜션/풀빌라">
					펜션/풀빌라</label> <label><input type="radio" name="accommodation-type"
					value="게하/한옥"> 게하/한옥</label> <label><input type="radio"
					name="accommodation-type" value="캠핑/글램핑"> 캠핑/글램핑</label> <label><input
					type="radio" name="accommodation-type" value="홈 빌라"> 홈 빌라</label>
			</div>
			<div class="filter">
				<h3>가격</h3>
				<input type="range" min="0" max="500000" value="0"
					class="price-range" id="price-range">
				<p id="price-text">0원 - 500,000원 이상</p>
			</div>
			<div class="filter">
				<h2>시설</h2>
				<h3>공용 시설</h3>
				<!-- 버튼 클릭 시 하늘색으로 변경 -->
				<button class="facility-btn">레스토랑</button>
				<button class="facility-btn">라운지</button>
				<button class="facility-btn">바비큐</button>
				<button class="facility-btn">샤워실</button>
				<button class="facility-btn">주차장</button>
			</div>
			<div class="filter">
				<h3>객실 내 시설</h3>
				<!-- 버튼 클릭 시 하늘색으로 변경 -->
				<button class="facility-btn">무선와이파이</button>
				<button class="facility-btn">에어컨</button>
				<button class="facility-btn">금연</button>
				<button class="facility-btn">TV</button>
			</div>

		</section>

		<!-- 오른쪽 숙소 목록 섹션 -->
		<section class="accommodation-list">
			<h2>검색 결과</h2>
			<div class="accommodation-item">
				<img src="1.jpg" alt="롯데호텔 제주" class="accommodation-image">
				<div class="accommodation-details">
					<!-- 숙소 이름을 클릭하면 hotelDetail.jsp로 이동 -->
					<h3>
						<a href="hotelDetail.jsp?hotelId=1"
							style="text-decoration: none; color: inherit;">롯데호텔 제주</a>
					</h3>
					<p>서귀포시 · 중문관광단지 내</p>
					<p>9.6 ★ 952명 평가</p>
					<p>
						<strong>283,100원</strong>
					</p>
				</div>
			</div>
			<div class="accommodation-item">
				<img src="2.jpg" alt="제주신라호텔" class="accommodation-image">
				<div class="accommodation-details">
					<!-- 숙소 이름을 클릭하면 hotelDetail.jsp로 이동 -->
					<h3>
						<a href="hotelDetail.jsp?hotelId=2"
							style="text-decoration: none; color: inherit;">제주신라호텔</a>
					</h3>
					<p>서귀포시 · 서귀포시에서 차로 17분</p>
					<p>9.7 ★ 732명 평가</p>
					<p>
						<strong>310,000원</strong>
					</p>
				</div>
			</div>
		</section>

	</main>

	<!-- 푸터 -->
	<footer class="footer">
		<jsp:include page="../common/jsp/footer.jsp" />
	</footer>

	<script>
    // 가격 슬라이더와 텍스트 요소 가져오기
    const priceRange = document.getElementById("price-range");
    const priceText = document.getElementById("price-text");

    // 슬라이더 값 변경 시 가격 텍스트 업데이트
    priceRange.addEventListener("input", function () {
        const minPrice = 0; // 최소값
        const maxPrice = 500000; // 최대값
        const currentValue = Number(priceRange.value).toLocaleString(); // 현재 슬라이더 값, 천 단위 콤마 추가

        // 최대값 초과 여부에 따라 텍스트 설정
        if (priceRange.value < maxPrice) {
            priceText.textContent = `${minPrice.toLocaleString()}원 - ${currentValue}원`;
        } else {
            priceText.textContent = `${minPrice.toLocaleString()}원 - ${currentValue}원 이상`;
        }
    });
    const facilityButtons = document.querySelectorAll(".facility-btn");

    facilityButtons.forEach((btn) => {
        btn.addEventListener("click", () => {
            // 하늘색 토글: 활성화/비활성화
            if (btn.style.backgroundColor === "skyblue") {
                btn.style.backgroundColor = "#f0f0f0";
            } else {
                btn.style.backgroundColor = "skyblue";
            }
        });
    });

    // 페이지 로드 시 기본 텍스트 설정
    priceText.textContent = `0원 - 500,000원 이상`;
</script>

</body>
</html>
