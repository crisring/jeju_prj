<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>예약 확인 및 결제</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
</head>
<link rel="stylesheet" type="text/css"
	href="/css/user/reservation_page.css" />

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>



<script type="text/javascript">
	$(function() {
		$('#btnPay').on('click', function() {
			if (chkTerms()) {
				if (confirm('결제하시겠습니까?')) {
					$('#rsrFrm').submit();
				}
			}
		});

	});

	/* 약관 체크 검사 */
	function chkTerms() {
		var totalTerms = $('.termCheckbox').length;
		var checkedTerms = $('.termCheckbox:checked').length;

		var flag = false;

		if (totalTerms === checkedTerms) {
			flag = true;
		} else {
			alert('모든 약관에 동의하지 않으셨습니다.');
			return;
		}
		return flag;
	}
</script>

<!-- 약관 동의 -->
<script type="text/javascript">
	$(function() {

		$('#toggleTerms').on('click', function() {

			const $termsContent = $('#termsContent');
			if ($termsContent.css('display') === 'none') {

				$termsContent.css('display', 'block');
				$(this).text('▲');
			} else {

				$termsContent.css('display', 'none');
				$(this).text('▼');
			}
		});

		$('#agreeAll').on('change', function() {
			$('.termCheckbox').prop('checked', $(this).prop('checked'));
		});

		$('.termCheckbox')
				.on(
						'change',
						function() {
							const allChecked = $('.termCheckbox:checked').length === $('.termCheckbox').length;
							$('#agreeAll').prop('checked', allChecked);
						});

	})
</script>
<script type="text/javascript">
	$(function() {

	})// ready
</script>




<body>
	<jsp:include page="../common/jsp/header.jsp" />

	<main>
		<!-- 호텔 정보 -->
		<section class="hotel-summary">

			<div class="hotel-content">
				<div class="hotel-image">
					<img src="/common/admin/images/${rd.room_img_name }" alt="호텔 이미지">
				</div>
				<div class="hotel-details">
					<h3 class="section-title">${rd.acm_name }</h3>
					<br>
					<div class="info-row">
						<span class="label">객실</span> <span class="value">
							${rd.room_name } </span>
					</div>
					<div class="info-row">
						<span class="label">일정</span> <span class="value">
							${startDate } ${rd.check_in} ~<br>${finishDate }
							${rd.check_out}
						</span>
					</div>
					<div class="info-row">
						<span class="label">기준인원</span> <span class="value">
							${rd.capacity_info } </span>
					</div>
				</div>
			</div>
		</section>



		<!-- 예약자 정보와 결제 정보 -->
		<form action="/reservation/rsrProcess" method="post" id="rsrFrm">
			<div class="reservation-container">

				<input type="hidden" name="check_in_date" value="${startDate }" />
				<input type="hidden" name="check_out_date" value="${finishDate }" />
				<input type="hidden" name="room_id" value="${rd.room_id }" /> <input
					type="hidden" name="user_id" value="${user_info.user_id }" />


				<!-- 예약자 정보 -->
				<section class="reservation-info">
					<h3 class="section-title">예약자 정보</h3>
					<div class="info-group">
						<label for="name" class="label">예약자 이름</label> <input type="text"
							id="rsr_name" name="rsr_name" placeholder="홍길동">
					</div>
					<div class="info-group">
						<label for="phone" class="label">휴대폰 번호</label> <input type="text"
							id="rsr_phone_number" name="rsr_phone_number"
							placeholder="010-1234-5678">
					</div>
					<div class="info-group">
						<label for="guests" class="label">입실 인원</label> <select
							id="number_people" name="number_people"
							class="select-guest-count">
							<c:forEach var="i" begin="1" end="10">
								<option value="${i}"
									${numberPeople == i ? 'selected="selected"' : ''}>${i}명</option>
							</c:forEach>
						</select>

					</div>
					<p class="info-notice">개인 정보 보호를 위해 암호화된 정보로 숙소에 전송됩니다.</p>
				</section>


				<!-- 결제 정보 -->
				<section class="payment-info">
					<h3 class="section-title">결제 정보</h3>
					<div class="payment-details">
						<div class="info-row">

							<span class="label">객실 가격(1박)</span> <span class="value">
								<c:choose>
									<c:when test="${rd.discount_price > 0}">
										<!-- 할인가 표시 -->
										<fmt:formatNumber pattern="00,000"
											value="${rd.discount_price}" />원
            							<!-- 정상가 표시 (취소선 포함) -->
										<span class="original-price"> <fmt:formatNumber
												pattern="00,000" value="${rd.price}" />원
										</span>
									</c:when>
									<c:otherwise>
										<!-- 정상가만 표시 -->
										<fmt:formatNumber pattern="00,000" value="${rd.price}" />원
        </c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="info-row total">
							<span class="label">총 결제 금액</span> <span class="value"><fmt:formatNumber
									pattern="00,000" value="${priceToPay }" />원</span>
						</div>

						<div class="terms">
							<div id="agreeContainer">
								<label id="agreeAllLabel"> <input type="checkbox"
									id="agreeAll"> 약관 전체 동의
								</label>
								<button id="toggleTerms">▼</button>
							</div>

							<div id="termsContent" style="display: none;">
								<label> <input type="checkbox" class="termCheckbox">
									숙소 이용규칙 및 취소/환불규정 동의(필수)
								</label><br> <br> <label> <input type="checkbox"
									class="termCheckbox"> 개인정보 수집 및 이용 동의(필수)
								</label><br> <br> <label> <input type="checkbox"
									class="termCheckbox"> 개인정보 제3자 제공 동의(필수)
								</label><br> <br> <label> <input type="checkbox"
									class="termCheckbox"> 만 14세 이상 확인 (필수)
								</label>
							</div>
						</div>

						<input type="button" class="pay-button" id="btnPay"
							value="<fmt:formatNumber pattern="00,000" value="${priceToPay }" />원 결제하기">

					</div>
				</section>
			</div>
		</form>
		<c:choose>
			<c:when test="${empty user_info.user_id }">
				<!-- 로그인 안내 -->
				<a href=""><img src="/common/user/images/배너.png" id="banner">
				</a>
			</c:when>
			<c:otherwise>
				<br>
				<img src="/common/user/images/배너2.png" id="banner2">
			</c:otherwise>
		</c:choose>
	</main>


	<jsp:include page="../common/jsp/footer.jsp" />
</body>
</html>