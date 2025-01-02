<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shotcut icon"
	href="http://192.168.10.218/jsp_prj/common/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="http://192.168.10.218/jsp_prj/common/css/main_20240911.css">
<!-- bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f5f5f5;
}

.container {
	max-width: 1000px;
	margin: 0 auto;
	background: white;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

input[type="text"], input[type="number"], textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 14px;
}

textarea {
	height: 150px;
	resize: vertical;
}

#map {
	width: 100%;
	height: 400px;
	margin-bottom: 20px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.image-upload {
	border: 2px dashed #ddd;
	padding: 20px;
	text-align: center;
	border-radius: 4px;
	cursor: pointer;
}

#imagePreview img {
	width: 150px;
	height: 150px;
	object-fit: cover;
	margin: 5px;
	border-radius: 4px;
}

.submit-btn {
	background-color: #ff3d3d;
	color: white;
	padding: 12px 24px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	width: 100%;
}

.error-message {
	color: #ff3d3d;
	font-size: 14px;
	margin-top: 5px;
	display: none;
}
</style>
<script type="text/javascript">
//기존 이미지 삭제 함수 수정
function deleteExistingImage(btn) {
    if(confirm('이미지를 삭제하시겠습니까?')) {
        $(btn).closest('.img-container').remove();
    }
}

