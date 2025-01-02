<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

.file-name {
	display: block;
	margin-bottom: 8px;
	font-size: 14px;
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
	    const selectedRooms = [];
	    $('.room-checkbox:checked').each(function() {
	        selectedRooms.push($(this).val());
	    });
	
	    if(selectedRooms.length === 0) {
	        alert('삭제할 객실을 선택해주세요.');
	        return;
	    }
	
	    if(confirm('선택한 객실을 삭제하시겠습니까?')) {
	        $.ajax({
	            url: '/admin/removeRoom',
	            type: 'POST',
	            data: { roomIds: selectedRooms },
	            traditional: true,
	            success: function(response) {
	                if(response.success) {
	                    alert('선택한 객실이 삭제되었습니다.');
	                    location.reload();
	                } else {
	                    alert('객실 삭제 중 오류가 발생했습니다.');
	                }
	            },
	            error: function() {
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
		var latitude = '${acc.latitude}'; // 기본값 설정
		var longitude = '${acc.longitude}';

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

			// hidden 필드 업데이트 < 위도와 경도를 읽어서 저장할수 있게
			$('#latitude').val(latlng.getLat());
			$('#longitude').val(latlng.getLng());

			geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(
					result, status) {
				if (status === kakao.maps.services.Status.OK) {
					var address = result[0].address.address_name;
					$('#address').val(address);
				}
			});
		});
		
		// 기존 메인 이미지 삭제
	    $(document).on("click", ".remove-existing-main", function () {
	        $("#current_image").remove(); // 기존 이미지 제거
	        $(this).siblings(".file-name").remove(); // 이미지 이름 제거
	        $(this).siblings("input[name='main_img']").remove(); // 기존 이미지 hidden input 제거
	        $(this).remove(); // X 버튼 제거
	        $("#mainFile").val('').show(); // 파일 선택 필드 표시
	        $(".preview").hide(); // 미리보기 숨김
	    });

	    // 메인 이미지 파일 선택 시 미리보기
	    $(document).on('change', '#mainFile', function () {
	        const file = this.files[0];
	        if (file) {
	            const reader = new FileReader();
	            reader.onload = function (e) {
	                $("#preview_main_img").attr('src', e.target.result).show();
	                $(".file-name").text("선택된 파일: " + file.name);
	                $(".preview").show();
	            }
	            reader.readAsDataURL(file);
	        }
	    });

	 // 서브 이미지 삭제
	    $(document).on("click", ".remove-sub-image", function() {
	        const item = $(this).closest(".sub-image-item");
	        item.remove();  // 해당 항목 전체 삭제
	        
	        // 만약 서브이미지가 하나도 없다면 새로운 입력 폼 추가
	        if($("#subImageContainer").find(".sub-image-item").length === 0) {
	            const newItem = $(`
	                <div class="sub-image-item mb-3">
	                    <div class="row">
	                        <div class="col-md-6">
	                            <input type="file" class="form-control" name="subFiles" accept="image/*">
	                            <div class="mt-2">
	                                <img class="preview-sub-img" src="" alt="미리보기" style="max-width: 150px; display: none;">
	                            </div>
	                        </div>
	                        <div class="col-md-5">
	                            <input type="text" class="form-control" name="content" placeholder="이미지 설명">
	                        </div>
	                        <div class="col-md-1">
	                            <button type="button" class="btn btn-danger btn-sm remove-sub-image">×</button>
	                        </div>
	                    </div>
	                </div>
	            `);
	            $("#subImageContainer").append(newItem);
	        }
	    });

	    // 서브 이미지 추가 버튼 클릭
	    $("#addSubImageBtn").on("click", function () {
	        const container = $("#subImageContainer");
	        const newItem = $(`
	            <div class="sub-image-item mb-3">
	                <div class="row">
	                    <div class="col-md-6">
	                        <input type="file" class="form-control" name="subFiles" accept="image/*">
	                        <div class="mt-2">
	                            <img class="preview-sub-img" src="" alt="미리보기" style="max-width: 150px; display: none;">
	                        </div>
	                    </div>
	                    <div class="col-md-5">
	                        <input type="text" class="form-control" name="content" placeholder="이미지 설명">
	                    </div>
	                    <div class="col-md-1">
	                        <button type="button" class="btn btn-danger btn-sm remove-sub-image">×</button>
	                    </div>
	                </div>
	            </div>
	        `);
	        container.append(newItem);
	    });

	 	// 서브 이미지 파일 선택 시 미리보기 (이벤트 위임 방식으로 수정)
	    $(document).on("change", "input[name='subFiles']", function() {
	        const file = this.files[0];
	        const previewImg = $(this).siblings(".mt-2").find(".preview-sub-img");
	        if(file) {
	            const reader = new FileReader();
	            reader.onload = function(e) {
	                previewImg.attr("src", e.target.result).show();
	            };
	            reader.readAsDataURL(file);
	        } else {
	            previewImg.hide();
	        }
	    });
	});
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1 style="font-family: monospace, sans-serif;">숙소 상세정보</h1>
		<div class="detail-container">
			<form id="accForm" action="/admin/acc_modify" method="post"
				enctype="multipart/form-data">
				<!-- hidden fields -->
				<input type="hidden" id="latitude" name="latitude"
					value="${acc.latitude}"> <input type="hidden"
					id="longitude" name="longitude" value="${acc.longitude}"> <input
					type="hidden" name="acm_id" value="${acc.acm_id}">

				<div class="form-group">
					<label for="acm_name">숙소명 *</label> <input type="text"
						id="acm_name" name="acm_name" value="${acc.acm_name}" required>
				</div>

				<div class="form-group">
					<label for="acm_type">숙소유형</label> <select id="acm_type"
						name="acm_type_id">
						<option value="1" ${acc.acm_type_id == '1' ? 'selected' : ''}>호텔
							리조트</option>
						<option value="2" ${acc.acm_type_id == '2' ? 'selected' : ''}>펜션
							풀빌라</option>
						<option value="3" ${acc.acm_type_id == '3' ? 'selected' : ''}>게하
							한옥</option>
						<option value="4" ${acc.acm_type_id == '4' ? 'selected' : ''}>캠핑
							글램핑</option>
						<option value="5" ${acc.acm_type_id == '5' ? 'selected' : ''}>홈
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
						name="address" value="${acc.address}" readonly>
				</div>

				<div class="form-group">
					<label for="detail_address">상세주소</label> <input type="text"
						id="detail_address" name="detail_address"
						value="${acc.detail_address}">
				</div>

				<div class="form-group">
					<label>편의시설</label>
					<div class="facility-container border rounded p-3">
						<div class="row">
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="wifi"
										name="fcl_names" value="무선 와이파이"
										${acc.fcl_names.contains('무선 와이파이') ? 'checked' : ''}>
									<label class="form-check-label" for="wifi">무선 와이파이</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="aircon"
										name="fcl_names" value="에어컨"
										${acc.fcl_names.contains('에어컨') ? 'checked' : ''}> <label
										class="form-check-label" for="aircon">에어컨</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="noSmoking"
										name="fcl_names" value="금연"
										${acc.fcl_names.contains('금연') ? 'checked' : ''}> <label
										class="form-check-label" for="noSmoking">금연</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="tv"
										name="fcl_names" value="TV"
										${acc.fcl_names.contains('TV') ? 'checked' : ''}> <label
										class="form-check-label" for="tv">TV</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="parking"
										name="fcl_names" value="주차장"
										${acc.fcl_names.contains('주차장') ? 'checked' : ''}> <label
										class="form-check-label" for="parking">주차장</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="lounge"
										name="fcl_names" value="라운지"
										${acc.fcl_names.contains('라운지') ? 'checked' : ''}> <label
										class="form-check-label" for="lounge">라운지</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="bbq"
										name="fcl_names" value="바베큐"
										${acc.fcl_names.contains('바베큐') ? 'checked' : ''}> <label
										class="form-check-label" for="bbq">바베큐</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="restaurant"
										name="fcl_names" value="레스토랑"
										${acc.fcl_names.contains('레스토랑') ? 'checked' : ''}> <label
										class="form-check-label" for="restaurant">레스토랑</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="shower"
										name="fcl_names" value="샤워실"
										${acc.fcl_names.contains('샤워실') ? 'checked' : ''}> <label
										class="form-check-label" for="shower">샤워실</label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="description">숙소설명</label>
					<textarea class="form-control" id="description" name="description"
						rows="5">${acc.description}</textarea>
				</div>

				<!-- 메인이미지 -->
				<div class="form-group">
					<label for="mainFile">대표이미지</label>
					<div class="main-image-container">
						<c:if test="${not empty acc.main_img}">
							<!-- 기존 대표 이미지 표시 -->
							<div class="mb-2">
								<img id="current_image"
									src="/common/admin/images/${acc.main_img}" alt="대표이미지"
									style="max-width: 200px;">
								<div class="text-secondary file-name mt-1">현재 이미지:
									${acc.main_img}</div>
								<input type="hidden" name="main_img" value="${acc.main_img}">
								<button type="button"
									class="btn btn-danger btn-sm remove-existing-main">×</button>
							</div>
						</c:if>
						<input type="file" class="form-control mt-3" id="mainFile"
							name="mainFile" accept="image/*"
							style="display: ${not empty acc.main_img ? 'none' : 'block'};">
						<div class="preview mt-2" style="display: none;">
							<span class="text-secondary file-name"></span> <img
								id="preview_main_img" src="" alt="미리보기"
								style="max-width: 200px;">
						</div>
					</div>
				</div>

				<!-- 서브이미지 -->
				<div class="form-group">
					<label>서브이미지</label>
					<div id="subImageContainer">
						<c:forEach var="subImg" items="${acc.sub_img_names}"
							varStatus="status">
							<div class="sub-image-item mb-3">
								<div class="row">
									<div class="col-md-6">
										<!-- 파일 input은 처음에 숨김 -->
										<input type="file" class="form-control" name="subFiles"
											accept="image/*" style="display: none;">
										<!-- 현재 이미지 이름 표시 -->
										<div class="text-secondary mb-2">현재 파일: ${subImg}</div>
										<!-- 현재 이미지 표시 -->
										<img src="/common/admin/images/${subImg}" alt="서브이미지"
											style="max-width: 150px;"> <input type="hidden"
											name="existingSubFiles" value="${subImg}">
									</div>
									<div class="col-md-5">
										<input type="text" class="form-control" name="content"
											value="${acc.contents[status.index]}" placeholder="이미지 설명">
									</div>
									<div class="col-md-1">
										<button type="button"
											class="btn btn-danger btn-sm remove-sub-image">×</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<button type="button" class="btn btn-outline-secondary btn-sm mt-2"
						id="addSubImageBtn">+ 서브이미지 추가</button>
				</div>

				<div class="form-group">
					<label for="phone">숙소전화번호</label> <input type="text"
						class="form-control" id="admin_phone_number"
						name="admin_phone_number" value="${acc.admin_phone_number}"
						placeholder="010-XXXX-XXXX" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
				</div>

				<div class="form-group">
					<div class="room-header">
						<h3>객실</h3>
						<div>
							<%-- <button type="button" class="btn btn-success" onclick="location.href='addRoom?accId=${accommodation.accId}'">객실 추가</button> --%>
							<button type="button" class="btn btn-success"
								onclick="location.href='/admin/add_room?acm_id=${ acc.acm_id }'">객실
								추가</button>
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
								</tr>
							</thead>
							<tbody>
								<c:forEach var="room" items="${room}">
									<c:if test="${room.dlt_flag eq 'N'}">
										<tr>
											<td><input type="checkbox" name="dlt_flag"
												value="${room.room_id}" class="room-checkbox"></td>
											<td>${room.room_id}</td>
											<td><a href="/admin/room_detail?room_id=${room.room_id}">${room.room_name}</a></td>
											<td><c:choose>
													<c:when test="${room.discount_price != null}">
														<fmt:formatNumber pattern="#,###"
															value="${room.discount_price}" />원
                    								</c:when>
													<c:otherwise>
														<fmt:formatNumber pattern="#,###" value="${room.price}" />원
                    								</c:otherwise>
												</c:choose></td>
											<td>${room.check_in}</td>
											<td>${room.check_out}</td>
											<td>${room.max_person}인기준</td>
										</tr>
									</c:if>
								</c:forEach>
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