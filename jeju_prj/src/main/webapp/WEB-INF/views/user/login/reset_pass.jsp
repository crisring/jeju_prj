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
        var newPassword = $('#newPassword').val().trim();
        var confirmPassword = $('#confirmPassword').val().trim();
        
        // 비밀번호 유효성 검증 예시: 8자 이상
        if(newPassword.length < 8){
            alert("비밀번호는 8자 이상이어야 합니다.");
            $('#newPassword').focus();
            return;
        }

        if(newPassword !== confirmPassword){
            alert("비밀번호가 일치하지 않습니다.");
            $('#confirmPassword').focus();
            return;
        }

        // 여기서 서버로 전송하는 로직을 추가하거나, 다음 페이지로 이동하는 로직을 추가할 수 있음.
        alert("비밀번호가 성공적으로 변경되었습니다.");
    });
});
</script>
</head>


<body>
    <!-- 헤더 -->
    <c:import url="../common/header.jsp"/> 
    <!-- 로그인 컨텐츠 -->
    <div class="container">
        <div  style="text-align: center">
            <img src="http://localhost/second_prj/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
            <h5 class="bld">비밀번호 재설정</h5>
            <p class="text-muted">현재비밀번호와 새 비밀번호를 입력해주세요</p>
        </div>
        <div class="d-grid" style="margin-bottom: 50px">
            <label class="form-label bld">새 비밀번호</label>
            <input type="password" class="form-control" placeholder="새 비밀번호를 입력" id="newPassword" name="newPassword">

            <label class="form-label bld frm">새 비밀번호 확인</label>
            <input type="password" class="form-control" placeholder="새 비밀번호를 확인" id="confirmPassword" name="confirmPassword">

            <input type="button" class="btn btn-primary btn-lg frm" value="확인">
        </div>
    </div>
    <c:import url="../common/footer.jsp"/> 
    
</body>
</html>
