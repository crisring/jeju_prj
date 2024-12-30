<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 관리</title>

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
<style type="text/css">
.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 20px 70px 30px 0px;
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

<script type="text/javascript">
	$(function() {

		// 검색 폼 제출 이벤트 처리
		$("#btnSearch").on("click", function() {

			var flag = chkKeyword();

			if (flag) {
				$("#searchFrm").submit();
			}

		});
	});//ready

	function chkKeyword() {

		var flag = false;
		var keyWord = $('#keyWord').val();

		if (keyWord == null) {
			alert('검색어는 한 자이상 입력해야합니다.');
			return flag;
		}
		flag = true;

		return flag;
	}
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="review-container">
			<h1>리뷰목록</h1>

			<!-- 검색 부분 -->
			<div class="search-box">
				<form id="searchFrm" class="row g-3 align-items-center" method="get"
					action="/admin/review_list">
					<div class="col-auto">
						<input type="text" class="form-control" id="keyWord"
							name="keyWord" placeholder="검색할 키워드를 입력하세요">
					</div>
					<div class="col-auto">
						<input type="button" class="btn btn-success" id="btnSearch"
							value="검색">
					</div>
				</form>
			</div>

			<!-- 총 리뷰 수 표시 -->
			<div class="review-count">
				<strong>총 리뷰의 수 : ${totalCount }건</strong>
			</div>

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
					<c:forEach var="review" items="${reviewList }" varStatus="i">
						<tr>

							<td>${i.count }</td>
							<td><a href="/admin/review_detail/${review.review_id}">${review.acm_name}</a></td>

							<td><c:choose>
									<c:when test="${fn:length(review.content) > 30}">
            							${fn:substring(review.content, 0, 30)}...
       								 </c:when>
									<c:otherwise>
            							${review.content}
       								 </c:otherwise>
								</c:choose></td>
							<td>${review.user_id }</td>
							<td>${review.created_at }</td>
							<td>${review.rating	}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<br> <span class="pagination"><c:out
				value="${ pagination }" escapeXml="false" /></span>
	</div>



	<jsp:include page="../common/footer.jsp" />
</body>
</html>