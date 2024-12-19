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

.review-container {
	width: 95%;
	margin: 5px auto;
}

.search-box {
	margin: 20px 0;
	padding: 15px;
	background-color: #f8f9fa;
	border-radius: 5px;
}

.review-count {
	margin: 15px 0;
	font-size: 16px;
	color: #666;
}

.review-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

.review-table th, .review-table td {
	padding: 12px;
	text-align: center;
	border: 1px solid #ddd;
}

.review-table th {
	background-color: #f8f9fa;
	font-weight: bold;
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
		// 검색 폼 제출 이벤트 처리
		$("#searchForm").on("submit", function(e) {
			e.preventDefault(); // 폼의 기본 제출 동작 방지

			// 검색어 가져오기
			var keyword = $("#searchKeyword").val();

			// AJAX로 검색 요청 보내기 (예시 코드)
			/* $.ajax({
			    url: "검색_처리할_URL",
			    type: "POST",
			    data: { keyword: keyword },
			    success: function(response) {
			        // 검색 결과로 테이블 내용 업데이트
			        // $("#reviewTableBody").html(response);
			    }
			}); */
		});
	});//ready
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="review-container">
			<h1>리뷰목록</h1>

			<!-- 검색 부분 -->
			<div class="search-box">
				<form id="searchForm" class="row g-3 align-items-center">
					<div class="col-auto">
						<input type="text" class="form-control" id="searchKeyword"
							placeholder="검색할 키워드를 입력하세요">
					</div>
					<div class="col-auto">
						<button type="button" class="btn btn-success">검색</button>
					</div>
				</form>
			</div>

			<!-- 총 리뷰 수 표시 -->
			<div class="review-count">총 리뷰의 수: 1건</div>

			<!-- 리뷰 목록 테이블 -->
			<table class="review-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>숙소명</th>
						<th>내용</th>
						<th>작성자id</th>
						<th>등록일</th>
						<th>평점</th>
					</tr>
				</thead>
				<tbody id="reviewTableBody">
					<tr>
						<td>1</td>
						<td><a href="review_detail.jsp">숙소명</a></td>
						<td>내용</td>
						<td>id</td>
						<td>등록일</td>
						<td>3점</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>