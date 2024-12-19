<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>롯데호텔 제주</title>
<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=89af08d7935e6d38b3851aaee5af05e2"></script>
<style>
.header {
	top: 0;
	left: 0;
	width: 100%;
	background-color: #f8f8f8;
	padding: 20px;
	text-align: center;
	z-index: 100;
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

.main-container {
	width: 80%;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
	align-items: center;
}

/* 이미지 섹션 스타일 */
.image-section {
	display: flex;
	justify-content: center;
	gap: 30px;
	margin-top: 20px;
	width: 100%;
}

.main-image-container {
	width: 65%;
	max-width: 1200px;
	height: 0;
	padding-bottom: 50%;
	position: relative;
}

.main-image {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 10px;
	position: absolute;
	top: 0;
	left: 0;
}

.sub-image-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	width: 30%;
	max-width: 500px;
}

.sub-image-container img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 10px;
}

/* 호텔 정보 스타일 */
.hotel-info {
	text-align: center;
	margin-top: 20px;
	display: flex;
	align-items: center;
	gap: 20px;
}

.hotel-logo {
	width: 60px; /* 로고 크기 */
	height: 60px;
	border-radius: 50%;
	object-fit: cover;
}

.hotel-name {
	font-size: 2em;
	font-weight: bold;
}

.hotel-category {
	font-size: 1.2em;
	color: gray;
}

/* 탭 네비게이션 스타일 */
.tab-navigation {
	margin-top: 30px;
	display: flex;
	justify-content: center;
	background-color: #fff;
	padding: 15px 0;
	width: 100%;
	position: sticky;
	top: 0;
	z-index: 10;
}

.tab-item {
	padding: 10px 20px;
	font-size: 1.1em;
	color: #000;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s, color 0.3s;
	margin: 0 10px;
}

.tab-item:hover {
	background-color: #f1f1f1;
}

.tab-item.active {
	font-weight: bold;
	color: #00BFFF;
}

/* 탭 섹션 스타일 */
.tab-section {
	width: 80%;
	margin-top: 20px;
	padding: 20px;
	border-top: 1px solid #ddd;
}

.tab-section h2 {
	font-size: 1.5em;
	margin-bottom: 15px;
}

.tab-section p {
	font-size: 1.1em;
	color: #555;
}

/* 객실 섹션 스타일 */
.room-section {
	width: 100%;
	margin: 0 auto;
	padding: 20px;
}

.room-option {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #f7f7f7;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.room-info {
	display: flex;
	gap: 20px;
}

.room-image img {
	width: 250px;
	height: 150px;
	object-fit: cover;
	border-radius: 10px;
}

.room-details {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.room-details h3 {
	font-size: 1.5em;
	font-weight: bold;
}

.room-times {
	font-size: 1em;
	color: #555;
}

.room-description {
	font-size: 0.9em;
	color: #888;
	margin-top: 5px;
}

.room-price-container {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
}

.room-price {
	font-size: 1.8em;
	font-weight: bold;
	color: #00BFFF;
	margin-bottom: 10px;
}

.room-select-button {
	padding: 10px 15px;
	background-color: #00BFFF;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 1em;
	cursor: pointer;
	transition: background-color 0.3s;
}

.room-select-button:hover {
	background-color: #009ACD;
}

.room-name {
	font-size: 1.5em;
	font-weight: bold;
}

.room-price {
	font-size: 1.2em;
	color: #00BFFF;
}

.room-detail-button, .room-select-button {
	padding: 8px 12px;
	font-size: 1em;
	color: white;
	background-color: #00BFFF;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.room-detail-button:hover, .room-select-button:hover {
	background-color: #009ACD;
}

.room-info {
	display: flex;
	align-items: center;
	gap: 15px; /* 이미지와 이름 사이에 여백을 추가 */
}

.room-detail-button {
	margin-left: 10px;
}

.room-price-container {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
}

.room-price {
	font-size: 1.2em;
	font-weight: bold;
	margin-bottom: 10px;
}

.room-select-button {
	font-size: 1em;
	margin-top: 10px;
}

.room-image img {
	width: 80px; /* 원하는 크기로 설정 */
	height: 80px; /* 원하는 크기로 설정 */
	object-fit: cover; /* 이미지가 비율을 유지하며 잘리도록 설정 */
	border-radius: 5px; /* 이미지 모서리 둥글게 */
}

.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background: white;
	padding: 20px;
	border-radius: 10px;
	width: 80%;
	max-width: 600px;
	position: relative;
}

