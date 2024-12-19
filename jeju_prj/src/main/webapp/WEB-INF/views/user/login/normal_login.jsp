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
        margin-bottom:80px;
        width:500px;
        height:500px;
        padding: 20px;
        border-radius: 8px;
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
    $('input[value="로그인"]').on('click', function() {
        var $id = $('#id');
        var $pass = $('#pass');

        var idVal = $.trim($id.val());
        var passVal = $.trim($pass.val());

        // 아이디 유효성 검증
        if (idVal === '') {
            alert('아이디를 입력해주세요.');
            $id.focus();
            return;
        }

        // 비밀번호 유효성 검증
        if (passVal === '') {
            alert('비밀번호를 입력해주세요.');
            $pass.focus();
            return;
        }

        // 모든 값이 정상 입력되었을 때
        alert('로그인을 진행합니다.');
        // 여기서 원하는 동작(예: 폼 전송 또는 페이지 이동)을 구현할 수 있습니다.
    });
});
</script>

</head>
<body>
    <!-- 헤더 -->
    <div id="wrap">
	    <c:import url="../common/header.jsp"/> 
        <!-- 로그인 컨텐츠 -->
        <div class="container">
            <div style="text-align: center">
                <img src="http://localhost/second_prj/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
                <p class="text-muted">로그인</p>
            </div>
            <div class="d-grid" style="margin-top: 50px">
                <label class="form-label bld">아이디</label>
                <input type="text" class="form-control" placeholder="아이디를 입력하세요." name="id" id="id">
                <label class="form-label frm bld">비밀번호</label>
                <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="pass" id="pass">
                <input type="button" class="btn btn-primary btn-lg frm" value="로그인">
            </div>
        </div>
	    <c:import url="../common/footer.jsp"/> 
    </div>
</body>
</html>
