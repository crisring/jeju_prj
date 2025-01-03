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
		$("#memberFrm").on("submit", function(e) {
		       e.preventDefault(); // 기본 submit 동작 중지
		       
		       // 필수 입력값 체크
		       if($("#memberFrm input[name='user_name']").val().trim() == "") {
		           alert("이름을 입력해주세요.");
		           $("#memberFrm input[name='user_name']").focus();
		           return false;
		       }
		       
		       if($("#memberFrm input[name='user_id']").val().trim() == "") {
		           alert("아이디를 입력해주세요.");
		           $("#memberFrm input[name='user_id']").focus();
		           return false;
		       }
		       
		       if($("#memberFrm input[name='phone_number']").val().trim() == "") {
		           alert("전화번호를 입력해주세요.");
		           $("#memberFrm input[name='phone_number']").focus();
		           return false;
		       }
		       
		       // 전화번호 형식 체크 (선택적)
		       var phonePattern = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
		       if(!phonePattern.test($("#memberFrm input[name='phone_number']").val())) {
		           alert("전화번호 형식이 올바르지 않습니다.\n(예: 010-1234-5678)");
		           $("#memberFrm input[name='phone_number']").focus();
		           return false;
		       }
		       
		       // 모든 검증 통과시 폼 제출
		       if(confirm("회원정보를 수정하시겠습니까?")) {
		           this.submit();
		       }
		   });
	});//ready
</script>
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<div class="container">
		<div class="mb-container">
			<h1>회원 정보</h1>
			<form name="memberFrm" id="memberFrm" action="/admin/update_member"
				method="post">
				<table class="table table-striped-columns">
					<tr>
						<th>이름</th>
						<td><input type="text" name="user_name"
							value="${ member.user_name }"></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="user_id"
							value="${ member.user_id }"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" name="phone_number"
							value="${ member.phone_number }"></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td><input type="text"
							value="${ member.decrypt_birth }" readonly="readonly"></td>
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
						<td><select name="user_status">
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
						<td><select name="member_type">
								<option value="normal"
									${member.member_type == 'normal' ? 'selected' : ''}>일반회원
								
								<option value="kakao"
									${member.member_type == 'kakao' ? 'selected' : ''}>카카오회원
								
						</select></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center">
							<button type="submit" class="btn btn-info">수정</button>
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