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

.table td {
	font-size: 14px;
	vertical-align: middle;
}

.table th {
	font-size: 13px;
	white-space: nowrap;
}

.table-group-divider a {
	text-decoration: none;
	color: #92D028;
}

.table-group-divider a:hover {
	color: #547816;
	font-weight: bold;
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
		<h1 style="font-family: monospace, sans-serif;">예약목록</h1>
		<div class="acc-container">
			<!-- 검색 섹션 -->
			<div class="search-section">
				<div class="search-group">
					<input type="text" class="search-input" placeholder="아이디로 검색">
					<button class="search-button-acc">검색</button>
				</div>
				<button class="new-button">수정</button>
			</div>

			<!-- 숙소 목록 테이블 -->
			<table class="table">
				<thead>
					<tr>
						<th>예약번호</th>
						<th>숙소명(객실명)</th>
						<th>이미지</th>
						<th>예약아이디</th>
						<th>예약날짜</th>
						<th>체크인</th>
						<th>체크아웃</th>
						<th>인원수</th>
						<th>예약상태</th>
						<th></th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<tr>
						<td>1</td>
						<!-- "acc_detail.do?accId=${ acc.Id }" accId를 받아서 action으로 넘겨야됨 -->
						<td><a href="reservation_detail.jsp">Ferris(디럭스 트윈)</a></td>
						<td><img src="" alt="숙소 이미지" class="thumbnail"></td>
						<td>user1</td>
						<td>2024-11-28</td>
						<td>2024-12-25</td>
						<td>2024-12-27</td>
						<td>2</td>
						<td><select class="rsv-state">
								<option value="결제완료">결제완료
								<option value="예약확정" selected="selected">예약확정
								<option value="예약취소">예약취소
								<option value="이용완료">이용완료
						</select></td>
						<td>
							<button class="delete-button" onclick="deleteAcc(${acc.no})">삭제</button>
						</td>
					</tr>
					<tr>
						<td>2</td>
						<!-- "acc_detail.do?accId=${ acc.Id }" accId를 받아서 action으로 넘겨야됨 -->
						<td><a href="#void">제주호텔(바다뷰 패밀리)</a></td>
						<td><img src="" alt="숙소 이미지" class="thumbnail"></td>
						<td>user2</td>
						<td>2024-11-25</td>
						<td>2024-12-15</td>
						<td>2024-12-19</td>
						<td>4</td>
						<td><select class="rsv-state">
								<option value="결제완료">결제완료
								<option value="예약확정">예약확정
								<option value="예약취소" selected="selected">예약취소
								<option value="이용완료">이용완료
						</select></td>
						<td>
							<button class="delete-button" onclick="deleteAcc(${acc.no})">삭제</button>
						</td>
					</tr>
					<%-- 
                아래껀 바꿔야됨 이건 숙소리스트에서 가져온것 이런식으로 해야됨
                <c:forEach var="acc" items="${accList}">
                    <tr>
                        <td>${acc.no}</td>
                        <td><img src="${acc.imageUrl}" alt="숙소 이미지" class="thumbnail"></td>
                        <td>${acc.name}</td>
                        <td>${acc.type}</td>
                        <td>${acc.description}</td>
                        <td>${acc.phone}</td>
                        <td>${acc.address}</td>
                        <td>
                            <button class="delete-button" onclick="deleteAcc(${acc.no})">삭제</button>
                        </td>
                    </tr>
                </c:forEach> --%>
				</tbody>
			</table>
		</div>

	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>