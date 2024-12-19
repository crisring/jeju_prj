<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${ site_kor }</title>
<link rel="shotcut icon" href="${ defaultURL }common/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="${ defaultURL }common/css/main_20240911.css">
<!-- bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- Kakao Map -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d8aac280d7e026f3090232cea95d60af&libraries=services"></script>

<style type="text/css">
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

.acc-container {
	width: 95%;
	margin: 5px auto;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.form-group input[type="text"], .form-group select {
	width: 100%;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

#map {
	width: 100%;
	height: 400px;
	margin-bottom: 10px;
	border: 1px solid #ddd;
}

.room-table {
	width: 100%;
	margin-top: 20px;
	border-collapse: collapse;
}

.room-table th, .room-table td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: center;
}

.room-table th {
	background-color: #f5f5f5;
}

.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.map-header {
	display: flex;
	align-items: center;
	gap: 10px;
}

.room-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

table a {
	text-decoration: none;
}
</style>

<script type="text/javascript">
	function toggleAllCheckboxes() {
		var mainCheckbox = document.getElementById('selectAll');
		var checkboxes = document.getElementsByClassName('room-checkbox');

		for (var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = mainCheckbox.checked;
		}
	}

	//객실 삭제 ajax
	function deleteSelectedRooms() {
		var selectedIds = [];
		$('.room-checkbox:checked').each(function() {
			selectedIds.push($(this).val());
		});

		if (selectedIds.length === 0) {
			alert('삭제할 객실을 선택해주세요.');
			return;
		}

		if (confirm('선택한 객실을 삭제하시겠습니까?')) {
			$.ajax({
				url : 'deleteRooms',
				type : 'POST',
				data : {
					roomIds : selectedIds
				},
				traditional : true,
				success : function(response) {
					if (response.success) {
						alert('선택한 객실이 삭제되었습니다.');
						location.reload(); // 페이지 새로고침
					} else {
						alert('객실 삭제 중 오류가 발생했습니다.');
					}
				},
				error : function() {
					alert('서버 통신 중 오류가 발생했습니다.');
				}
			});
		}
	}

	// 페이지 로드 시 실행
	$(function() {
		// 초기 지도 설정
		/*
		// DB에서 받아온 위도, 경도 값을 사용
		var latitude = ${accommodation.latitude};  // 숙소의 위도
		var longitude = ${accommodation.longitude};  // 숙소의 경도
		 */
		var latitude = '${accommodation.latitude}' || 33.450701; // 기본값 설정
		var longitude = '${accommodation.longitude}' || 126.570667;

		var mapContainer = document.getElementById('map'), mapOption = {
			/* 초기 중심좌표를 숙소의 좌표를 받아와서 설ㅈㅇ
			center: new kakao.maps.LatLng(latitude, longitude), */
			center : new kakao.maps.LatLng(latitude, longitude),
			level : 10
		};

		var map = new kakao.maps.Map(mapContainer, mapOption);
		var marker = new kakao.maps.Marker({
			position : map.getCenter()
		/* 마커를 db에서 받아온 곳으로 설정
		position: new kakao.maps.LatLng(latitude, longitude) */
		});
		marker.setMap(map);

		var geocoder = new kakao.maps.services.Geocoder();
		// 지도 수정 기능 초기에 비활성화
		var isMapEditable = false;

		// 지도 수정 버튼 클릭 이벤트
		$("#editMap").click(function() {
			isMapEditable = !isMapEditable;
			$(this).text(isMapEditable ? "완료" : "수정");
			$(this).toggleClass('btn-primary btn-outline-secondary');
		});

		// 지도 클릭 이벤트
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			if (!isMapEditable)
				return;

			var latlng = mouseEvent.latLng;
			marker.setPosition(latlng);

			/*
			// hidden 필드 업데이트 < 위도와 경도를 읽어서 저장할수 있게
			$('#latitude').val(latlng.getLat());
			$('#longitude').val(latlng.getLng());
			 */

			geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(
					result, status) {
				if (status === kakao.maps.services.Status.OK) {
					var address = result[0].address.address_name;
					$('#address').val(address);
				}
			});
		});
	});
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1 style="font-family: monospace, sans-serif;">숙소 상세정보</h1>
		<div class="detail-container">
			<form id="accForm" action="updateAccommodation" method="post"
				enctype="multipart/form-data">
				<!-- hidden fields -->
				<input type="hidden" id="latitude" name="latitude"
					value="${accommodation.latitude}"> <input type="hidden"
					id="longitude" name="longitude" value="${accommodation.longitude}">
				<input type="hidden" name="accId" value="${accommodation.accId}">

				<div class="form-group">
					<label for="accName">숙소명 *</label> <input type="text" id="accName"
						name="accName" value="${accommodation.accName}" required>
				</div>

				<div class="form-group">
					<label for="accType">숙소유형</label> <select id="accType"
						name="accType">
						<option value="호텔 리조트"
							${accommodation.accType == '호텔 리조트' ? 'selected' : ''}>호텔
							리조트</option>
						<option value="펜션 풀빌라"
							${accommodation.accType == '펜션 풀빌라' ? 'selected' : ''}>펜션
							풀빌라</option>
						<option value="게하 한옥"
							${accommodation.accType == '게하 한옥' ? 'selected' : ''}>게하
							한옥</option>
						<option value="캠핑 글램핑"
							${accommodation.accType == '캠핑 글램핑' ? 'selected' : ''}>캠핑
							글램핑</option>
						<option value="홈 빌라"
							${accommodation.accType == '홈 빌라' ? 'selected' : ''}>홈
							빌라</option>
					</select>
				</div>

				<div class="form-group">
					<div class="map-header">
						<label>위치 선택 *</label>
						<button type="button" class="btn btn-outline-secondary btn-sm"
							id="editMap">수정</button>
					</div>
					<div id="map"></div>
				</div>

				<div class="form-group">
					<label for="address">주소</label> <input type="text" id="address"
						name="address" value="${accommodation.address}" readonly>
				</div>

				<div class="form-group">
					<label for="addressDetail">상세주소</label> <input type="text"
						id="addressDetail" name="addressDetail"
						value="${accommodation.addressDetail}">
				</div>

				<div class="form-group">
					<label>편의시설</label>
					<div class="facility-container border rounded p-3">
						<div class="row">
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="wifi"
										name="facilities" value="무선와이파이"
										${accommodation.facilities.contains('무선와이파이') ? 'checked' : ''}>
									<label class="form-check-label" for="wifi">무선와이파이</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="aircon"
										name="facilities" value="에어컨"
										${accommodation.facilities.contains('에어컨') ? 'checked' : ''}>
									<label class="form-check-label" for="aircon">에어컨</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="noSmoking"
										name="facilities" value="금연"
										${accommodation.facilities.contains('금연') ? 'checked' : ''}>
									<label class="form-check-label" for="noSmoking">금연</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="tv"
										name="facilities" value="TV"
										${accommodation.facilities.contains('TV') ? 'checked' : ''}>
									<label class="form-check-label" for="tv">TV</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="parking"
										name="facilities" value="주차장"
										${accommodation.facilities.contains('주차장') ? 'checked' : ''}>
									<label class="form-check-label" for="parking">주차장</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="lounge"
										name="facilities" value="라운지"
										${accommodation.facilities.contains('라운지') ? 'checked' : ''}>
									<label class="form-check-label" for="lounge">라운지</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="bbq"
										name="facilities" value="바베큐"
										${accommodation.facilities.contains('바베큐') ? 'checked' : ''}>
									<label class="form-check-label" for="bbq">바베큐</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="restaurant"
										name="facilities" value="레스토랑"
										${accommodation.facilities.contains('레스토랑') ? 'checked' : ''}>
									<label class="form-check-label" for="restaurant">레스토랑</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="shower"
										name="facilities" value="샤워실"
										${accommodation.facilities.contains('샤워실') ? 'checked' : ''}>
									<label class="form-check-label" for="shower">샤워실</label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="description">숙소설명</label>
					<textarea class="form-control" id="description" name="description"
						rows="5">${accommodation.description}</textarea>
				</div>

				<div class="form-group">
					<label for="mainImage">대표이미지</label> <input type="file"
						class="form-control" id="mainImage" name="mainImage"
						accept="image/*">
					<c:if test="${not empty accommodation.mainImage}">
						<div class="mt-2">
							<img src="${accommodation.mainImage}" alt="현재 대표이미지"
								style="max-width: 200px;">
						</div>
					</c:if>
				</div>

				<div class="form-group">
					<label>서브이미지</label>
					<div id="subImageContainer">
						<c:choose>
							<c:when test="${not empty accommodation.subImages}">
								<c:forEach var="subImage" items="${accommodation.subImages}"
									varStatus="status">
									<div class="sub-image-item mb-3">
										<div class="row">
											<div class="col-md-6">
												<input type="file" class="form-control" name="subImages"
													accept="image/*">
												<c:if test="${not empty subImage.imagePath}">
													<div class="mt-2">
														<img src="${subImage.imagePath}" alt="서브이미지"
															style="max-width: 150px;">
													</div>
												</c:if>
											</div>
											<div class="col-md-6">
												<input type="text" class="form-control" name="subImageDescs"
													value="${subImage.description}" placeholder="이미지 설명">
											</div>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="sub-image-item mb-3">
									<div class="row">
										<div class="col-md-6">
											<input type="file" class="form-control" name="subImages"
												accept="image/*">
										</div>
										<div class="col-md-6">
											<input type="text" class="form-control" name="subImageDescs"
												placeholder="이미지 설명">
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="form-group">
					<label for="phone">숙소전화번호</label> <input type="text"
						class="form-control" id="phone" name="phone"
						value="${accommodation.phone}" placeholder="010-XXXX-XXXX"
						pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
				</div>

				<div class="form-group">
					<div class="room-header">
						<h3>객실</h3>
						<div>
							<%-- <button type="button" class="btn btn-success" onclick="location.href='addRoom?accId=${accommodation.accId}'">객실 추가</button> --%>
							<button type="button" class="btn btn-success"
								onclick="location.href='add_room.jsp'">객실 추가</button>
							<button type="button" class="btn btn-danger"
								onclick="deleteSelectedRooms()">삭제</button>
						</div>
					</div>
					<div class="table-responsive">
						<table class="room-table">
							<thead>
								<tr>
									<th><input type="checkbox" id="selectAll"
										onclick="toggleAllCheckboxes()"></th>
									<th>번호</th>
									<th>이름</th>
									<th>가격</th>
									<th>입실시간</th>
									<th>퇴실시간</th>
									<th>객실정보</th>
									<th>편의시설</th>
								</tr>
							</thead>
							<tbody>
								<!-- 임시 데이터 -->
								<tr>
									<td><input type="checkbox" name="roomIds" value="1"
										class="room-checkbox"></td>
									<td>1</td>
									<td><a href="room_detail.jsp">슈페리어 트윈</a></td>
									<td>72,000</td>
									<td>16:00</td>
									<td>11:00</td>
									<td>싱글침대2개...</td>
									<td>침대,TV,에어컨...</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="roomIds" value="2"
										class="room-checkbox"></td>
									<td>2</td>
									<td>슈페리어 할리우드</td>
									<td>115,000</td>
									<td>16:00</td>
									<td>11:00</td>
									<td>싱글침대2개...</td>
									<td>침대,TV,에어컨...</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="roomIds" value="3"
										class="room-checkbox"></td>
									<td>3</td>
									<td>슈페리어 할리우드</td>
									<td>115,000</td>
									<td>16:00</td>
									<td>11:00</td>
									<td>싱글침대2개...</td>
									<td>침대,TV,에어컨...</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="button-group">
					<button <%-- type="submit"  --%>class="btn btn-primary">수정</button>
					<button type="button" class="btn btn-secondary"
						onclick="history.back()">뒤로</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>