<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
$(function(){
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
        const currentFiles = $('#images')[0].files;
        
        // 현재 표시된 이미지들과 매칭되는 파일들을 유지
        const imgSrcs = Array.from(imgs).map(img => img.src);
        Array.from(currentFiles).forEach((file, index) => {
            if (imgSrcs.length > index) {
                dataTransfer.items.add(file);
            }
        });

        $('#images')[0].files = dataTransfer.files;
    }

    // input file 변경 이벤트
    $('#images').change(function() {
        const existingFiles = Array.from(this.files);
        handleImagePreview(existingFiles);
    });

    // 이미지 업로드 영역 클릭 이벤트
    $('#imageUpload').click(function() {
        $('#images').val(''); // input 초기화하여 같은 파일도 다시 선택 가능하게 함
        $('#images').trigger('click');
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
		<h1>객실 추가</h1>

		<form id="accommodationForm">
			<div class="form-group">
				<label for="name">객실명 *</label> <input type="text" id="name"
					name="name" required>
				<div class="error-message" id="nameError">숙소명을 입력해주세요.</div>
			</div>

			<div class="form-group">
				<label for="price">가격</label> <input type="text" id="price"
					name="price">
			</div>
			<div class="form-group">
				<label for="discountPrice">할인가</label> <input type="text"
					id="discountPrice" name="discountPrice">
			</div>

			<div class="form-group">
				<label for="checkIn">입실시간</label> <input type="time" id="checkIn"
					name="checkIn" value="15:00">
			</div>

			<div class="form-group">
				<label for="checkOut">퇴실시간</label> <input type="time" id="checkOut"
					name="checkOut" value="11:00">
			</div>

			<div class="form-group">
				<label for="information">객실정보</label> * <input type="text"
					name="time" placeholder="숙박시간 | 체크인 15:00 - 체크아웃 11:00"> *
				<input type="text" name="count" placeholder="기준인원 | 2인기준 최대 3인">
				<input type="hidden" name="default"
					value="인원 추가시 비용이 발생되며, 현장에서 결제 바랍니다">
			</div>

			<div class="form-group">
				<label for="maxNum">최대인원</label> <select id="maxNum" name="maxNum">
					<option value="1">1
					<option value="2">2
					<option value="3">3
					<option value="4">4
					<option value="5">5
					<option value="6">6
					<option value="7">7
					<option value="8">8
					<option value="9">9
					<option value="10">10
					<option value="11">11
					<option value="12">12
				</select> <span>명</span>
			</div>

			<div class="form-group">
				<label>객실 이미지</label> <input type="file" id="images" name="images"
					multiple accept="image/*" style="display: none;">
				<div class="image-upload" id="imageUpload" style="cursor: pointer;">
					<p>클릭하여 사진을 선택하세요</p>
				</div>
				<div id="imagePreview"></div>
			</div>

			<button <%-- type="submit" --%> class="submit-btn">등록하기</button>
		</form>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>