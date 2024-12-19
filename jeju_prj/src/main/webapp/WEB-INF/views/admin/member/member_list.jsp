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

.mb-container {
	width: 95%;
	margin: 5px auto;
}

.table th, td {
	text-align: center;
}

.table {
	min-width: 800px;
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
		<h1>회원 관리</h1>
		<div class="mb-container">

			<!-- 검색 부분 -->
			<div class="search-box">
				<form id="searchForm" class="row g-3 align-items-center">
					<div class="col-auto">
						<input type="text" class="form-control" id="searchKeyword"
							placeholder="이름 검색">
					</div>
					<div class="col-auto">
						<button type="button" class="btn btn-success">검색</button>
					</div>
				</form>
			</div>

			<table class="table table-hover">
				<thead>
					<tr>
						<th></th>
						<th>사용자ID</th>
						<th>이름</th>
						<th>생년월일</th>
						<th>성별</th>
						<th>전화번호</th>
						<th>회원상태</th>
						<th>가입구분</th>
						<th>가입일</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<tr>
						<td>1</td>
						<td><a href="member_detail.jsp">user001</a></td>
						<td>홍길동</td>
						<td>1990-01-01</td>
						<td>남</td>
						<td>010-1234-5678</td>
						<td>활동</td>
						<td>일반회원</td>
						<td>2024-01-01</td>
					</tr>
					<tr>
						<td>2</td>
						<td><a href="#void">user002</a></td>
						<td>김철수</td>
						<td>1985-05-15</td>
						<td>남</td>
						<td>010-2345-6789</td>
						<td>활동</td>
						<td>카카오회원</td>
						<td>2024-01-02</td>
					</tr>
					<tr>
						<td>3</td>
						<td><a href="#void">user003</a></td>
						<td>이영희</td>
						<td>1992-12-25</td>
						<td>여</td>
						<td>010-3456-7890</td>
						<td>탈퇴</td>
						<td>일반회원</td>
						<td>2024-01-03</td>
					</tr>
				</tbody>
			</table>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</div>
</body>
</html>