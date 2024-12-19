<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>제주어때</title>

<link rel="stylesheet" type="text/css" href="css/user/jeju_main.css">
<link rel="stylesheet" type="text/css" href="css/user/jeju_main2.css">


<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
.slider-container {
	position: relative;
	width: 100%;
	max-width: 1399px;
	margin: 0 auto;
	overflow: hidden;
}

.slider {
	display: flex;
	transition: transform 0.5s ease;
	width: 100%;
}

.slide-group {
	display: flex;
	min-width: 100%;
}

.slide {
	width: 50%;
	position: relative;
	padding: 0 10px;
	overflow: hidden;
}

.slide img {
	width: 100%;
	height: 200px;
	object-fit: cover;
	position: relative;
	border-radius: 15px; /* 이미지 모서리 둥글게 처리 */
}

.slider-btn {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	background-color: rgba(0, 0, 0, 0.5);
	color: white;
	border: none;
	padding: 10px;
	cursor: pointer;
	z-index: 10;
}

.prev-btn {
	left: 10px;
}

.next-btn {
	right: 10px;
}

.dots {
	display: flex;
	justify-content: center;
	margin-top: 10px;
}

.dot {
	width: 10px;
	height: 10px;
	background-color: #ccc;
	border-radius: 50%;
	margin: 0 5px;
	cursor: pointer;
}

.dot.active {
	background-color: #333;
}
</style>

<script type="text/javascript">
	/* 메인화면 배경 전환 */
	$(function() {
		// 이미지 목록
		const images = [ 'main_1.jpg', 'main_2.jpg', 'main_3.jpg',
				'main_4.jpg', 'main_5.jpg' ];

		// 0부터 images.length-1까지 랜덤한 인덱스 선택
		const randomIndex = Math.floor(Math.random() * images.length);

		// hero 클래스를 가진 요소의 배경 이미지 변경
		$('.hero').css('background-image',
				'url("common/user/images/' + images[randomIndex] + '")');
	});
</script>

<!-- 이미지 슬라이더 -->
<script>
	$(function() {
		var $slider = $('.slider');
		var $slideGroups = $('.slide-group');
		var $prevBtn = $('.prev-btn');
		var $nextBtn = $('.next-btn');
		var $dotsContainer = $('.dots');

		// 도트 생성
		$slideGroups.each(function(index) {
			var $dot = $('<div class="dot"></div>');
			if (index === 0) {
				$dot.addClass('active');
			}
			$dot.on('click', function() {
				goToSlide(index);
				resetAutoSlide();
			});
			$dotsContainer.append($dot);
		});

		var $dots = $('.dot');
		var currentIndex = 0;

		function goToSlide(index) {
			// 활성 도트 업데이트
			$dots.removeClass('active');
			$dots.eq(index).addClass('active');

			// 슬라이더 이동
			$slider.css('transform', 'translateX(-' + (index * 100) + '%)');
			currentIndex = index;
		}

		// 자동 슬라이드 interval (3초)
		var autoSlideInterval = 3000;
		var autoSlideTimer;

		function autoSlide() {
			currentIndex = (currentIndex + 1) % $slideGroups.length;
			goToSlide(currentIndex);
		}

		function startAutoSlide() {
			if (autoSlideTimer) {
				clearInterval(autoSlideTimer);
			}
			autoSlideTimer = setInterval(autoSlide, autoSlideInterval);
		}

		function resetAutoSlide() {
			clearInterval(autoSlideTimer);
			startAutoSlide();
		}

		// 다음 버튼
		$nextBtn.on('click', function() {
			currentIndex = (currentIndex + 1) % $slideGroups.length;
			goToSlide(currentIndex);
			resetAutoSlide();
		});

		// 이전 버튼
		$prevBtn.on('click', function() {
			currentIndex = (currentIndex - 1 + $slideGroups.length)
					% $slideGroups.length;
			goToSlide(currentIndex);
			resetAutoSlide();
		});

		// 페이지 로드 시 자동 슬라이딩 시작
		startAutoSlide();

	})
</script>


<script type="text/javascript">
	function newPage(url) {
		window.open(url);
	}
</script>

<!-- 날씨 -->
<script type='text/javascript'>
	(function(d, w, t, k) {
		function l() {
			if (typeof (w._MIOB_) == 'undefined') {
				w._MIOB_ = {};
			}
			var m = w._MIOB_[t] = k;
			var s = d.createElement('script');
			m.p = ('https:' == d.location.protocol ? 'https:' : 'http:');
			s.type = 'text/javascript';
			s.async = true;
			s.src = m.p + '//info.meteotrend.com/mt/' + m.t + '.js';
			d.body.appendChild(s);
		}
		if (d.readyState == 'complete')
			l();
		else {
			if (w.attachEvent)
				w.attachEvent('onload', l);
			else
				w.addEventListener('load', l, false);
		}
	})
			(
					document,
					window,
					'82e80832482d45cbfee2dc3d6cb17fee',
					{
						t : '4x6',
						sw : {
							"pname" : 1,
							"ccond" : 1,
							"ccdesc" : 1,
							"dayblock" : 1,
							"tblank" : 1
						},
						css : [ '{p}//info.meteotrend.com/mt/{t}.css',
								'{p}//info.meteotrend.com/cs/d2e6236505ff2d231f9b6db9e1a56828f5a82206.css' ],
						source : 'meteotrend'
					});
