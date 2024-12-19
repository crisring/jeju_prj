<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${site_kor}</title>
<link rel="shortcut icon" href="${defaultURL}common/images/favicon.ico">

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
    body {
        background-color: #fff;
        font-family: Arial, sans-serif;
        font-size: 1.1em; 
    }
    .container {
        margin-top:80px;
        width:500px;
        padding: 20px;
        border-radius: 8px;
        font-size: 1rem;
        line-height: 1.5;
        margin-bottom:80px;
    }
    .logo {
        font-size: 28px;
        font-weight: bold;
        color: #ff4c4c;
        margin-bottom: 10px;
    }
    .frm {
        margin-top: 30px;
    }
</style>

<script>
    $(document).ready(function () {
        // "약관 전체동의" 체크박스 클릭 이벤트
        $('#selectAll').on('change', function () {
            const isChecked = $(this).is(':checked');
            // 모든 하위 체크박스를 전체 동의 체크박스 상태로 설정
            $('.required').prop('checked', isChecked);
        });

        // 개별 체크박스 클릭 이벤트
        $('.required').on('change', function () {
            const total = $('.required').length; // 전체 체크박스 개수
            const checked = $('.required:checked').length; // 체크된 체크박스 개수

            // 모든 체크박스가 선택되었는지 확인
            if (total === checked) {
                $('#selectAll').prop('checked', true);
            } else {
                $('#selectAll').prop('checked', false);
            }
        });
    });
</script>
</head>


<body>
    <!-- 헤더 -->
    <c:import url="../common/header.jsp"/> 
    <!-- 약관 컨텐츠 -->
    <div class="container bg-white">
        <div style="text-align: center">
            <img src="http://localhost/second_prj/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
            <p class="text-muted">로그인/회원가입</p>
        </div>
        
        <h3 style="margin-top: 20px">초면에 실례지만,<br>약관동의가 필요해요.</h3>
        <div class="d-grid" style="margin-top: 50px">

            <!-- 전체 동의 -->
            <div class="form-check my-2">
              <input type="checkbox" class="form-check-input" id="selectAll">
              <label class="form-check-label fw-bold" for="selectAll">약관 전체동의 (선택항목 포함)</label>
            </div>
            
            <!-- 개별 항목 1 -->
            <div class="form-check my-2">
              <input type="checkbox" class="required form-check-input" id="term1">
              <label class="form-check-label" for="term1">(필수) 이용약관</label>
              <!-- 보기 버튼 (각 항목마다 고유한 collapse ID) -->
              <button class="btn btn-link btn-sm ms-2 p-0" type="button" data-bs-toggle="collapse" data-bs-target="#term1Content" aria-expanded="false" aria-controls="term1Content">
                보기
              </button>
              <!-- 해당 항목에만 적용되는 collapse 영역 -->
              <div class="collapse mt-2" id="term1Content">
                <div class="card card-body">
                  여기에는 "이용약관" 내용을 삽입합니다.
                  긴 내용도 가능하며, 다시 "보기" 버튼을 클릭하면 접힙니다.
                </div>
              </div>
            </div>

            <!-- 개별 항목 2 -->
            <div class="form-check my-2">
              <input type="checkbox" class="required form-check-input" id="term2">
              <label class="form-check-label" for="term2">(필수) 만 14세 이상 확인</label>
              <button class="btn btn-link btn-sm ms-2 p-0" type="button" data-bs-toggle="collapse" data-bs-target="#term2Content" aria-expanded="false" aria-controls="term2Content">
                보기
              </button>
              <div class="collapse mt-2" id="term2Content">
                <div class="card card-body">
                  여기에는 "만 14세 이상 확인" 관련 내용을 삽입합니다.
                </div>
              </div>
            </div>

            <!-- 개별 항목 3 -->
            <div class="form-check my-2">
              <input type="checkbox" class="required form-check-input" id="term3">
              <label class="form-check-label" for="term3">(필수) 개인정보 수집 및 이용 동의</label>
              <button class="btn btn-link btn-sm ms-2 p-0" type="button" data-bs-toggle="collapse" data-bs-target="#term3Content" aria-expanded="false" aria-controls="term3Content">
                보기
              </button>
              <div class="collapse mt-2" id="term3Content">
                <div class="card card-body">
                  여기에는 "개인정보 수집 및 이용 동의" 관련 약관 내용을 삽입합니다.
                </div>
              </div>
            </div>
            
            <input type="button" class="btn btn-primary btn-lg frm" value="다음">
               
        </div>
    </div>
    <c:import url="../common/footer.jsp"/> 
    
</body>
</html>
