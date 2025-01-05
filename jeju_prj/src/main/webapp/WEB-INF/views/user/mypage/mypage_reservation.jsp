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

</script>


<script type="text/javascript">
/*모달 별점구현 함수  */
$(function () {
	
	let letRating = 0; // 별점 값 저장 변수
	
	$(".star").on("click", function () {
	    const selectedRating = $(this).data("value"); // 클릭한 별의 값 가져오기
	    letRating = selectedRating; // 전역 변수에 저장

	    $(".star").each(function (index) {
	        if (index < letRating) {
	            $(this).addClass("selected"); // 선택된 별들에 클래스 추가
	        } else {
	            $(this).removeClass("selected"); // 선택되지 않은 별들에서 클래스 제거
	        }
	    });
	});
	
	/* 취소신청 업데이트 AJAX */
	$(".cancel-link").click(function(){
		const rsrId = this.getAttribute('data-rsr-id');
		var data={ rsrId:rsrId };
				
		if(!confirm("취소하시겠습니까?")){
			return;
		}
		
		$.ajax({
			url:"/mypage/cancelReservation/"+rsrId,
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
				location.reload();
			}
		});//ajax

	})// click
	
	/* 리뷰 추가 */
	$("#btnAddReview").click(function () {

		const rsr_id = $('#modal_rsr_id').val();
		
	    
	    // 내용 유효성 검사
	    if (!validateContent()) { 
	        return; 
	    } 

	    var content = $("#content").val();
	    var user_id = $('#user_id').val();    
	    var acm_id = $('#modal_acm_id').val();
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


	
	/* 파일 유효성 검사 */
	function validateImageFiles() {
		   // 파일 확장자 설정
		   const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp','image/jpg'];
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
		       alert('다음 파일은 이미지 파일이 아닙니다: ' + invalidFileNames + '\n\n이미지 파일(jpg, png, gif, webp)만 업로드 가능합니다.');
		       $('#upfile').val('');
		       return false;
		   }

		   // 파일명과 확장자를 결합하여 반환
		   return filesArray.map(file => {
		       return file.name;
		   });
		}// validateImageFiles

//모달 내용 동적 설정 -> 한개의 모달에 구현
function openReviewModal(acmImage, acmName, roomName, acmId, rsrId) {

    $('#modal_image').attr('src', '/common/admin/images/' + acmImage);
    $('#modal_acm_name').text(acmName);
    $('#modal_room_name').text('(' + roomName + ')');
    $('#modal_acm_id').val(acmId);
    $('#modal_rsr_id').val(rsrId);
    
    $('#rating').val('');
    $('#uploadFrm')[0].reset();
    
    $('.star').removeClass('selected');
    
}// openReviewModal


</script>


</head>

<body>


	<div id="wrap">

		<!--header import  -->
		<jsp:include page="../common/jsp/header.jsp" />

		<!-- sidebar import -->
		<jsp:include page="../common/jsp/mypage_sidebar.jsp" />


		<div id="main">
			<h5 class="bold mb-4">예약 내역 및 예약취소</h5>
			<p>예약 내역을 확인하고 취소할 수 있어요</p>

			<!-- 예약 내역이 없을 때 보여질 내용 -->
			<c:if test="${ empty rsrList}">
				<div class="reservation" id="container">
					<div class="reservationInfo">
						<h2>예정된 여행이 없습니다.</h2>
						<br>
						<p>지금 새로운 예약을 진행해보세요.</p>
						<br> <a href="/" class="btn">여행지 찾아보기</a>
					</div>
					<svg xmlns="http://www.w3.org/2000/svg" width="280" height="200"
						fill="none" viewBox="0 0 280 200" id="svg">
							<g fill="#F5F5F5" fill-rule="evenodd"
							clip-path="url(#icn_empty_card_svg__a)" clip-rule="evenodd">
							<path
							d="m97.793 52.894-1.631 6.085-40.569-10.87 1.63-6.086A7 7 0 0 0 43.702 38.4l-1.94 7.24c-8.625.673-16.283 6.674-18.649 15.506l-12.863 48.006c-3.002 11.203 3.646 22.718 14.849 25.72l54.092 14.494c11.203 3.002 22.718-3.647 25.719-14.849l12.864-48.007c2.366-8.832-1.265-17.858-8.397-22.754l1.94-7.24a7 7 0 0 0-13.523-3.622Zm-72.39 53.797 8.333-31.103 67.615 18.117-8.334 31.103c-2.001 7.468-9.678 11.901-17.146 9.899l-40.57-10.87c-7.468-2.001-11.9-9.678-9.899-17.146ZM259.079 9.73c-12.269-21.543-39.447-29.798-61.951-17.046-22.945 13.08-29.058 40.798-17.228 61.9 9.997 17.647 33.147 29.641 68.594 36.235 2.768.424 5.518-1.148 6.401-3.627 12.612-34.312 14.116-59.93 4.184-77.463Zm-29.06 12.61c3.812 6.73 1.449 15.276-5.278 19.087-6.727 3.811-15.272 1.445-19.084-5.285-3.813-6.73-1.45-15.275 5.277-19.087 6.728-3.81 15.272-1.445 19.085 5.285ZM200.322 209.702l-4.141-15.454c-1.144-4.268-5.603-6.782-9.959-5.614-4.357 1.167-6.962 5.573-5.818 9.841l4.141 15.455-31.554 8.454-7.888 2.114-18.635-69.547c-1.144-4.267 1.461-8.673 5.818-9.841l-4.141-15.454c-2.287-8.536 2.922-17.348 11.635-19.683l47.331-12.682c8.713-2.334 17.631 2.692 19.918 11.228l4.141 15.454c4.356-1.167 8.815 1.346 9.959 5.614l18.635 69.547-7.889 2.114v-.001l-31.553 8.455Zm-56.4-84.274 4.141 15.455 15.776-4.227-4.141-15.455-15.776 4.227Zm35.694 7-4.141-15.455 15.777-4.227 4.141 15.455-15.777 4.227Zm-27.412 23.91 4.141 15.455 15.777-4.228-4.141-15.455-15.777 4.228Zm35.694 7-4.141-15.455 15.777-4.227 4.141 15.454-15.777 4.228Z"></path></g>
							<defs>
							<clipPath id="icn_empty_card_svg__a">
							<path fill="#fff" d="M0 0h280v200H0z"></path></clipPath></defs></svg>
				</div>

			</c:if>

			<c:forEach var="list" items="${rsrList}" varStatus="i">
				<div class="reservation">
					<div class="reservationImg">
						<img src="/common/admin/images/${list.acm_main_img}"
							alt="${list.acm_main_img}" />
					</div>

					<div class="reservationInfo">
						<input type="hidden" id="rsr_id" name="rsr_id"
							value="${list.rsr_id}"> <strong><c:out
								value="${list.acm_name} - ${list.room_name}" /></strong><br> 예약일자:
						<fmt:formatDate value="${list.check_in_date}"
							pattern="yyyy년 MM월 dd일" />
						부터<br> <span style="padding-left: 73px;"> <fmt:formatDate
								value="${list.check_out_date}" pattern="yyyy년 MM월 dd일" />
						</span> 까지 <br> <br>
						<p>예약자 명: ${list.rsr_name}</p>
						<c:choose>
							<c:when test="${list.discount_price > 0}">
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
									<c:when test="${list.price > 0}">
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
						<input type="button" class="cancel-link" value="취소신청 하기"
							data-rsr-id="${list.rsr_id}">
					</div>
				</div>
			</c:forEach>

			<br>

			<h5 class="bold mb-4">이용완료</h5>

			<!-- 예약 내역이 없을 때 보여질 내용 -->
			<c:if test="${ empty rsrList2}">
				<div style="text-align: center;">해당되는 예약 내역이 없습니다.</div>
			</c:if>


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
								<a href="#" class="review-link"
									onclick="openReviewModal('${list.acm_main_img}', '${list.acm_name}', 
                               '${list.room_name}', '${list.acm_id}', '${list.rsr_id}')"
									data-bs-toggle="modal" data-bs-target="#reviewModal"> 리뷰 쓰러
									가기 </a>
							</c:when>

							<c:otherwise>
								<span class="review-complete">리뷰 쓰기 완료</span>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</c:forEach>

			<!-- 모달 시작  -->

			<div class="modal fade" id="reviewModal" tabindex="-1"
				aria-labelledby="reviewModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">

						<form action="/mypage/ReviewWriteProcess" method="post"
							enctype="multipart/form-data" id="uploadFrm" name="uploadFrm">

							<div class="modal-header">
								<h5 class="modal-title" id="reviewModalLabel">리뷰쓰기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>


							<div class="modal-body">

								<%-- Hidden Fields --%>
								<input type="hidden" name="acm_id" id="modal_acm_id"> <input
									type="hidden" id="user_id" name="user_id"
									value="${user_info.user_id}"> <input type="hidden"
									name="rsr_id" id="modal_rsr_id"> <input type="hidden"
									name="rating" id="rating">

								<!-- 동적으로 변경될 내용  -->
								<img id="modal_image" src="" alt="숙소 이미지" class="review-image">
								<div class="accommodation-info">
									<span id="modal_acm_name" class="fw-bold"></span> <span
										id="modal_room_name" class="fw-bold"></span>
								</div>

								<br> <span style="text-align: center;">숙소는 만족하셨나요?</span>



								<div class="d-flex justify-content-center mb-3">
									<span class="star" data-value="1">★</span> <span class="star"
										data-value="2">★</span> <span class="star" data-value="3">★</span>
									<span class="star" data-value="4">★</span> <span class="star"
										data-value="5">★</span>
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
								<input type="button" id="btnAddReview" class="btn btn-primary"
									value="등록" data-rsr-id="${list.rsr_id}" />
							</div>
						</form>
					</div>
				</div>
			</div>



		</div>
	</div>


	<br>
	<span class="pagination"><c:out value="${ pagination }"
			escapeXml="false" /></span>



	<div id="footer">
		<!-- footer import -->
		<jsp:include page="../common/jsp/footer.jsp" />

	</div>



</body>
</html>

