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
        var $id = $('#id');
        var $name = $('#name');
        var $tel = $('#tel');

        var idVal = $.trim($id.val());
        var nameVal = $.trim($name.val());
        var telVal = $.trim($tel.val());

        // 아이디 필드 체크
        if (idVal === '') {
            alert('아이디를 입력해주세요.');
            $id.focus();
            return;
        }

        // 이름 필드 체크
        if (nameVal === '') {
            alert('이름을 입력해주세요.');
            $name.focus();
            return;
        }

        // 연락처 필드 체크
        if (telVal === '') {
            alert('연락처를 입력해주세요.');
            $tel.focus();
            return;
        }

        // 모든 값이 정상 입력되었을 때
        alert('비밀번호 찾기를 진행합니다.');
        // 여기서 원하는 동작(폼 전송, 페이지 이동 등)을 추가할 수 있습니다.
    });
});
</script>
</head>

<body>
    <!-- 헤더 -->
	<c:import url="../common/header.jsp"/> 
    <!-- 로그인 컨텐츠 -->
    <div class="container">
        <div style="text-align: center">
            <img src="http://localhost/second_prj/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
		    <h5 class="bld">비밀번호 찾기</h5>
        </div>
        <div class="d-grid" style="margin-bottom: 50px">
            <label class="form-label bld">아이디</label>
            <input type="text" class="form-control" placeholder="아이디를 입력하세요." name="id" id="id">

            <label class="form-label frm bld">이름</label>
            <input type="password" class="form-control" placeholder="이름을 입력하세요" name="name" id="name">

            <label class="form-label frm bld">연락처</label>
            <input type="password" class="form-control" placeholder="연락처를 입력하세요" name="tel" id="tel">

            <input type="button" class="btn btn-primary btn-lg frm" value="비밀번호 찾기">
        </div>
    </div>
	<c:import url="../common/footer.jsp"/> 
</body>
</html>