.modal .close {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 1.5em;
	cursor: pointer;
}

.service-container {
	font-family: Arial, sans-serif;
	margin-top: 20px;
}

.service-container h3 {
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 15px;
}

.service-list {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
}

.service-item {
	display: flex;
	align-items: center;
	gap: 8px;
}

.service-item i {
	font-size: 24px; /* 아이콘 크기 */
	color: #333;
}

.service-item span {
	font-size: 1em;
	color: #333;
}

.room-details-section {
	width: 100%;
	margin: 0 auto;
	padding: 20px;
	background-color: #f8f8f8;
}

.room-option {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.room-name {
	font-size: 1.5em;
	font-weight: bold;
}

.room-price {
	font-size: 1.2em;
	color: #00BFFF;
}

.room-detail-link {
	font-size: 1em;
	color: #00BFFF;
	background: none;
	border: none;
	cursor: pointer;
	text-decoration: underline;
}

.room-price-container {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
}

.room-select-button {
	padding: 8px 12px;
	font-size: 1em;
	color: white;
	background-color: #00BFFF;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.room-select-button:hover {
	background-color: #009ACD;
}

/* 모달 스타일 */
.room-modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	justify-content: center;
	align-items: center;
}

.room-modal-content {
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	width: 60%;
	max-width: 600px;
	text-align: left;
}

.room-modal-content h3 {
	font-size: 2em;
	font-weight: bold;
}

.room-modal-content ul {
	list-style-type: disc;
	padding-left: 20px;
}

.close-btn {
	font-size: 2em;
	position: absolute;
	top: 10px;
	right: 10px;
	cursor: pointer;
}

/* 모달을 띄울 때 */
.room-modal.open {
	display: flex;
}

#reviews {
	background-color: white;
	width: 80%;
	margin: 30px auto;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

#reviews h2 {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 15px;
	color: #333;
}

#reviews p {
	font-size: 16px;
	color: #666;
	line-height: 1.5;
}

