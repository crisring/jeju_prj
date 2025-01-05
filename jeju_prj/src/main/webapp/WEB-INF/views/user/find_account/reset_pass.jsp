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
    
 .frm{
 margin-top: 30px;
 }
 .bld{
 font-weight: bold;
 }
</style>

<script>
$(document).ready(function(){
    $('input[value="확인"]').on('click', function(){
        var newPassword = $('#password').val().trim();
        var confirmPassword = $('#confirmPassword').val().trim();
        
        if(newPassword.length < 8){
            alert("비밀번호는 8자 이상이어야 합니다.");
            $('#password').focus();
            return;
        }

        if(newPassword !== confirmPassword){
            alert("비밀번호가 일치하지 않습니다.");
            $('#confirmPassword').focus();
            return;
        }
        
        $("#frm").submit();
    });
});


</script>
</head>


<body>
    <!-- 헤더 -->
	<c:import url="../common/jsp/header.jsp"/> 
    <!-- 로그인 컨텐츠 -->
    <div class="container">
        <div  style="text-align: center">
            <img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
            <h5 class="bld">비밀번호 재설정</h5>
            <p class="text-muted">현재비밀번호와 새 비밀번호를 입력해주세요</p>
        </div>
           <form action="/member/resetPassProcess" method="post" id="frm" name="frm">
        <div class="d-grid" style="margin-bottom: 50px">
            <label class="form-label bld">새 비밀번호</label>
	<input type="hidden" name="user_id" id="user_id" value="${user_id}">
            <input type="password" class="form-control" placeholder="새 비밀번호를 입력" id="password" name="password">

            <label class="form-label bld frm">새 비밀번호 확인</label>
            <input type="password" class="form-control" placeholder="새 비밀번호를 확인" id="confirmPassword" name="confirmPassword">
	
            <input type="button" class="btn btn-primary btn-lg frm" value="확인">
        </div>
           </form>
    </div>
    <c:import url="../common/jsp/footer.jsp"/> 
    
</body>
</html>
