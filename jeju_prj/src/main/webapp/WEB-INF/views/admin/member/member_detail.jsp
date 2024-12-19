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

.modifyBtn {
	
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
		<div class="mb-container">
			<h1>회원 정보</h1>
			<form name="memberFrm">
				<table class="table table-striped-columns">
					<tr>
						<th>이름</th>
						<td><input type="text" name="name" value="홍길동"></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="userId" value="test"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="phone" value="010-1234-5678"></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type="text" name="birth" value="20000313"
							readonly="readonly"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><select name="gender">
								<option value="M">남자
								<option value="F">여자
						</select></td>
					</tr>
					<tr>
						<th>회원상태</th>
						<td><select name="state">
								<option value="일반회원">활동
								<option value="탈퇴회원">탈퇴
								<option value="블랙리스트">블랙리스트
						</select></td>
					</tr>
					<tr>
						<th>가입구분</th>
						<td><select name="sign">
								<option value="normal">일반회원
								<option value="kakao">카카오회원
						</select></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">
							<button type="button" class="btn btn-info">수정</button>
							<button type="button" class="btn btn-secondary"
								onclick="javascript:history.back()">취소</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>