$(function(){
    // 입/퇴실 시간 설정
    const checkIn = "${room.check_in}";
    const checkOut = "${room.check_out}";
    
    $("#check_in").val(checkIn);
    $("#check_out").val(checkOut);
    
    // 이미지 미리보기 함수
    function handleImagePreview(files) {
        var $preview = $('#imagePreview');

        $.each(files, function(i, file) {
            if (file.type.startsWith('image/')) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    // 이미지 컨테이너 생성
                    var $container = $('<div>', {
                        class: 'img-container',
                        css: {
                            display: 'inline-block',
                            position: 'relative',
                            margin: '5px'
                        }
                    });

                    // 이미지 생성
                    $('<img>', {
                        src: e.target.result,
                        css: {
                            maxWidth: '200px'
                        }
                    }).appendTo($container);

                    // 삭제 버튼 생성
                    $('<button>', {
                        text: '×',
                        class: 'delete-btn',
                        css: {
                            position: 'absolute',
                            top: '5px',
                            right: '5px',
                            backgroundColor: 'rgba(255, 0, 0, 0.7)',
                            color: 'white',
                            border: 'none',
                            borderRadius: '50%',
                            padding: '5px 10px',
                            cursor: 'pointer'
                        },
                        click: function(e) {
                            e.preventDefault();
                            $container.remove();
                            updateFileInput();
                        }
                    }).appendTo($container);

                    $container.appendTo($preview);
                };
                reader.readAsDataURL(file);
            }
        });
    }

    // FileList 업데이트 함수
    function updateFileInput() {
        const dataTransfer = new DataTransfer();
        const imgs = $('#imagePreview img');
        const currentFiles = $('#newImages')[0].files;
        
        // 현재 표시된 이미지들과 매칭되는 파일들을 유지
        const imgSrcs = Array.from(imgs).map(img => img.src);
        Array.from(currentFiles).forEach((file, index) => {
            if (imgSrcs.length > index) {
                dataTransfer.items.add(file);
            }
        });

        $('#newImages')[0].files = dataTransfer.files;
    }

    // input file 변경 이벤트
    $('#newImages').change(function() {
        const existingFiles = Array.from(this.files);
        handleImagePreview(existingFiles);
    });

    // 이미지 업로드 영역 클릭 이벤트
    $('#imageUpload').click(function() {
        $('#newImages').val(''); // input 초기화하여 같은 파일도 다시 선택 가능하게 함
        $('#newImages').trigger('click');
    });
    
    // 폼 제출 이벤트 핸들러
    $('#room_update').submit(function(e) {
        e.preventDefault();
        
        // 유효성 검사
        // 객실명
        if($("#room_name").val().trim() === "") {
            alert("객실명을 입력해주세요.");
            $("#room_name").focus();
            return false;
        }
        
        // 가격
        if($("#price").val().trim() === "") {
            alert("가격을 입력해주세요.");
            $("#price").focus();
            return false;
        }
        
        // 할인가
        if($("#discount_price").val().trim() === "") {
            alert("할인가를 입력해주세요.");
            $("#discount_price").focus();
            return false;
        }
        
        // 입실시간
        if($("#check_in").val().trim() === "") {
            alert("입실시간을 입력해주세요.");
            $("#check_in").focus();
            return false;
        }
        
        // 퇴실시간
        if($("#check_out").val().trim() === "") {
            alert("퇴실시간을 입력해주세요.");
            $("#check_out").focus();
            return false;
        }
        
        // 객실정보
        if($("input[name='check_info']").val().trim() === "") {
            alert("객실정보를 입력해주세요.");
            $("input[name='check_info']").focus();
            return false;
        }
        
        if($("input[name='capacity_info']").val().trim() === "") {
            alert("수용정보를 입력해주세요.");
            $("input[name='capacity_info']").focus();
            return false;
        }
        
        if($("input[name='beds_info']").val().trim() === "") {
            alert("침대정보를 입력해주세요.");
            $("input[name='beds_info']").focus();
            return false;
        }
        
        // 이미지 유효성 검사 (최소 1개 이상의 이미지가 있어야 함)
        const existingImagesCount = $('#existingImagePreview .img-container').length;
        const newImagesCount = $('#imagePreview .img-container').length;
        
        if(existingImagesCount + newImagesCount === 0) {
            alert("최소 1개 이상의 객실 이미지가 필요합니다.");
            return false;
        }
        
     	// 가격에서 쉼표와 '원' 제거하여 숫자만 추출
        let price = $('#price').val().replace(/,/g, '').replace('원', '');
        let discountPrice = $('#discount_price').val().replace(/,/g, '').replace('원', '');
        
        // 숫자만 남은 값으로 input value 재설정
        $('#price').val(price);
        $('#discount_price').val(discountPrice);
        
        // 현재 표시된 기존 이미지들의 정보만 포함
        const remainingImages = [];
        $('#existingImagePreview .img-container input[name="existingImages"]').each(function() {
            remainingImages.push($(this).val());
        });
        
        // 기존 이미지 목록 업데이트
        $('input[name="existingImages"]').remove();  // 기존 hidden input 제거
        remainingImages.forEach(img => {
            $('<input>').attr({
                type: 'hidden',
                name: 'existingImages',
                value: img
            }).appendTo(this);
        });
        
        // 시간 값 그대로 사용 (이미 HH:mm 형식이므로 변환 불필요)
        let checkIn = $('#check_in').val();
        let checkOut = $('#check_out').val();
        
        // 시간 값이 비어있다면 기본값 설정
        if(!checkIn) $('#check_in').val("${room.check_in}");
        if(!checkOut) $('#check_out').val("${room.check_out}");
        
        // 모든 유효성 검사 통과 시 폼 제출
        this.submit();
    });
});//ready
</script>
</head>
<body>
	<%
	request.setAttribute("contentPage", "../sample.jsp");
	%>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1>객실 상세정보</h1>

		<form id="room_update" name="room_update" action="/admin/room_update"
			method="post" enctype="multipart/form-data">
			<input type="hidden" name="room_id" value="${room.room_id}">
			<div class="form-group">
				<label for="name">객실명 *</label> <input type="text" id="room_name"
					name="room_name" value="${ room.room_name }" required>
				<div class="error-message" id="nameError">숙소명을 입력해주세요.</div>
			</div>

			<div class="form-group">
				<label for="price">가격</label> <input type="text" id="price"
					name="price"
					value="<fmt:formatNumber value='${room.price}' pattern='#,###'/>원">
			</div>
			<div class="form-group">
				<label for="discount_price">할인가</label> <input type="text"
					id="discount_price" name="discount_price"
					value="<fmt:formatNumber value='${room.discount_price}' pattern='#,###'/>원">
			</div>

			<div class="form-group">
				<label for="check_in">입실시간</label> <input type="time" id="check_in"
					name="check_in">
			</div>

			<div class="form-group">
				<label for="check_out">퇴실시간</label> <input type="time"
					id="check_out" name="check_out" value="11:00">
			</div>

			<div class="form-group">
				<label for="information">객실정보</label> * <input type="text"
					name="check_info" value="${room.check_info}"> * <input
					type="text" name="capacity_info" value="${room.capacity_info}">
				* <input type="text" name="beds_info" value="${room.beds_info}">
			</div>

			<div class="form-group">
				<label for="max_person">최대인원</label> <select id="max_person"
					name="max_person">
					<option value="1" ${room.max_person == 1 ? 'selected' : ''}>1</option>
					<option value="2" ${room.max_person == 2 ? 'selected' : ''}>2</option>
					<option value="3" ${room.max_person == 3 ? 'selected' : ''}>3</option>
					<option value="4" ${room.max_person == 4 ? 'selected' : ''}>4</option>
					<option value="5" ${room.max_person == 5 ? 'selected' : ''}>5</option>
					<option value="6" ${room.max_person == 6 ? 'selected' : ''}>6</option>
					<option value="7" ${room.max_person == 7 ? 'selected' : ''}>7</option>
					<option value="8" ${room.max_person == 8 ? 'selected' : ''}>8</option>
					<option value="9" ${room.max_person == 9 ? 'selected' : ''}>9</option>
					<option value="10" ${room.max_person == 10 ? 'selected' : ''}>10</option>
					<option value="11" ${room.max_person == 11 ? 'selected' : ''}>11</option>
					<option value="12" ${room.max_person == 12 ? 'selected' : ''}>12</option>
				</select> <span>명</span>
			</div>

			<div class="form-group">
				<label>객실 이미지</label>

				<%-- 기존 이미지 표시 영역 --%>
				<div id="existingImagePreview">
					<c:if test="${not empty room.img_name}">
						<c:forEach var="img" items="${room.img_name}">
							<div class="img-container"
								style="display: inline-block; position: relative; margin: 5px;">
								<img src="/common/admin/images/${img}" style="max-width: 200px;"
									alt="객실 이미지"> <input type="hidden" name="existingImages"
									value="${img}">
								<button class="delete-btn"
									style="position: absolute; top: 5px; right: 5px; background-color: rgba(255, 0, 0, 0.7); color: white; border: none; border-radius: 50%; padding: 5px 10px; cursor: pointer;"
									onclick="deleteExistingImage(this)">×</button>
							</div>
						</c:forEach>
					</c:if>
				</div>

				<%-- 새로운 이미지 업로드 영역 --%>
				<input type="file" id="newImages" name="newImages" multiple
					accept="image/*" style="display: none;">
				<div class="image-upload" id="imageUpload" style="cursor: pointer;">
					<p>클릭하여 사진을 선택하세요</p>
				</div>
				<div id="imagePreview"></div>
			</div>

			<input type="button" value="수정하기" class="submit-btn"
				onclick="$('#room_update').submit();">
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>