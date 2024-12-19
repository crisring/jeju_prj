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
    
    label {
        margin-top: 15px;
    }
</style>

<script>
$(document).ready(function() {
    $('input[value="다음단계로"]').on('click', function() {
        // name="reason"인 라디오 버튼 중 선택된 것이 있는지 확인
        if ($('input[name="reason"]:checked').length === 0) {
            alert('이유를 하나 선택해주세요.');
            // 선택 안 했으면 첫 번째 라디오버튼에 포커스 이동
            $('input[name="reason"]').first().focus();
            return;
        }
        
        // 하나 이상 선택되어 있으면 다음 단계 진행
        alert('다음 단계로 진행합니다.');
        // 여기서 원하는 동작(페이지 이동, 폼 전송 등)을 추가할 수 있습니다.
    });
});
</script>

</head>
<body>
    <!-- 헤더 -->
	<c:import url="../common/header.jsp"/> 
    <!-- 탈퇴 컨텐츠 -->
    <div class="container">
        <div style="text-align: center">
            <img src="http://localhost/second_prj/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
		    <h5 class="bld">회원탈퇴</h5>
		    <p>왜 떠나시는지 <span style=" color:#0B5ED7;">이유</span>가 있을까요 ?</p>
        </div>
        
      	<div class="radio-group">
        	<form action="">
                <label><input type="radio" name="reason" value="0"> 사용을 잘 안하게 됨</label> <br>
                <label><input type="radio" name="reason" value="1"> 예약하고 싶은 곳이 없음</label>  <br>
                <label><input type="radio" name="reason" value="2"> 예약, 취소, 혜택받기 등 사용이 어려움</label> <br>
                <label><input type="radio" name="reason" value="3"> 혜택(쿠폰, 포인트)이 너무 적어요</label> <br>
                <label><input type="radio" name="reason" value="4"> 개인정보 보호를 위해 삭제할 정보가 있어요</label> <br>
                <label><input type="radio" name="reason" value="5"> 다른 계정이 있어요</label> <br>
                <label><input type="radio" name="reason" value="6"> 기타</label> <br>
                
                <div style="text-align: center;">
		            <input type="button" class="btn btn-secondary btn-lg frm" value="더 써보기">
		            <input type="button" class="btn btn-primary btn-lg frm" value="다음단계로">
                </div>
        	</form>
        </div>
    </div>
	<c:import url="../common/footer.jsp"/> 
</body>
</html>
