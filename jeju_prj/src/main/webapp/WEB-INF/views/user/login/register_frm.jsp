<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <!-- 부트스트랩 CSS 링크 (원본 그대로) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
          rel="stylesheet" 
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
          crossorigin="anonymous">

    <style>
        body {
            background-color: #fff; /* 바탕색상을 흰색으로 유지 */
            font-family: Arial, sans-serif;
            font-size: 1.3em;
        }
        .container {
            max-width: 430px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
        }
        .form-title {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-subtitle {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
        .form-check {
            display: inline-block;
            margin-right: 15px;
        }
        .btn-primary {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
        }
        .error-message {
            color: red;
            font-size: 0.5em; /* 폰트 크기를 더 작게 조정 */
        }
        small {
            font-size: 0.6em;
        }
    </style>
</head>

<!-- jQuery CDN (원본 그대로) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script>
    $(document).ready(function () {
        // 📌 '확인' 버튼 클릭 이벤트
        $('#submitBtn').click(function () {
            // 기존 에러 메시지 초기화
            $('.error-message').text('');

            // 1. 입력 필드 값 가져오기
            var userId = $('#user_id').val().trim();         // 아이디
            var password = $('#password').val();             // 비밀번호
            var confirmPassword = $('#confirm-password').val(); // 비밀번호 확인
            var birthYear = $('#birthYear').val();           // 생년
            var birthMonth = $('#birthMonth').val();         // 생월
            var birthDay = $('#birthDay').val();             // 생일
            var gender = $('input[name="gender"]:checked').val(); // 성별
            var userName = $('#user_name').val().trim();     // 이름
            var phoneNumber = $('#phone_number').val().trim();// 전화번호

            // 2. 아이디(특별한 형식 제한 없이 "비어있지 않은지"만 검사)
            if (!userId) {
                $('#idError').text('아이디를 입력하세요.');
                alert('아이디를 입력하세요.');
                $('#user_id').focus();
                return;
            }

            // 3. 비밀번호 길이 검증 (8자 이상)
            if (password.length < 8) {
                $('#passwordError').text('비밀번호는 8자 이상이어야 합니다.');
                alert('비밀번호는 8자 이상이어야 합니다.');
                $('#password').focus();
                return;
            }
            
            
        	
        	if($("#idDupFlag").val() != 'Y' ){
        		alert("아이디중복확인 필수");
        		return
        		
        	}
            

            // 4. 비밀번호 일치 여부 검증
            if (password !== confirmPassword) {
                $('#confirmPasswordError').text('비밀번호가 일치하지 않습니다.');
                alert('비밀번호가 일치하지 않습니다.');
                $('#confirm-password').focus();
                return;
            }

            // 5. 생년월일 검증 (연, 월, 일 모두 선택)
            if (!birthYear || !birthMonth || !birthDay) {
                $('#birthDateError').text('생년월일을 모두 선택하세요.');
                alert('생년월일을 모두 선택하세요.');
                return;
            }

            // 5-1. 선택한 생년월일을 YYYYMMDD 형태로 합침
            var fullBirth = birthYear +
                (birthMonth.length === 1 ? '0' + birthMonth : birthMonth) +
                (birthDay.length === 1 ? '0' + birthDay : birthDay);
            $('#birth').val(fullBirth);  // hidden 필드에 저장

            // 6. 성별 선택 검증
            if (!gender) {
                $('#genderError').text('성별을 선택하세요.');
                alert('성별을 선택하세요.');
                return;
            }

            // 7. 이름 입력 검증
            if (!userName) {
                $('#nameError').text('이름을 입력하세요.');
                alert('이름을 입력하세요.');
                $('#user_name').focus();
                return;
            }

            // 8. 전화번호 검증 (010-1234-5678 형식)
            var phonePattern = /^01([0|1|6|7|8|9])-[0-9]{3,4}-[0-9]{4}$/;
            if (!phonePattern.test(phoneNumber)) {
                $('#phoneError').text('올바른 전화번호 형식을 입력하세요. 예: 010-1234-5678');
                alert('올바른 전화번호 형식을 입력하세요. 예: 010-1234-5678');
                $('#phone_number').focus();
                return;
            }

            // 모든 검증 통과 → 폼 submit
            document.memberFrm.submit();
        });
    });

    // ID 중복 체크 팝업 함수 (기존 그대로)
    function idDup() {
        var left = window.screenX + 350;
        var top = window.screenY + 200;
        var userId = document.memberFrm.user_id.value;
        window.open(
            "/member/idDup?id=" + userId,
            "idDup",
            "width=460,height=380,left=" + left + ",top=" + top
        );
    }
</script>

<body>
<div id="wrap">
    <!-- (원하는 경우) 헤더 임포트 유지 -->
    <c:import url="../common/jsp/header.jsp"/> 

    <div class="container">
        <h2 class="form-title">필수 정보 입력</h2>
        <p class="form-subtitle">가입을 위해 필수 정보를 입력해 주세요.</p>

        <!-- 기존 폼 구조 유지 -->
        <form id="memberFrm" name="memberFrm" method="post" action="/member/joinProcess">
            <!-- 아이디 -->
            <div class="mb-3">
                <label for="user_id" class="form-label">아이디</label>
                <div class="d-flex align-items-center gap-2">
                    <input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력하세요">
                    					<input type="hidden" name="idDupFlag" id="idDupFlag"/>
                    
                    <button class="btn btn-light" type="button" style="white-space: nowrap; padding: 5px 10px;" onclick="idDup()">
                        ID 중복체크
                    </button>
                </div>
                <div class="error-message" id="idError"></div>
            </div>

            <!-- 비밀번호 -->
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호 (8자 이상)">
                <small class="text-muted">8자 이상 입력하세요.</small>
                <div class="error-message" id="passwordError"></div>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="mb-3">
                <label for="confirm-password" class="form-label">비밀번호 확인</label>
                <input type="password" class="form-control" id="confirm-password" name="confirm-password" placeholder="비밀번호 확인">
                <div class="error-message" id="confirmPasswordError"></div>
            </div>

            <!-- 생년월일 (년, 월, 일) -->
            <div class="mb-3">
                <label class="form-label">생년월일</label>
                <div class="d-flex gap-2">
                    <!-- 년도 -->
                    <select class="form-select" id="birthYear" name="birthYear">
                        <option value="" disabled selected>년도</option>
                        <%
                            int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                            for(int i = currentYear; i >= 1900; i--) {
                        %>
                            <option value="<%=i%>"><%=i%></option>
                        <% } %>
                    </select>
                    <!-- 월 -->
                    <select class="form-select" id="birthMonth" name="birthMonth">
                        <option value="" disabled selected>월</option>
                        <%
                            for(int i = 1; i <= 12; i++) {
                        %>
                            <option value="<%=i%>"><%=i%></option>
                        <% } %>
                    </select>
                    <!-- 일 -->
                    <select class="form-select" id="birthDay" name="birthDay">
                        <option value="" disabled selected>일</option>
                        <%
                            for(int i = 1; i <= 31; i++) {
                        %>
                            <option value="<%=i%>"><%=i%></option>
                        <% } %>
                    </select>
                </div>
                <div class="error-message" id="birthDateError"></div>
            </div>

            <!-- 생년월일 합쳐서 넘길 hidden 필드: YYYYMMDD -->
            <input type="hidden" id="birth" name="birth" value="">

            <!-- 성별 -->
            <div class="mb-3">
                <label class="form-label">성별</label>
                <div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" id="male" value="M">
                        <label class="form-check-label" for="male">남자</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" id="female" value="W">
                        <label class="form-check-label" for="female">여자</label>
                    </div>
                </div>
                <div class="error-message" id="genderError"></div>
            </div>

            <!-- 이름 -->
            <div class="mb-3">
                <label for="user_name" class="form-label">이름</label>
                <input type="text" class="form-control" id="user_name" name="user_name" placeholder="예시이름">
                <div class="error-message" id="nameError"></div>
            </div>

            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone_number" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone_number" name="phone_number" placeholder="예: 010-1234-5678">
                <small class="text-muted">형식: 010-1234-5678</small>
                <div class="error-message" id="phoneError"></div>
            </div>

            <!-- 버튼: 자바스크립트 유효성 검사 후 submit() -->
            <input type="button" class="btn btn-primary" id="submitBtn" value="확인">
        </form>
    </div>

    <!-- 푸터 임포트 (원하는 경우 그대로) -->
    <c:import url="../common/jsp/footer.jsp"/> 
</div>
</body>
</html>
