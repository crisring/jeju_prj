<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%-- ${ site_kor } --%>예약상세
</title>
<%-- <link rel="shotcut icon" href="${ defaultURL }common/images/favicon.ico"/>
<link rel="stylesheet" type="text/css" href="${ defaultURL }common/css/main_20240911.css">
 --%>
<!-- bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- 다음맵 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d8aac280d7e026f3090232cea95d60af&libraries=services"></script>

<style type="text/css">
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 10px;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.container {
	flex: 1;
	background-color: #fff;
	padding: 20px;
	width: 100%;
	max-width: 1200px;
	margin: 0 auto;
}

.rd-container {
	width: 95%;
	margin: 5px auto;
	display: flex;
	flex-direction: row;
	gap: 20px;
	align-items: flex-start;
}

.left-section {
	flex: 1;
	padding: 20px;
	max-width: 450px;
	min-width: 400px;
}

.right-section {
	flex: 1;
	padding: 20px;
	min-width: 400px;
}

.accommodation-image {
	width: 100%;
	height: 300px;
	object-fit: cover;
	margin-bottom: 20px;
}

.info-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	font-size: 14px;
}

.info-table th, .info-table td {
	padding: 12px;
	border: 1px solid #ddd;
	min-width: 150px;
	max-width: 200px;
}

.info-table th {
	background-color: #f8f9fa;
	font-weight: bold;
	text-align: center;
}

.info-table td {
	color: #666;
	text-align: center;
}

#map {
	width: 100%;
	height: 500px;
}

.button-wrapper {
	text-align: center;
}

.back-button {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	margin-top: 20px;
}

.back-button:hover {
	background-color: #0056b3;
}
</style>
<script type="text/javascript">
	$(function() {

	});//ready
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1>예약 상세 정보</h1>
		<div class="rd-container">
			<div class="left-section">
				<%
				// TODO: DB에서 예약 정보 가져오기
				// ReservationDTO reservation = reservationService.getReservationDetail(reservationId);

				// 테스트용 가데이터
				String imageUrl = "ferris_wheel_house.jpg";
				String accommodationName = "Ferris wheel house";
				String roomName = "홍길동";
				String checkIn = "2022-06-04";
				String checkOut = "2022-06-05";
				int guests = 2;
				int price = 74000;
				String address = "울산광역시 남구 삼산동 1617-1";
				String reservationStatus = "예약완료";
				String guestName = "홍길동";
				String guestPhone = "010-1111-2222";
				String hostPhone = "010-1234-5678";
				double latitude = 35.5383773; // 테스트용 위도
				double longitude = 129.3113596; // 테스트용 경도
				%>

				<table class="info-table">
					<tr>
						<td colspan="2"><img src="<%=imageUrl%>" alt="숙소 이미지"
							class="accommodation-image"></td>
					</tr>
					<tr>
						<th colspan="2">숙소 이름</th>
					</tr>
					<tr>
						<td colspan="2"><%=accommodationName%></td>
					</tr>

					<tr>
						<th>체크인</th>
						<th>체크아웃</th>
					</tr>
					<tr>
						<td><%=checkIn%></td>
						<td><%=checkOut%></td>
					</tr>

					<tr>
						<th>인원</th>
						<th>가격</th>
					</tr>
					<tr>
						<td><%=guests%>명</td>
						<td><%=price%>원</td>
					</tr>


					<tr>
						<th colspan="2">예약상태</th>
					</tr>
					<tr>
						<td colspan="2"><%=reservationStatus%></td>
					</tr>

					<tr>
						<th>예약자명</th>
						<th>예약자 연락처</th>
					</tr>
					<tr>
						<td><%=guestName%></td>
						<td><%=guestPhone%></td>
					</tr>

					<tr>
						<th colspan="2">숙소 연락처</th>
					</tr>
					<tr>
						<td colspan="2"><%=hostPhone%></td>
					</tr>

				</table>
				<div class="button-wrapper">
					<a href="reservation_list.jsp" class="back-button">뒤로가기</a>
				</div>
			</div>

			<div class="right-section">
				<table class="info-table">
					<tr>
						<td id="map"></td>
					</tr>
					<tr>
						<th>주소</th>
					</tr>
					<tr>
						<td><%=address%></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
	<script>
		var container = document.getElementById('map');
		var options = {
			center : new kakao.maps.LatLng(
	<%=latitude%>
		,
	<%=longitude%>
		),
			level : 3
		};

		var map = new kakao.maps.Map(container, options);

		// 마커 생성
		var markerPosition = new kakao.maps.LatLng(
	<%=latitude%>
		,
	<%=longitude%>
		);
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커를 지도에 표시
		marker.setMap(map);
	</script>
</body>
</html>