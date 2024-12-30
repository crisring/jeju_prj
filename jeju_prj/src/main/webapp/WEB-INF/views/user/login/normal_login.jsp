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
    
    /* a 태그에 기본 밑줄 제거 및 파란색 제거 (Bootstrap 클래스 사용) */
    .custom-link {
        color: inherit; /* 부모 색상 계승, 기본 파란색 링크 제거 */
        text-decoration: none; /* 밑줄 제거 */
    }
    /* 마우스 오버 시 밑줄 표시 */
    .custom-link:hover {
        text-decoration: underline;
    } 
</style>

<script>
$(document).ready(function(){
    $('form').on('submit', function(e) {
        var $id = $('#user_id');
        var $pass = $('#password');

        var idVal = $.trim($id.val());
        var passVal = $.trim($pass.val());

        // 아이디 유효성 검증
        if (idVal === '') {
            alert('아이디를 입력해주세요.');
            $id.focus();
            e.preventDefault(); // 폼 제출 방지
            return;
        }

        // 비밀번호 유효성 검증
        if (passVal === '') {
            alert('비밀번호를 입력해주세요.');
            $pass.focus();
            e.preventDefault(); // 폼 제출 방지
            return;
        }
        $("#frm").submit();
    });
});
</script>

</head>
<body>
    <div id="wrap">
        <!-- 헤더 -->
        <c:import url="../common/jsp/header.jsp"/> 
        
        <!-- 로그인 컨텐츠 -->
        <div class="container">
            <div style="text-align: center">
                <img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
                <p class="text-muted">로그인</p>
            </div>
            
            <!-- 로그인 폼 -->
            <form action="/login/loginProcess" method="post" name="frm" id="frm">
                <div class="d-grid" style="margin-top: 50px">
                    <label class="form-label bld">아이디</label>
                    <input type="text" class="form-control" placeholder="아이디를 입력하세요." name="user_id" id="user_id">
                    
                    <label class="form-label frm bld">비밀번호</label>
                    <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="password" id="password">
                    
                    <input type="submit" class="btn btn-primary btn-lg frm" value="로그인">
                </div>
                
                <div class="d-flex gap-3 justify-content-center frm">
                    <a href="/member/agree" class="custom-link">회원가입</a>
                    <a href="/member/findId" class="custom-link">아이디찾기</a>
                    <a href="/member/findPass" class="custom-link">비밀번호 찾기</a>
                </div>   
            </form>
        </div>
        
        <!-- 푸터 -->
        <c:import url="../common/jsp/footer.jsp"/> 
    </div>
</body>
</html>