.review-card {
	display: flex;
	flex-direction: column;
	background-color: #f9f9f9;
	padding: 15px;
	margin-bottom: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.review-card:last-child {
	margin-bottom: 0;
}

.review-header {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.review-header .star-rating {
	color: #ffbf00;
	font-size: 18px;
	margin-right: 10px;
}

.review-header .author {
	font-size: 16px;
	font-weight: bold;
	margin-right: 10px;
}

.review-header .date {
	color: #888;
	font-size: 14px;
}

.review-content {
	font-size: 14px;
	color: #444;
	line-height: 1.6;
	margin-bottom: 10px;
}

.review-images {
	display: flex;
	gap: 10px;
}

.review-images img {
	width: 32%;
	border-radius: 8px;
	object-fit: cover;
}

.review-footer {
	font-size: 14px;
	color: #555;
}

.sort-dropdown {
	display: flex;
	justify-content: flex-end; /* 오른쪽 정렬 */
	margin-bottom: 20px;
}

.sort-label {
	margin-right: 8px;
	font-size: 14px;
	font-weight: bold;
}

.sort-select {
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 4px;
	cursor: pointer;
}
</style>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

</head>
<body>
	<header class="header">
		<jsp:include page="../common/jsp/header.jsp" />


	</header>

	<main class="main-container">
		<!-- 이미지 섹션 -->
		<section class="image-section">
			<div class="main-image-container">
				<img src="1.jpg" alt="메인 이미지" class="main-image">
			</div>
			<div class="sub-image-container">
				<img src="1.jpg" alt="서브 이미지 1"> <img src="2.jpg"
					alt="서브 이미지 2"> <img src="3.jpg" alt="서브 이미지 3"> <img
					src="4.jpg" alt="서브 이미지 4">
			</div>
		</section>

		<!-- 호텔 정보 -->
		<section class="hotel-info">
			<div>
				<h1 class="hotel-name">롯데호텔 제주</h1>
				<p class="hotel-category">호텔 · 5성급</p>
			</div>
		</section>

		<!-- 탭 네비게이션 -->
		<div class="tab-navigation">
			<div class="tab-item active" data-target="overview">개요</div>
			<div class="tab-item" data-target="rooms">객실</div>
			<div class="tab-item" data-target="services">서비스 및 부대시설</div>
			<div class="tab-item" data-target="location">위치</div>
			<div class="tab-item" data-target="reviews">리뷰</div>
		</div>

		<!-- 탭 섹션 -->
		<section id="overview" class="tab-section">
			<h2>개요</h2>
			<p>제주 롯데호텔은 아름다운 풍경과 고급스러운 서비스를 제공하는 5성급 호텔입니다...</p>
		</section>

		<section id="rooms" class="tab-section">
			<h2>객실</h2>
			<div class="room-option">
				<div class="room-info">
					<div class="room-image">
						<img src="room1.jpg" alt="디럭스룸">
					</div>
					<div class="room-details">
						<h3>디럭스 룸</h3>
						<div class="room-times">
							<span>입실 15:00</span> <span>퇴실 11:00</span>
						</div>
						<div class="room-description">
							<span>기준2인 / 최대3인 (유료)</span>
						</div>
					</div>
				</div>
				<div class="room-price-container">
					<button class="room-detail-link" onclick="openRoomModal()">객실
						상세</button>
					<div class="room-price">₩206,900</div>
					<button class="room-select-button">객실 예약</button>
				</div>
			</div>
			<div class="room-option">
				<div class="room-info">
					<div class="room-image">
						<img src="room2.jpg" alt="스위트룸">
					</div>
					<div class="room-details">
						<h3>스위트룸</h3>
						<div class="room-times">
							<span>입실 15:00</span> <span>퇴실 11:00</span>
						</div>
						<div class="room-description">
							<span>기준2인 / 최대3인 (유료)</span>
						</div>
					</div>
				</div>
				<div class="room-price-container">
					<button class="room-detail-link" onclick="openRoomModal()">객실
						상세</button>
					<div class="room-price">₩206,900</div>
					<button class="room-select-button">객실 예약</button>
				</div>
			</div>
			<div class="room-option">
				<div class="room-info">
					<div class="room-image">
						<img src="room3.jpg" alt="프리미엄룸">
					</div>
					<div class="room-details">
						<h3>프리미엄룸</h3>
						<div class="room-times">
							<span>입실 15:00</span> <span>퇴실 11:00</span>
						</div>
						<div class="room-description">
							<span>기준2인 / 최대3인 (유료)</span>
						</div>
					</div>
				</div>
				<div class="room-price-container">
					<button class="room-detail-link" onclick="openRoomModal()">객실
						상세</button>
					<div class="room-price">₩206,900</div>
					<button class="room-select-button">객실 예약</button>
				</div>
			</div>
		</section>


		<section id="services" class="tab-section">
			<h2>서비스 및 부대시설</h2>
			<div class="service-container">
				<div class="service-list">
					<div class="service-item">
						<i class="fas fa-dumbbell"></i> <span>피트니스</span>
					</div>
					<div class="service-item">
						<i class="fas fa-swimmer"></i> <span>수영장</span>
					</div>
					<div class="service-item">
						<i class="fas fa-wifi"></i> <span>무선인터넷</span>
					</div>
					<div class="service-item">
						<i class="fas fa-smoking-ban"></i> <span>금연</span>
					</div>
					<div class="service-item">
						<i class="fas fa-tv"></i> <span>TV</span>
					</div>
					<div class="service-item">
						<i class="fas fa-cocktail"></i> <span>미니바</span>
					</div>
					<div class="service-item">
						<i class="fas fa-utensils"></i> <span>레스토랑</span>
					</div>
					<div class="service-item">
						<i class="fas fa-wheelchair"></i> <span>장애인편의</span>
					</div>
				</div>
			</div>


		</section>

		<section id="location" class="tab-section">
			<h2>위치</h2>
			<div id="map" style="width: 100%; height: 500px;"></div>
		</section>

		<section id="reviews" class="tab-section">
			<h2>리뷰</h2>
			<div class="review-card">
				<div class="sort-dropdown">
					<select id="sort-select" class="sort-select">
						<option value="recommend" selected>추천순</option>
						<option value="recent">최신순</option>
						<option value="high-rating">평점 높은순</option>
						<option value="low-rating">평점 낮은순</option>
					</select>
				</div>

				<div class="review-header">
					<div class="star-rating">⭐⭐⭐⭐⭐</div>
					<div class="author">여행좋아하는가족들</div>
					<div class="date">2개월 전</div>
				</div>
				<div class="review-content">
					<p>[오픈리뷰] [홀로린 특가] 디럭스 마운틴 더블</p>
					<p>롯데호텔 주변에 스타벅스, 편의점, 테디베어뮤지엄, 박물관이 살아있다, 런닝맨, 감골카트, 버디플래닛 칼곳이
						너무 많아요. 식당도 여러군데 있어서 골라가기 좋아요...</p>
				</div>
				<div class="review-images">
					<img src="image1.jpg" alt="리뷰 이미지 1"> <img src="image2.jpg"
						alt="리뷰 이미지 2"> <img src="image3.jpg" alt="리뷰 이미지 3">
				</div>
				<div class="review-footer">
					<p>4명이 이 리뷰를 추천했어요</p>
				</div>
			</div>

		</section>

	</main>

	<footer class="footer">
		<jsp:include page="../common/jsp/footer.jsp" />
	</footer>

	<!-- 객실 상세 모달 팝업 -->

	<script>
        // 탭 클릭 시 활성화
        document.querySelectorAll('.tab-item').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.tab-item').forEach(item => {
                    item.classList.remove('active');
                });

                this.classList.add('active');

                const targetId = this.getAttribute('data-target');
                const targetElement = document.getElementById(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 100,
                        behavior: 'smooth'
                    });
                }
            });
        });
        function openRoomModal() {
            const modal = document.getElementById('room-modal');
            modal.classList.add('open');
        }

        // 모달 닫기
        function closeRoomModal() {
            const modal = document.getElementById('room-modal');
            modal.classList.remove('open');
        }

        // 탭 클릭 시 활성화
        document.querySelectorAll('.tab-item').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.tab-item').forEach(item => {
                    item.classList.remove('active');
                });

                this.classList.add('active');

                const targetId = this.getAttribute('data-target');
                const targetElement = document.getElementById(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 100,
                        behavior: 'smooth'
                    });
                }
            });
        });
        $(function() {
            // 탭 네비게이션 기능
            function openTab(tabName) {
                const tabs = document.querySelectorAll('.tab-content');
                tabs.forEach(tab => tab.style.display = 'none');
                const activeTab = document.getElementById(tabName);
                activeTab.style.display = 'block';
            }

            
        });
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = { 
            center: new kakao.maps.LatLng(33.2484468, 126.4106058), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };
        
    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 마커가 표시될 위치입니다 
    var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 

    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        position: markerPosition
    });

    // 마커가 지도 위에 표시되도록 설정합니다
    marker.setMap(map);

    </script>
</body>
</html>
