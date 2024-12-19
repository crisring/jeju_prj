<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약관리</title>

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

/* 기존 스타일 유지 */
#main {
	width: 800px;
	min-height: 600px; /* 최소높이 보장  */
	position: relative;
	margin-left: 630px;
	margin-top: 80px;
	margin-bottom: 80px;
}

#frm {
	padding: 10px
}

.bold {
	font-weight: bold;
}

#emptyList {
	position: absolute;
	border: 1px solid #F5F7FA;
	width: 750px;
	height: 300px;
	margin-top: 15px;
	margin-left: 30px;
	box-shadow: 5px 5px 5px 5px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	/* Flexbox 설정 */
	display: flex;
	align-items: center; /* 세로 정렬 */
	justify-content: space-between; /* 요소 간 간격 */
}

.reservation {
	border: 1px solid #F5F7FA;
	width: 750px;
	height: 300px;
	margin-top: 15px;
	margin-left: 30px;
	box-shadow: 5px 5px 5px 5px rgba(0, 0, 0, 0.1);
	border-radius: 15px;
	overflow: hidden; /* 자식 요소를 부모 경계 안으로 제한 */
	/* Flexbox 설정 */
	display: flex;
	align-items: center; /* 세로 정렬 */
	justify-content: space-between; /* 요소 간 간격 */
}

.reservationImg {
	height: 100%;
	width: 30%;
	border-right: 1px solid #F5F7FA;
}

.reservationInfo {
	height: 100%;
	width: 70%;
	padding: 20px;
	padding-top: 40px;
}

.star {
	font-size: 24px;
	color: #ccc;
	cursor: pointer;
}

.star:hover, .star.selected {
	color: gold;
}

/* 모달 이미지 스타일 */
.modal-body img {
	max-width: 100%; /* 모달 너비를 넘지 않도록 */
	max-height: 90% height: auto; /* 비율을 유지하며 크기 조정 */
	display: block; /* 중앙 정렬을 위한 블록 요소 */
	margin: 0 auto; /* 이미지를 중앙에 정렬 */
}

/* 미디어 쿼리 적용 */
@media screen and (max-width: 1200px) {
	/* 전체 래퍼의 위치 조정 */
	#wrap {
		position: relative;
	}
	#main {
		position: relative;
		margin-left: auto;
		margin-right: auto;
		margin-top: 80px;
		margin-bottom: 80px;
		width: 90%;
	}

	/* 예약 카드의 크기 조정 */
	.reservation, #emptyList {
		width: 100%;
		margin-left: 0;
	}
}

@media screen and (max-width: 768px) {
	/* 사이드바와 메인 콘텐츠를 세로로 배치 */
	#wrap {
		display: block;
	}
	#sidebar {
		width: 100%;
		margin-top: 0;
	}
	#main {
		width: 100%;
		margin-top: 0;
	}

	/* 예약 카드의 레이아웃 변경 */
	.reservation {
		flex-direction: column;
		height: auto;
	}
	.reservationImg, .reservationInfo {
		width: 100%;
		height: auto;
	}
	.reservationImg {
		border-right: none;
		border-bottom: 1px solid #F5F7FA;
	}
	.reservationInfo {
		padding-top: 20px;
	}
}
</style>

<script type="text/javascript">
/*모달 별점구현 함수  */
$(document).ready(function () {
  // 별점 선택 로직
  $(".star").on("click", function () {
    const rating = $(this).data("value"); // 클릭한 별의 값 가져오기
    $(".star").each(function (index) {
      if (index < rating) {
        $(this).addClass("selected"); // 선택된 별들에 클래스 추가
      } else {
        $(this).removeClass("selected"); // 선택되지 않은 별들에서 클래스 제거
      }
    });
  });
});
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

		<!--header import  -->
		<jsp:include page="../common/jsp/header.jsp" />

		<!-- sidebar import -->
		<jsp:include page="../common/jsp/mypage_sidebar.jsp" />

		<div id="main">
			<h5 class="bold mb-4">예약 내역</h5>
			<p>예약 내역을 확인하고 취소할 수 있어요</p>

			<!-- 예약 내역이 없을 때 보여질 내용 -->


			<!-- 예약 내역의 존재 여부를 c:if로 물어보고 사용하면 될듯. -->
			<!-- <div id="emptyList" style="display: flex; align-items: center;">
              <div style="margin-top: 20px; margin-left: 20px;  width: 300px;">
                <h5>예정된 여행이 없습니다.</h5>
                <p>지금 새로운 여행을 시작해 보세요.</p>
                <a href="#" class="btn btn-primary btn-lmg">숙소 보러가기</a>
              </div>
              <img src="http://localhost/second_prj/common/images/reservation.png" style=" height: auto; margin-left: 20px; object-fit: contain;">
            </div>
             -->

			<div class="reservation">

				<div class="reservationImg">숙소 이미지 div</div>

				<div class="reservationInfo">

					<p>예약일자: xxxx년 xx월 xx일 부터 xxxx년 xx월 xx일 까지</p>
					<br>
					<p>예약자 명: xxx</p>
					<br>
					<p>결제금액: 0,000,000원</p>
					<br> <a href="#" class="review-link" data-bs-toggle="modal"
						data-bs-target="#reviewModal">리뷰 쓰러 가기(리뷰 작성 링크)</a>

				</div>
			</div>
		</div>
	</div>

	<div id="footer">
		<!-- footer import -->
		<jsp:include page="../common/jsp/footer.jsp" />

	</div>







	<!-- 모달 시작  -->
	<div class="modal fade" id="reviewModal" tabindex="-1"
		aria-labelledby="reviewModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="reviewModalLabel">리뷰쓰기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<img alt="숙소 이미지"
						src="http://localhost/second_prj/common/images/test.jpg">
					<p class="fw-bold">숙소명</p>
					<p>숙소는 만족하셨나요?</p>
					<div class="d-flex justify-content-center mb-3">
						<span class="star" data-value="1">★</span> <span class="star"
							data-value="2">★</span> <span class="star" data-value="3">★</span>
						<span class="star" data-value="4">★</span> <span class="star"
							data-value="5">★</span>
					</div>

					<textarea class="form-control"
						placeholder="어떤 점이 좋았나요? 최소 10자 이상 입력해주세요." rows="6"
						maxlength="5000"></textarea>
					<button class="btn btn-outline-secondary mt-3">사진 첨부하기</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary">등록</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

