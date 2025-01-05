<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${site_kor}</title>

<c:if test="${not empty error }">
<script type="text/javascript">
    alert("${error}");
</script>
</c:if>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
    .container {
        margin-top:80px;
        width:500px;
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
    // "다음단계로" 버튼 클릭 시 폼 유효성 검사 후 confirm
    $("#nextBtn").on("click", function(e) {
        // name="reason_id"인 라디오 버튼 중 선택된 것이 있는지 확인
        if ($('input[name="reason_id"]:checked').length === 0) {
            e.preventDefault(); // 폼 제출 막기
            alert('이유를 하나 선택해주세요.');
            return;
        }

        // 사용자에게 탈퇴 의사를 확인
        var userConfirmed = confirm("정말로 회원탈퇴를 진행하시겠습니까?");
        if (!userConfirmed) {
            e.preventDefault(); // 사용자가 취소를 누르면 폼 제출 막기
        }
        // 사용자가 확인을 누르면 폼이 제출됩니다.
    });

    // "더 써보기" 버튼에 대한 동작
    $("#cancelBtn").on("click", function(){
        // 예시로 뒤로 가기
        history.back();
    });
});
</script>

</head>
<body>
    <!-- 헤더 -->
    <c:import url="../common/jsp/header.jsp"/> 

    <div class="container">
        <div style="text-align: center">
            <img src="http://localhost/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
            <h5 class="bld">회원탈퇴</h5>
            <p>왜 떠나시는지 <span style=" color:#0B5ED7;">이유</span>가 있을까요?</p>
        </div>
        
        <div class="radio-group">
            <!-- 실제 탈퇴 처리 요청 -->
            <form action="${pageContext.request.contextPath}/mypage/withdrawProcess" method="post">
                <!-- user_id가 세션이나 다른 곳에 저장되어 있다면, 히든 필드로 전송 -->
                <input type="hidden" name="user_id" value="${user_info.user_id}" />
                
                <label><input type="radio" class="form-check-input" name="reason_id" value="1"> 사용을 잘 안하게 됨</label> <br>
                <label><input type="radio" class="form-check-input" name="reason_id" value="2"> 예약하고 싶은 곳이 없음</label>  <br>
                <label><input type="radio" class="form-check-input" name="reason_id" value="3"> 예약, 취소, 혜택받기 등 사용이 어려움</label> <br>
                <label><input type="radio" class="form-check-input" name="reason_id" value="4"> 혜택(쿠폰, 포인트)이 너무 적어요</label> <br>
                <label><input type="radio" class="form-check-input" name="reason_id" value="5"> 개인정보 보호를 위해 삭제할 정보가 있어요</label> <br>
                <label><input type="radio" class="form-check-input" name="reason_id" value="6"> 다른 계정이 있어요</label> <br>
                <label><input type="radio" class="form-check-input" name="reason_id" value="7"> 기타</label> <br>
                
                <div style="text-align: center;">
                    <!-- "더 써보기" 버튼: type="button"으로 폼 제출 안 함 -->
                    <input type="button" class="btn btn-secondary btn-lg frm" value="더 써보기" id="cancelBtn" name="cancelBtn">
                    <!-- "다음단계로" 버튼: type="submit"으로 폼 제출 -->
                    <input type="submit" class="btn btn-primary btn-lg frm" value="다음단계로" id="nextBtn" name="nextBtn">
                </div>
            </form>
        </div>
    </div>

    <!-- 푸터 -->
    <c:import url="../common/jsp/footer.jsp"/>
</body>
</html>
