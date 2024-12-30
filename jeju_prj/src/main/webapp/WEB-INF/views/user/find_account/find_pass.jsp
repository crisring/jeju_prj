<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${site_kor}</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
    .container {
        margin-top:80px;
        width:500px;
        height:500px;
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

<script>
$(document).ready(function(){
    $('input[type="button"]').on('click', function() {
        var $userId = $('#user_id');       // 아이디 입력 필드
        var $userName = $('#user_name');   // 이름 입력 필드
        var $phoneNumber = $('#phone_number'); // 연락처 입력 필드

        var userIdVal = $.trim($userId.val());
        var userNameVal = $.trim($userName.val());
        var phoneNumberVal = $.trim($phoneNumber.val());

        // 아이디 필드 체크
        if (userIdVal === '') {
            alert('아이디를 입력해주세요.');
            $userId.focus();
            return;
        }

        // 이름 필드 체크
        if (userNameVal === '') {
            alert('이름을 입력해주세요.');
            $userName.focus();
            return;
        }

        // 연락처 필드 체크
        if (phoneNumberVal === '') {
            alert('연락처를 입력해주세요.');
            $phoneNumber.focus();
            return;
        }

        // 모든 값이 정상 입력되었을 때
          $('#hidId').val(userIdVal);
        $("#passFrm").submit();
    });
});//ready

</script>
</head>

<body>
    
        <!-- 헤더 -->
       <c:if test="${not empty error}">
       
       <script type="text/javascript"> 
       alert("${error}");
       </script>
       </c:if>
    <!-- 헤더 -->
    
    
	<c:import url="../common/jsp/header.jsp"/> 
    <!-- 로그인 컨텐츠 -->
    <div class="container">
        <div style="text-align: center">
            <img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
		    <h5 class="bld">비밀번호 찾기</h5>
        </div>
        <form action="/member/findPassProcess" method="post" name="passFrm" id="passFrm">
        <div class="d-grid" style="margin-bottom: 50px">
        <input type="hidden" name="hidId" id="hidId" value="${user_id}">
        
            <label class="form-label bld">아이디</label>
            <input type="text" class="form-control" placeholder="아이디를 입력하세요." name="user_id" id="user_id">
            <label class="form-label frm bld">이름</label>
            <input type="text" class="form-control" placeholder="이름을 입력하세요" name="user_name" id="user_name">

            <label class="form-label frm bld">연락처</label>
            <input type="tel" class="form-control" placeholder="연락처를 입력하세요" name="phone_number" id="phone_number">

            <input type="button" class="btn btn-primary btn-lg frm" value="비밀번호 찾기">
        </div>
        </form>
    </div>
	<c:import url="../common/jsp/footer.jsp"/> 
</body>
</html>
