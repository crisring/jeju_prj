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
</style>
<script type="text/javascript">
$(function(){
	var mapContainer = document.getElementById('map'),
	mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667),
	    level: 10
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption);
	var marker = new kakao.maps.Marker({
		position: map.getCenter()
		});
	marker.setMap(map);
	
	var geocoder = new kakao.maps.services.Geocoder();
	
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		var latlng = mouseEvent.latLng;
		marker.setPosition(latlng);
	
		geocoder.coord2Address(latlng.getLng(), latlng.getLat(), function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var address = result[0].address.address_name;
		        document.getElementById('address').value = address;
		    }
		});
	});
	
	$("#addSubImageBtn").on("click", function() {
        const container = $("#subImageContainer");
        const newItem = $(`
            <div class="sub-image-item mb-3">
                <div class="row">
                    <div class="col-md-6">
                        <input type="file" class="form-control" name="subImages" accept="image/*">
                    </div>
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="subImageDescs" placeholder="이미지 설명">
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-danger btn-sm remove-sub-image">×</button>
                    </div>
                </div>
            </div>
        `);
        container.append(newItem);
    });

    // 동적으로 추가된 삭제 버튼에 대한 이벤트 처리
    $(document).on("click", ".remove-sub-image", function() {
        $(this).closest(".sub-image-item").remove();
    });

    // form submit 시 유효성 검사
    $("form").on("submit", function(e) {
        let isValid = true;
        
        $(".sub-image-item").each(function() {
            const fileInput = $(this).find("input[type='file']");
            const descInput = $(this).find("input[type='text']");
            
            // 파일만 있고 설명이 없거나, 설명만 있고 파일이 없는 경우
            if((fileInput.val() && !descInput.val()) || (!fileInput.val() && descInput.val())) {
                alert("서브이미지와 설명을 모두 입력해주세요.");
                isValid = false;
                return false;  // each 루프 종료
            }
        });
        
        if(!isValid) {
            e.preventDefault();  // 폼 제출 중단
            return false;
        }
    });
    
    
    $("form").on("submit", function(e) {
        // 빈 서브이미지 항목 제거
        $(".sub-image-item").each(function() {
            const fileInput = $(this).find("input[type='file']");
            const descInput = $(this).find("input[type='text']");
            
            if(fileInput.val() === "" && descInput.val() === "") {
                $(this).remove();
            }
        });
    });
});//ready

</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1 style="font-family: monospace, sans-serif;">숙소 등록</h1>
		<div class="add-container">
			<form action="addAccommodation" method="post">
				<div class="form-group">
					<label for="accName">숙소명 *</label> <input type="text" id="accName"
						name="accName" required>
				</div>

				<div class="form-group">
					<label for="accType">숙소유형</label> <select id="accType"
						name="accType">
						<option value="호텔 리조트">호텔 리조트</option>
						<option value="펜션 풀빌라">펜션 풀빌라</option>
						<option value="게하 한옥">게하 한옥</option>
						<option value="캠핑 글램핑">캠핑 글램핑</option>
						<option value="홈 빌라">홈 빌라</option>
					</select>
				</div>

				<div class="form-group">
					<label>위치 선택</label>
					<div id="map"></div>
				</div>

				<div class="form-group">
					<label for="address">주소</label> <input type="text" id="address"
						name="address" readonly>
				</div>

				<div class="form-group">
					<label for="addressDetail">상세주소</label> <input type="text"
						id="addressDetail" name="addressDetail">
				</div>

				<div class="form-group">
					<label>편의시설</label>
					<div class="facility-container border rounded p-3">
						<div class="row">
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="wifi"
										name="facilities" value="무선와이파이"> <label
										class="form-check-label" for="wifi">무선와이파이</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="aircon"
										name="facilities" value="에어컨"> <label
										class="form-check-label" for="aircon">에어컨</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="noSmoking"
										name="facilities" value="금연"> <label
										class="form-check-label" for="noSmoking">금연</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="tv"
										name="facilities" value="TV"> <label
										class="form-check-label" for="tv">TV</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="parking"
										name="facilities" value="주차장"> <label
										class="form-check-label" for="parking">주차장</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="lounge"
										name="facilities" value="라운지"> <label
										class="form-check-label" for="lounge">라운지</label>
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="bbq"
										name="facilities" value="바베큐"> <label
										class="form-check-label" for="bbq">바베큐</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="restaurant"
										name="facilities" value="레스토랑"> <label
										class="form-check-label" for="restaurant">레스토랑</label>
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="shower"
										name="facilities" value="샤워실"> <label
										class="form-check-label" for="shower">샤워실</label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label for="description">숙소설명</label>
					<textarea class="form-control" id="description" name="description"
						rows="5"></textarea>
				</div>

				<div class="form-group">
					<label for="mainImage">대표이미지</label> <input type="file"
						class="form-control" id="mainImage" name="mainImage"
						accept="image/*">
				</div>

				<div class="form-group">
					<label>서브이미지</label>
					<div id="subImageContainer">
						<div class="sub-image-item mb-3">
							<div class="row">
								<div class="col-md-6">
									<input type="file" class="form-control" name="subImage"
										accept="image/*">
								</div>
								<div class="col-md-6">
									<input type="text" class="form-control" name="subImageDesc"
										placeholder="이미지 설명">
								</div>
							</div>
						</div>
					</div>
					<button type="button" class="btn btn-outline-secondary btn-sm mt-2"
						id="addSubImageBtn">+ 서브이미지 추가</button>
				</div>

				<div class="form-group">
					<label for="phone">숙소전화번호</label> <input type="text"
						class="form-control" id="phone" name="phone"
						placeholder="010-XXXX-XXXX" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
				</div>

				<button type="submit" class="btn btn-primary w-100">등록하기</button>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>