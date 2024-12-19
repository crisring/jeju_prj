<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주어때</title>

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

/* 기본 스타일 */
#main {
	width: 800px;
	height: auto;
	position: relative;
	margin-left: 630px;
	margin-top: 80px;
	margin-bottom: 80px;
}

.bold {
	font-weight: bold;
}

.table-responsive {
	margin-top: 50px;
}

table th, table td {
	vertical-align: middle; /* 텍스트 세로 정렬 */
}

.btn-group .btn {
	margin: 2px; /* 버튼 간격 */
}

/* 화면 너비 1200px 이하 */
@media screen and (max-width: 1200px) {
	#main {
		width: 90%;
		margin: 20px auto; /* 가운데 정렬 */
	}
	.table-responsive {
		overflow-x: auto; /* 테이블 넘침 방지 스크롤 */
	}
	table {
		font-size: 14px; /* 테이블 글자 크기 축소 */
	}
	.btn-group .btn {
		font-size: 12px;
	}
}

/* 화면 너비 768px 이하 */
@media screen and (max-width: 768px) {
	#main {
		width: 100%;
		margin: 20px auto;
		padding: 10px;
	}
	table th, table td {
		font-size: 12px; /* 테이블 글자 크기 더 축소 */
		padding: 5px; /* 셀 간격 축소 */
	}
	.btn-group {
		flex-direction: column; /* 버튼 세로 정렬 */
	}
	.btn-group .btn {
		width: 100%; /* 버튼 가로 크기 확장 */
		margin-bottom: 5px; /* 버튼 간 간격 추가 */
	}
}

/* 화면 너비 480px 이하 */
@media screen and (max-width: 480px) {
	body {
		font-size: 12px; /* 전반적인 글자 크기 축소 */
	}
	table {
		font-size: 10px; /* 테이블 글자 크기 더 축소 */
	}
	table th, table td {
		padding: 3px; /* 셀 간격 더 축소 */
	}
	.btn-group .btn {
		font-size: 10px; /* 버튼 글자 크기 축소 */
	}
	p, h5 {
		font-size: 14px; /* 텍스트 크기 조정 */
	}
}
</style>

<script type="text/javascript">
	$(function() {
	});//ready
</script>

</head>

<body>


	<div id="wrap">

		<!--header import  -->
		<jsp:include page="../common/jsp/header.jsp" />

		<!-- sidebar import -->
		<jsp:include page="../common/jsp/mypage_sidebar.jsp" />



		<div id="main">
			<h5 class="bold mb-4">리뷰 관리</h5>
			<p>내가 작성한 리뷰를 조회하고 수정할 수 있어요</p>
			<!-- 리뷰 조회 테이블 -->
			<div class="table-responsive" style="margin-top: 50px">
				<table class="table table-bordered text-center align-middle">
					<thead class="table-light">
						<tr>
							<th>번호</th>
							<th>숙소명</th>
							<th>별점</th>
							<th>내용</th>
							<th>리뷰 이미지</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<!-- 샘플 데이터 -->
						<tr>
							<td>1</td>
							<td>숙소 예시</td>
							<td>⭐</td>
							<td>내용 예시</td>
							<td>리뷰이미지</td>
							<td>2024-11-26</td>
							<td>
								<div class="btn-group" role="group">
									<button class="btn btn-success btn-sm">숙소로</button>
									<button class="btn btn-primary btn-sm">리뷰 수정</button>
									<button class="btn btn-danger btn-sm">리뷰 삭제</button>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>






		<div id="footer">
			<!-- footer import -->
			<jsp:include page="../common/jsp/footer.jsp" />

		</div>


	</div>





</body>
</html>