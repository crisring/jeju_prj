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
       <c:if test="${not empty error}">
       <script type="text/javascript"> 
       alert("${error}");
       $("#user_name").focus();
       </script>

</c:if>
    
<script>
$(document).ready(function(){
    $('#findBtn').on('click', function() {
        var $name = $('#user_name');
        var $tel = $('#phone_number');
        var nameVal = $.trim($name.val());
        var telVal = $.trim($tel.val());
        
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
        
        // 두 값 모두 있을 때 원하는 동작
        // 예: 폼 전송 또는 다음 페이지 이동
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
        <div style="text-align: center">
            <img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
            <p class="text-muted">아이디찾기</p>
        </div>
        <form action="/member/findIdProcess" method="post" id="frm" name="frm">
        <div class="d-grid" style="margin-top: 50px">
            <label class="form-label bld">이름</label>
            <input type="text" class="form-control" placeholder="아이디를 입력하세요." name="user_name" id="user_name">
            <label class="form-label frm bld">연락처</label>
            <input type="text" class="form-control" placeholder="연락처를 입력하세요" name="phone_number" id="phone_number">
            <input type="button" class="btn btn-primary btn-lg frm" value="아이디 찾기" id="findBtn">
        </div>
        </form>
    </div>
	<c:import url="../common/jsp/footer.jsp"/> 
</body>
</html>
