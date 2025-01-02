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
						<td><input type="text" name="name"
							value="${ member.user_name }"></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="userId"
							value="${ member.user_id }"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="phone"
							value="${ member.phone_number }"></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type="text" name="birth" value="${ member.decrypt_birth }"
							readonly="readonly"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><select name="gender">
								<option value="M" ${member.gender == 'M' ? 'selected' : ''}>남자</option>
								<option value="F" ${member.gender == 'F' ? 'selected' : ''}>여자</option>
						</select></td>
					</tr>
					<tr>
						<th>회원상태</th>
						<td><select name="state">
								<option value="활동"
									${member.user_status == '활동' ? 'selected' : ''}>활동</option>
								<option value="정상"
									${member.user_status == '정상' ? 'selected' : ''}>정상</option>
								<option value="탈퇴"
									${member.user_status == '탈퇴' ? 'selected' : ''}>탈퇴</option>
								<option value="블랙리스트"
									${member.user_status == '블랙리스트' ? 'selected' : ''}>블랙리스트</option>
						</select></td>
					</tr>
					<tr>
						<th>가입구분</th>
						<td><select name="sign">
								<option value="normal" ${member.member_type == 'normal' ? 'selected' : ''}>일반회원
								<option value="kakao" ${member.member_type == 'kakao' ? 'selected' : ''}>카카오회원
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