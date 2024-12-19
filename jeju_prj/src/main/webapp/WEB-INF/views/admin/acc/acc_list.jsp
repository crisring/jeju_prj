<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
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

.acc-container {
	width: 95%;
	margin: 5px auto;
}

.search-section {
	margin-bottom: 10px;
	display: flex;
	gap: 10px;
	justify-content: space-between;
}

.search-group {
	display: flex;
	gap: 10px;
}

.search-input {
	padding: 5px;
	width: 200px;
	border-radius: 10px;
}

.search-button-acc {
	padding: 5px 15px;
	background-color: #f0f0f0;
	border: 1px solid #ddd;
	cursor: pointer;
	border-radius: 10px;
}

.search-button-acc:hover {
	background-color: #AFAFAF;
}

.acc-type {
	padding: 5px;
	border-radius: 10px;
}

.new-button {
	padding: 5px 15px;
	background-color: #00cc99;
	font-weight: bold;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 10px;
}

.new-button:hover {
	background-color: #00A279;
}

.table {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

.delete-button {
	padding: 5px 10px;
	background-color: #ff0000;
	font-size: 12px;
	border-radius: 10px;
	color: white;
	border: none;
	cursor: pointer;
	white-space: nowrap;
}

.thumbnail {
	width: 100px;
	height: 70px;
	object-fit: cover;
}

.table th {
	white-space: nowrap;
}

.table td {
	font-size: 14px;
	vertical-align: middle;
	white-space: nowrap;
}

.table-group-divider a {
	text-decoration: none;
	color: #EF54CC;
}

.table-group-divider a:hover {
	color: #C7129E;
	font-weight: bold;
}

.pagination {
	display: flex;
	justify-content: center;
	list-style: none;
	padding: 0;
	margin-top: 20px;
}

.page-item {
	margin: 0 5px;
}

.page-link {
	padding: 8px 12px;
	border: 1px solid #ddd;
	color: #333;
	text-decoration: none;
	border-radius: 4px;
}

.page-item.active .page-link {
	background-color: #007bff;
	color: white;
	border-color: #007bff;
}

.page-link:hover {
	background-color: #f8f9fa;
}
</style>
<script type="text/javascript">
function deleteAcc(no) {
    if(confirm('정말 삭제하시겠습니까?')) {
        /* location.href = 'deleteAcc.do?no=' + no + '&cmd=AD004'; */
        location.href = 'delete_acc.jsp';
    }
}
</script>
</head>
<body>
	<%
	request.setAttribute("contentPage", "http://localhost/project2/admin/acc_list.jsp");
	%>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1 style="font-family: monospace, sans-serif;">숙소 목록</h1>
		<div class="acc-container">
			<!-- 검색 섹션 -->
			<form action="/admin/searchACM" method="get">
				<div class="search-section">
					<div class="search-group">
						<input type="text" name="acm_name" class="search-input"
							placeholder="검색어를 입력하세요">
						<button type="submit" class="search-button-acc">검색</button>
						<select name="acm_type_id" class="acc-type">
							<option value="0">숙소유형</option>
							<option value="1">호텔 리조트</option>
							<option value="2">펜션 풀빌라</option>
							<option value="3">게하 한옥</option>
							<option value="4">캠핑 글램핑</option>
							<option value="5">홈 빌라</option>
						</select>
					</div>
					<button class="new-button" onclick="location.href='add_acc.jsp'">신규등록</button>
				</div>
			</form>

			<!-- 숙소 목록 테이블 -->
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>대표이미지</th>
						<th>이름</th>
						<th>숙소유형</th>
						<th>대표전화번호</th>
						<th>주소</th>
						<th></th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="acc" items="${data}" varStatus="i">
						<tr>
							<td>${(currentPage-1) * 10 + i.count}</td>
							<td><img src="/common/admin/images/${acc.main_img}"
								alt="숙소 이미지" class="thumbnail"></td>
							<td><a href="acc_detail.jsp">${acc.acm_name}</a></td>
							<td>${acc.acm_type}</td>
							<td>${acc.admin_phone_number}</td>
							<td>${acc.address}</td>
							<td>
								<button class="delete-button" onclick="deleteAcc(${acc.acm_id})">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<nav aria-label="Page navigation">
				<ul class="pagination justify-content-center">
					<!-- 이전 페이지 -->
					<c:if test="${currentPage > 1}">
						<li class="page-item"><a class="page-link"
							href="/admin/searchACM?acm_name=${param.acm_name}&acm_type_id=${param.acm_type_id}&page=${currentPage-1}">이전</a>
						</li>
					</c:if>

					<!-- 페이지 번호 -->
					<c:forEach begin="1" end="${totalPages}" var="pageNum">
						<li class="page-item ${pageNum == currentPage ? 'active' : ''}">
							<a class="page-link"
							href="/admin/searchACM?acm_name=${param.acm_name}&acm_type_id=${param.acm_type_id}&page=${pageNum}">${pageNum}</a>
						</li>
					</c:forEach>

					<!-- 다음 페이지 -->
					<c:if test="${currentPage < totalPages}">
						<li class="page-item"><a class="page-link"
							href="/admin/searchACM?acm_name=${param.acm_name}&acm_type_id=${param.acm_type_id}&page=${currentPage+1}">다음</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>

	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>