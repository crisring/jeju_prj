<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주어때</title>

<!-- Bootstrap CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- jQuery CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
.container {
	margin-top: 80px;
	width: 500px;
	height: 500px;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 80px;
}

.frm {
	margin-top: 30px;
}

.bld {
	font-weight: bold;
}
</style>


<c:if test="${not empty error }">
<script type="text/javascript">
alert("${error}")
</script>
</c:if>

<script>
$(document).ready(function() {
    $("#frm").on('submit', function(e) {
        e.preventDefault(); // 폼 기본 제출을 막음
        
        var $password = $('#password');
        var passwordVal = $.trim($password.val());
        
        if (passwordVal === '') {
            alert('비밀번호를 입력해주세요.');
            $password.focus();
            return false;
        }
        
        // 폼 수동 제출
        this.submit();
    });
    
    // 메인으로 버튼 클릭 이벤트
    $("#back").on('click', function() {
        location.href = "/";  // 메인 페이지 경로로 수정하세요
    });
});
</script>

</head>
<body>
		<!-- 헤더 -->
		<jsp:include page="../common/jsp/header.jsp" />

	<!-- 로그인 컨텐츠 -->
	<div class="container">
		<div style="text-align: center">
			<img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고"
				id="logo" style="display: block; margin: 0 auto;">
			<h5 class="bld">마이페이지</h5>
			<p class="text-muted">
				<strong>${user_info.user_id }</strong> 회원님 마이페이지에 들어가기전 <br>비밀번호를 입력해주세요.
			</p>
		</div>

<form action="${pageContext.request.contextPath}/mypage/checkPassProcess" method="post" name="frm" id="frm">	
		<div style="margin-bottom: 50px">
			<label class="form-label bld">비밀번호</label>
			 <input type="password"	class="form-control" placeholder="비밀번호 입력" name="password" id="password">
			 
			 
			<div style="text-align: center;">
    <input type="button" class="btn btn-info btn-lg frm" value="메인으로" id="back" name="back">
    <input type="submit" class="btn btn-primary btn-lg frm" value="들어가기" id="go" name="go">
</div>
		</div>
		</form>		
	</div>
		<!-- footer -->
		<jsp:include page="../common/jsp/footer.jsp" />
</body>
</html>

