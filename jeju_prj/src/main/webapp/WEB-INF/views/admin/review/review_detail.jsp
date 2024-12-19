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
</style>
<script type="text/javascript">
	$(function() {

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
							<td>userId</td>
							<th>리뷰등록일</th>
							<td>2024-11-27</td>
							<th>평점</th>
							<td>3</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6">리뷰 내용 입니다.</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6"><img alt="이미지1" src=""> <img
								alt="이미지2" src=""> <img alt="이미지3" src=""></td>
						</tr>
					</tfoot>
				</table>
				<br>
				<div class="btnDiv">
					<!-- 삭제버튼 클릭 시 리뷰삭제가 아닌 내용을 "관리자에의해 삭제되었습니다", 이미지를 초기화 하는 update -->
					<button type="button" class="btn btn-danger" name="deleteBtn">삭제</button>
					<button type="button" class="btn btn-secondary"
						onclick="javascript:history.back()">뒤로</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>