</script>

<script type="text/javascript">
	$(function() {

		$("#search-button").click(function() {

			$("#searchFrm").submit();
		})

	})// ready
</script>


</head>
<body>

	<jsp:include page="user/common/jsp/header.jsp" />

	<div class="hero">
		<h1>제주도 여행할 땐 제주어때</h1>
		<div class="search-bar">
			<form action="/acm/searchProcess" id="searchFrm" name="searchFrm"
				method="get">
				<input type="text" placeholder="여행지나 숙소를 검색해보세요."> <input
					type="date" value="2024-11-28"> <input type="date"
					value="2024-11-29"> <input type="number" min="1" max="10"
					placeholder="인원수" id="people"> <input type="button"
					id="search-button" value="검색">
			</form>
		</div>
	</div>

	<section class="events">
		<h2>이벤트</h2>
		<div class="slider-container">
			<div class="slider">
				<div class="slide-group">
					<div class="slide">
						<img src="common/user/images/%EA%B4%91%EA%B3%A01.jpg"
							alt="이벤트 이미지">
					</div>
					<div class="slide">
						<img src="common/user/images/%EA%B4%91%EA%B3%A02.jpg"
							alt="이벤트 이미지">
					</div>
				</div>
				<div class="slide-group">
					<div class="slide">
						<img src="common/user/images/%EA%B4%91%EA%B3%A03.jpg"
							alt="이벤트 이미지">
					</div>
					<div class="slide">
						<img src="common/user/images/%EA%B4%91%EA%B3%A04.jpg"
							alt="이벤트 이미지">
					</div>
				</div>
				<div class="slide-group">
					<div class="slide">
						<img src="common/user/images/%EA%B4%91%EA%B3%A05.jpg"
							alt="이벤트 이미지">
					</div>
					<div class="slide">
						<img src="common/user/images/%EA%B4%91%EA%B3%A06.png"
							alt="이벤트 이미지">
					</div>

				</div>


			</div>
			<button class="slider-btn prev-btn">◀</button>
			<button class="slider-btn next-btn">▶</button>
			<div class="dots"></div>
		</div>
	</section>

	<section class="events">
		<h2>제주 인기 여행지 Best5</h2>
		<div class="cards">
			<div class="card1">
				<a
					href="javascript:newPage('
					https://www.visitjeju.net/kr/detail/view?contentsid=CNTS_000000000020476')">
					<img alt="주상절리대"
					src="common/user/images/%EC%A3%BC%EC%83%81%EC%A0%88%EB%A6%AC%EB%8C%80.jpg">
				</a>
				<h3>주상절리대</h3>
			</div>
			<div class="card1">
				<a
					href="javascript:newPage('
					https://www.visitjeju.net/kr/detail/view?contentsid=CONT_000000000500685')">
					<img alt="한라산국립공원"
					src="common/user/images/%ED%95%9C%EB%9D%BC%EC%82%B0%EA%B5%AD%EB%A6%BD%EA%B3%B5%EC%9B%90.jpg">
				</a>
				<h3>한라산 국립공원</h3>
			</div>
			<div class="card1">
				<a
					href="javascript:newPage('
					https://www.visitjeju.net/kr/detail/view?contentsid=CONT_000000000500477')">
					<img alt="우도" src="common/user/images/%EC%9A%B0%EB%8F%84.jpg">
				</a>
				<h3>우도</h3>
			</div>
			<div class="card1">
				<a
					href="javascript:newPage('
					https://www.visitjeju.net/kr/detail/view?contentsid=CONT_000000000500182')">
					<img alt="만장굴"
					src="common/user/images/%EB%A7%8C%EC%9E%A5%EA%B5%B4.jpg">
				</a>
				<h3>만장굴</h3>
			</div>
			<div class="card1">
				<a
					href="javascript:newPage('
					https://www.visitjeju.net/kr/detail/view?contentsid=CONT_000000000500349')">
					<img alt="성산일출봉"
					src="common/user/images/%EC%84%B1%EC%82%B0%EC%9D%BC%EC%B6%9C%EB%B4%89.jpg">
				</a>
				<h3>성산 일출봉</h3>
			</div>
		</div>
	</section>

	<section class="weather-banner">
		<div class="weather-content">
			<h2>제주도 현재 날씨</h2>
			<div class="weather-info">
				<p id="temperature"></p>
				<p id="condition"></p>
				<img id="weather-icon" src="common/user/images/weather-icon.png">
			</div>
			<div id="_MI_82e80832482d45cbfee2dc3d6cb17fee">
				<a href="https://ko.meteotrend.com/">일기 예보</a>
			</div>

		</div>
	</section>


	<section class="promo-banner">
		<div class="promo-content">
			<div class="promo-text">
				<h2>제주로 떠나볼까요? 첫 예약 시 10% 할인!</h2>
				<p class="promo-description">제주어때 회원가입 후 첫 예약 시 10% 할인 혜택을
					제공합니다.</p>
				<a href="#" class="promo-button">로그인/회원가입</a>
			</div>
			<img src="common/user/images/elite_img_PC.png" alt="제주 여행 할인 배너"
				class="promo-image">
		</div>
	</section>


	<section class="hotel-banner">
		<h2>인기 제주도 호텔/리조트</h2>
		<div class="hotel-list">

			<c:forEach var="hotel" items="${list1}" varStatus="i">
				<c:if test="${i.index < 5}">
					<div class="hotel-card">
						<img src="common/user/images/${hotel.main_img }"
							alt="${hotel.main_img }" class="hotel-image" />
						<div class="hotel-info">
							<span class="hotel-type">호텔</span>
							<h3>${hotel.acm_name }</h3>
							<p>${hotel.detail_address }</p>
							<div class="hotel-rating">
								<span class="rating-score">★ ${hotel.rating }</span> <span
									class="rating-count">${hotel.reviewCnt }명 평가</span>
							</div>
							<p class="hotel-price">
								<c:choose>
									<c:when test="${hotel.discountPrice > 0}">
										<span class="coupon">할인가</span> ${hotel.discountPrice}원
										<span class="original-price">${hotel.price}원</span>
									</c:when>
									<c:otherwise>
										<span class="coupon">기본가</span> ${hotel.price}원
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</div>
				</c:if>
			</c:forEach>

		</div>
	</section>
	<br>
	<section class="hotel-banner">
		<h2>인기 제주도 펜션/풀빌라</h2>
		<div class="hotel-list">
			<%
			for (int i = 0; i < 5; i++) {
			%>
			<div class="hotel-card">
				<img
					src="common/user/images/%EA%B5%AC%EC%9B%94%ED%98%B8%ED%85%94%EB%B0%98%EC%9B%94.jpg"
					alt="구월 호텔반월" class="hotel-image" />
				<div class="hotel-info">
					<span class="hotel-type">호텔</span>
					<h3>구월 호텔반월</h3>
					<p>제주도공항에서 도보 14분</p>
					<div class="hotel-rating">
						<span class="rating-score">★ 9.5</span> <span class="rating-count">11,066명
							평가</span>
					</div>
					<p class="hotel-price">
						<span class="coupon">할인가</span> 40,500원 <span
							class="original-price">45,000원</span>
					</p>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</section>
	<br>
	<section class="hotel-banner">
		<h2>인기 제주도 캠핑/글램핑</h2>
		<div class="hotel-list">
			<%
			for (int i = 0; i < 5; i++) {
			%>
			<div class="hotel-card">
				<img
					src="common/user/images/%EA%B5%AC%EC%9B%94%ED%98%B8%ED%85%94%EB%B0%98%EC%9B%94.jpg"
					alt="구월 호텔반월" class="hotel-image" />
				<div class="hotel-info">
					<span class="hotel-type">호텔</span>
					<h3>구월 호텔반월</h3>
					<p>제주도공항에서 도보 14분</p>
					<div class="hotel-rating">
						<span class="rating-score">★ 9.5</span> <span class="rating-count">11,066명
							평가</span>
					</div>
					<p class="hotel-price">
						<span class="coupon">할인가</span> 40,500원 <span
							class="original-price">45,000원</span>
					</p>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</section>
	<br>
	<section class="hotel-banner">
		<h2>인기 제주도 게하/한옥</h2>
		<div class="hotel-list">
			<%
			for (int i = 0; i < 5; i++) {
			%>
			<div class="hotel-card">
				<img
					src="common/user/images/%EA%B5%AC%EC%9B%94%ED%98%B8%ED%85%94%EB%B0%98%EC%9B%94.jpg"
					alt="구월 호텔반월" class="hotel-image" />
				<div class="hotel-info">
					<span class="hotel-type">호텔</span>
					<h3>구월 호텔반월</h3>
					<p>제주도공항에서 도보 14분</p>
					<div class="hotel-rating">
						<span class="rating-score">★ 9.5</span> <span class="rating-count">11,066명
							평가</span>
					</div>
					<p class="hotel-price">
						<span class="coupon">할인가</span> 40,500원 <span
							class="original-price">45,000원</span>
					</p>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</section>
	<br>
</body>

<jsp:include page="user/common/jsp/footer.jsp" />


</html>
