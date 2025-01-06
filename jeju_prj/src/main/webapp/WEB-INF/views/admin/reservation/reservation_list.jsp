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
function searchReservation() {
    const keyword = document.getElementById('keyword').value;
    
    if(keyword == null || keyword.trim() == '') {
        alert("검색어를 입력하세요");
        return;
    }
    
    const form = document.getElementById('reservationForm');
    document.getElementById('formAction').value = 'search';
    form.action = '/admin/res_list';
    form.method = 'get';
    form.submit();
}

function deleteReservation(no) {
    if(confirm('정말 삭제하시겠습니까?')) {
        const form = document.getElementById('reservationForm');
        document.getElementById('formAction').value = 'delete';
        
        // form의 action과 method 설정
        form.action = '/admin/delete_res';
        form.method = 'post';
        
        // 예약 ID를 hidden input으로 추가
        const hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'rsr_id';
        hiddenInput.value = no;
        form.appendChild(hiddenInput);
        
        form.submit();
    }
}

function updateReservations() {
    if(confirm('변경사항을 저장하시겠습니까?')) {
        const form = document.getElementById('reservationForm');
        document.getElementById('formAction').value = 'update';
        form.action = '/admin/update_res_status';
        form.method = 'post';
        form.submit();
    }
}

// 예약상태 변경 시 원래 상태 저장 (취소 시 복구용)
document.querySelectorAll('.rsv-state').forEach(select => {
    select.addEventListener('focus', function() {
        this.setAttribute('data-original-value', this.value);
    });
});
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<h1 style="font-family: monospace, sans-serif;">예약목록</h1>
		<div class="acc-container">
			<!-- 숙소 목록 테이블 -->
			<form id="reservationForm" action="/admin/res_list" method="post">
				<div class="search-section">
					<div class="search-group">
						<input type="text" name="keyword" id="keyword"
							class="search-input" placeholder="아이디로 검색" value="${ keyword }">
						<button type="button" onclick="searchReservation()"
							class="search-button-acc">검색</button>
					</div>
					<button type="button" onclick="updateReservations()"
						class="new-button">수정</button>
				</div>

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
						<c:forEach var="res" items="${resList}" varStatus="i">
							<tr>
								<td>${ i.count }</td>
								<td><a href="/admin/res_detail?rsr_id=${ res.rsr_id }">${ res.acm_name }</a></td>
								<td><img src="/images/${ res.main_img }"
									alt="숙소 이미지" class="thumbnail"></td>
								<td>${res.user_id }</td>
								<td>${ res.rsr_date }</td>
								<td>${ res.check_in_date }</td>
								<td>${ res.check_out_date }</td>
								<td>${ res.number_people }</td>
								<td><select name="rsr_status" class="rsv-state">
										<option value="결제완료"
											${res.rsr_status eq '결제완료' ? 'selected' : ''}>결제완료</option>
										<option value="예약확정"
											${res.rsr_status eq '예약확정' ? 'selected' : ''}>예약확정</option>
										<option value="예약취소"
											${res.rsr_status eq '예약취소' ? 'selected' : ''}>예약취소</option>
										<option value="이용완료"
											${res.rsr_status eq '이용완료' ? 'selected' : ''}>이용완료</option>
								</select> <input type="hidden" name="rsr_id" value="${ res.rsr_id }"></td>
								<td>
									<button type="button" class="delete-button"
										onclick="deleteReservation(${ res.rsr_id })">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<!-- 동작 구분을 위한 hidden input -->
				<input type="hidden" name="action" id="formAction" value="">
			</form>
		</div>
		<jsp:include page="../common/footer.jsp" />
</body>
</html>