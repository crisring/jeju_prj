<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지</title>

<!-- bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

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

.btnDiv {
	margin: 0 auto;
	display: flex;
	justify-content: center;
	gap: 10px;
}

.review-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

.review-table th, .review-table td {
	padding: 12px;
	border: 1px solid #ddd;
}

.review-table th {
	background-color: #f8f9fa;
	font-weight: bold;
}

.review-table thead {
	text-align: center;
}

.review-table tbody tr td {
	background-color: #f2f2f2;
	height: 150px;
	vertical-align: middle;
}

.review-table tfoot tr td {
	background-color: #f2f2f2;
}

.review-table a {
	color: #007bff;
	text-decoration: none;
}

.review-table a:hover {
	text-decoration: underline;
}

.review_img img {
	width: 30%;
	margin-left: 30px;
}

.single-star {
	color: #ffc107;
	font-size: 20px;
	display: inline-block;
}

.single-star[data-rating="0"] {
	visibility: hidden;
}
</style>
<script type="text/javascript">
	$(function() {

		// 리뷰 삭제 기능
		$('#deleteBtn').click(function() {

			const review_id = $(this).data("review_id"); // data 값 가져오는법!

			if (confirm('삭제하시겠습니까?')) {

				$.ajax({

					url : "/admin/review_remove/" + review_id,
					data : review_id,
					dataType : "JSON",
					method : "DELETE",
					success : function(jsonObj) {

						if (jsonObj.resultFlag) {
							alert('리뷰가 삭제되었습니다!');
							location.href = "/admin/review_list";
						} else {
							alert('리뷰 삭제에 실패하였습니다!');
						}

					},
					error : function(xhr) {
						alert("리뷰 삭제 중 오류 발생 " + xhr.status);
					}

				});// ajax
			}// end if

		}); // click

	});//ready
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="review-container">
			<h1>리뷰 상세 페이지</h1>
			<form name="reviewFrm">
				<table class="review-table">
					<thead>
						<tr>
							<th>작성자</th>
							<td>${review.user_id }</td>
							<th>리뷰등록일</th>
							<td>${review.created_at }</td>
							<th>평점</th>
							<td><span class="single-star" data-rating="${review.rating}">★
							</span>${review.rating}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6">${review.content }</td>
						</tr>
					</tbody>
					<tfoot class="review_img">
						<tr>
							<td colspan="6"><c:forEach var="review_img"
									items="${review.img_name }" varStatus="i">

									<img alt="이미지${i.count }"
										src="/common/user/review_Img/${review_img }">

								</c:forEach></td>
						</tr>
					</tfoot>
				</table>
				<br>
				<div class="btnDiv">
					<!-- 삭제버튼 클릭 시 리뷰삭제가 아닌 내용을 "관리자에의해 삭제되었습니다", 이미지를 초기화 하는 update -->
					<input type="button" class="btn btn-danger" name="deleteBtn"
						id="deleteBtn" value="삭제" data-review_id="${review.review_id }" />
					<input type="button" class="btn btn-secondary" value="뒤로"
						onclick="javascript:history.back()" />

				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>