<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

<link rel="stylesheet" type="text/css"
	href="/css/user/mypage_reservation.css">

<script type="text/javascript">

/* window.onload = function() {
    var msg = '${msg}';

    // sessionStorage 키를 확인
    if (msg && !sessionStorage.getItem('msgDisplayed')) {
        alert(msg);
        sessionStorage.setItem('msgDisplayed', 'true');
    }

}; */

</script>


<script type="text/javascript">
/*모달 별점구현 함수  */
$(function () {
	
	let letRating = 0; // 별점 값 저장 변수
	
	$(".star").on("click", function () {
	    const selectedRating = $(this).data("value"); // 클릭한 별의 값 가져오기
	    letRating = selectedRating; // 전역 변수에 저장
	    console.log("선택한 별점:", letRating);

	    $(".star").each(function (index) {
	        if (index < letRating) {
	            $(this).addClass("selected"); // 선택된 별들에 클래스 추가
	        } else {
	            $(this).removeClass("selected"); // 선택되지 않은 별들에서 클래스 제거
	        }
	    });
	});
	
	/* 취소신청 업데이트 AJAX */
	$("#btnCancel").click(function(){
		var rsr_id = $("#rsr_id").val();
		var data={ rsr_id:rsr_id };
		
		if(!confirm("취소하시겠습니까?")){
			return;
		}
		
		$.ajax({
			url:"/mypage/cancelReservation/"+rsr_id,
			type:"PUT", //@PutMapping("/{rsr_id}")
			data:data,
			dataType:"JSON",
			error:function( xhr ){
				alert( xhr.status );
			},
			success:function( jsonObj ){
				var outMsg=`취소 중 문제가 발생하였습니다.`;
				if( jsonObj.resultFlag ){
					outMsg=`취소되었습니다!`;
				}//end if
				
				alert(outMsg);
			}
		});//ajax

	})// click
	
	/* 리뷰 추가 */
	$("#btnAddReview").click(function () {

	    var rsr_id = $("#rsr_id").val();

	    // 내용 유효성 검사
	    if (!validateContent()) { 
	        return; 
	    } 

	    var content = $("#content").val();
	    var user_id = $('#user_id').val();    
	    var acm_id = $('#acm_id').val();
	    $('#rating').val(letRating); 

	    var rating = $('#rating').val();
	    
	 // 파일 유효성 검사
	    var img_names = validateImageFiles(); 
	    
	    if (img_names && img_names.length > 0) {
	        $("#uploadFrm").submit();
	    }
	}); // click




	}); // ready

	/* 내용 유효성 검사 */
	function validateContent() {
	    var flag = true; 
	    var content = $('#content').val();
	    
	    // 문자열 길이 확인
	    if (content.length < 10) {
	        alert('리뷰는 최소 10자 이상 입력해야 합니다!');
	        flag = false; 
	    }
	    
	    return flag; 
	}// validateContent


	
	
/* 유효성 검사 */
function validateImageFiles() {
	/* 파일 확장자 설정  */
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
    const fileInput = $('#upfile')[0];
    const files = fileInput.files;
    const filesArray = Array.from(files);
    
    
    if (filesArray.length > 3) {
        alert('최대 3개의 파일만 업로드 가능합니다.');
        $('#upfile').val('');
        return;
    }
    
    if (filesArray.length === 0) {
        alert('파일을 선택해주세요.');
        return;
    }
    
    const invalidFiles = filesArray.filter(file => !allowedTypes.includes(file.type));
    
    if (invalidFiles.length > 0) {
        const invalidFileNames = invalidFiles.map(file => file.name).join(', ');
        alert(`다음 파일은 이미지 파일이 아닙니다: ${invalidFileNames}\n\n이미지 파일(jpg, png, gif, webp)만 업로드 가능합니다.`);
        $('#upfile').val('');
        return false;
    }
    
    // 파일 이름만 추출하여 배열로 반환
    return filesArray.map(file => file.name);
}// validateImageFiles

</script>

<script type="text/javascript">

</script>

<style type="text/css">
.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
}

.pagination span {
	margin: 0 5px;
}

.prev, .next {
	font-weight: bold;
	color: #333;
	cursor: pointer;
}

.page-links a {
	text-decoration: none;
	color: #0056b3;
	font-weight: bold;
}

.page-links a:hover {
	color: #ff5722;
}

.page-links .active {
	color: #fff;
	background-color: #007bff;
	border-radius: 5px;
}

.page-links a:focus, .page-links a:hover {
	outline: none;
	color: #ff5722;
}

.page-links .active a {
	background-color: #004085;
}
</style>

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
			<c:if test="${ empty rsrList}">
				<div class="reservation">예약된 내용이 없습니다.</div>
			</c:if>

			<c:forEach var="list" items="${rsrList }" varStatus="i">
				<div class="reservation">
					<div class="reservationImg">
						<img src="/common/admin/images/${list.acm_main_img }"
							alt="${list.acm_main_img }" />
					</div>

					<div class="reservationInfo">
						<input type="hidden" id="rsr_id" name="rsr_id"
							value="${list.rsr_id }"> <Strong><c:out
								value="${list.acm_name } - ${list.room_name}" /></Strong><br> 예약일자:
						<fmt:formatDate value="${list.check_in_date }"
							pattern="yyyy년 MM월 dd일" />
						부터<br> <span style="padding-left: 73px;"> <fmt:formatDate
								value="${list.check_out_date }" pattern="yyyy년 MM월 dd일" /></span> 까지 <br>
						<br>
						<p>예약자 명: ${list.rsr_name }</p>
						<c:choose>
							<c:when test="${list.discount_price > 0 }">
								<p>
									결제금액:
									<c:choose>
										<c:when test="${list.discount_price < 100000}">
											<fmt:formatNumber pattern="00,000"
												value="${list.discount_price}" />
										</c:when>
										<c:otherwise>
											<fmt:formatNumber pattern="###,###"
												value="${list.discount_price}" />
										</c:otherwise>
									</c:choose>
									원
								</p>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${list.price > 0 }">
										<p>
											결제금액:
											<c:choose>
												<c:when test="${list.price < 100000}">
													<fmt:formatNumber pattern="00,000" value="${list.price}" />
												</c:when>
												<c:otherwise>
													<fmt:formatNumber pattern="###,###" value="${list.price}" />
												</c:otherwise>
											</c:choose>
											원
										</p>
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
						<input type="button" class="cancel-link" id="btnCancel"
							value="취소신청 하기">



					</div>
				</div>
			</c:forEach>

			<br>

			<h5 class="bold mb-4">이용완료 내역</h5>

			<c:forEach var="list" items="${rsrList2 }" varStatus="i">
				<div class="reservation">
					<div class="reservationImg">
						<img src="/common/admin/images/${list.acm_main_img }"
							alt="${list.acm_main_img }" />
					</div>
					<div class="reservationInfo">
						<input type="hidden" id="rsr_id" name="rsr_id"
							value="${list.rsr_id }"> <Strong><c:out
								value="${list.acm_name } - ${list.room_name}" /></Strong><br> 예약일자:
						<fmt:formatDate value="${list.check_in_date }"
							pattern="yyyy년 MM월 dd일" />
						부터<br> <span style="padding-left: 73px;"> <fmt:formatDate
								value="${list.check_out_date }" pattern="yyyy년 MM월 dd일" /></span> 까지<br>
						<br>
						<p>예약자 명: ${list.rsr_name }</p>
						<c:choose>
							<c:when test="${list.discount_price > 0 }">
								<p>
									결제금액:
									<c:choose>
										<c:when test="${list.discount_price < 100000}">
											<fmt:formatNumber pattern="00,000"
												value="${list.discount_price}" />
										</c:when>
										<c:otherwise>
											<fmt:formatNumber pattern="###,###"
												value="${list.discount_price}" />
										</c:otherwise>
									</c:choose>
									원
								</p>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${list.price > 0 }">
										<p>
											결제금액:
											<c:choose>
												<c:when test="${list.price < 100000}">
													<fmt:formatNumber pattern="00,000" value="${list.price}" />
												</c:when>
												<c:otherwise>
													<fmt:formatNumber pattern="###,###" value="${list.price}" />
												</c:otherwise>
											</c:choose>
											원
										</p>
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>


						<c:choose>
							<c:when test="${list.review_id eq 0}">
								<a href="#" class="review-link" data-bs-toggle="modal"
									data-bs-target="#reviewModal"
									data-review='{"acm_main_img": "${list.acm_main_img}", "acm_name": "${list.acm_name}"}'>
									리뷰 쓰러 가기 </a>


							</c:when>
							<c:otherwise>
								<span class="review-complete">리뷰 쓰기 완료</span>
							</c:otherwise>
						</c:choose>

						<!-- 모달 시작  -->
						<form action="/mypage/ReviewWriteProcess" method="post"
							enctype="multipart/form-data" id="uploadFrm" name="uploadFrm">
							<div class="modal fade" id="reviewModal" tabindex="-1"
								aria-labelledby="reviewModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="reviewModalLabel">리뷰쓰기</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<input type="hidden" id="rsr_id" name="rsr_id"
											value="${list.rsr_id }"> <input type="hidden"
											id="acm_id" name="acm_id" value="${list.acm_id }"> <input
											type="hidden" id="user_id" name="user_id"
											value="${user_info.user_id }">
										<div class="modal-body">
											<img alt="숙소 이미지"
												src="/common/admin/images/${list.acm_main_img }"> <span
												class="fw-bold">${list.acm_name }</span> <span
												class="fw-bold">( ${list.room_name } )</span><br> <span
												style="text-align: center;">숙소는 만족하셨나요?</span>
											<div class="d-flex justify-content-center mb-3">
												<span class="star" data-value="1">★</span> <span
													class="star" data-value="2">★</span> <span class="star"
													data-value="3">★</span> <span class="star" data-value="4">★</span>
												<span class="star" data-value="5">★</span>
											</div>

											<!-- 숨겨진 input 태그로 rating 값 관리 -->
											<input type="hidden" name="rating" id="rating" value="">

											<textarea class="form-control" id="content"
												placeholder="어떤 점이 좋았나요? 최소 10자 이상 입력해주세요." rows="6"
												maxlength="5000" name="content"></textarea>
											<br> <input type="file" id="upfile" multiple
												accept="image/*" name="upfile" />
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">취소</button>
											<input type="button" id="btnAddReview"
												class="btn btn-primary" value="등록" />
										</div>
									</div>
								</div>
							</div>
						</form>


					</div>
				</div>
			</c:forEach>

			<br> <span class="pagination"><c:out
					value="${ pagination }" escapeXml="false" /></span>

		</div>
	</div>



	<div id="footer">
		<!-- footer import -->
		<jsp:include page="../common/jsp/footer.jsp" />

	</div>



</body>
</html>

