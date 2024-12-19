<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-color: #fff; /* 바탕색상을 흰색으로 변경 */
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
        small{ font-size: 0.6em; }
    </style>
</head>
  <!-- jQuery CDN -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
   
    <script>
        $(document).ready(function(){
            $('#memberFrm').on('submit', function(e){
                $('.error-message').text(''); // 기존 에러메시지 초기화
                
                var id = $('#id').val().trim();
                var password = $('#password').val();
                var confirmPassword = $('#confirm-password').val();
                var birthYear = $('#birthYear').val();
                var birthMonth = $('#birthMonth').val();
                var birthDay = $('#birthDay').val();
                var gender = $('input[name="gender"]:checked').val();
                var nameVal = $('#name').val().trim();
                var phone = $('#phone').val().trim();
                
                // 이메일 검증
                var idPattern = /^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$/;
                if(!idPattern.test(id)){
                    $('#idError').text('올바른 이메일 형식을 입력하세요.');
                    alert('올바른 이메일 형식을 입력하세요.');
                    $('#id').focus();
                    e.preventDefault();
                    return;
                }

                // 비밀번호 검증 (8자 이상)
                if(password.length < 8){
                    $('#passwordError').text('비밀번호는 8자 이상이어야 합니다.');
                    alert('비밀번호는 8자 이상이어야 합니다.');
                    $('#password').focus();
                    e.preventDefault();
                    return;
                }

                // 비밀번호 확인
                if(password !== confirmPassword){
                    $('#confirmPasswordError').text('비밀번호가 일치하지 않습니다.');
                    alert('비밀번호가 일치하지 않습니다.');
                    $('#confirm-password').focus();
                    e.preventDefault();
                    return;
                }

                // 생년월일 체크
                if(!birthYear || !birthMonth || !birthDay){
                    $('#birthDateError').text('생년월일을 모두 선택하세요.');
                    alert('생년월일을 모두 선택하세요.');
                    if(!birthYear) {
                        $('#birthYear').focus();
                    } else if(!birthMonth) {
                        $('#birthMonth').focus();
                    } else {
                        $('#birthDay').focus();
                    }
                    e.preventDefault();
                    return;
                }

                // 성별 체크
                if(!gender){
                    $('#genderError').text('성별을 선택하세요.');
                    alert('성별을 선택하세요.');
                    $('#male').focus();
                    e.preventDefault();
                    return;
                }

                // 이름 체크
                if(!nameVal){
                    $('#nameError').text('이름을 입력하세요.');
                    alert('이름을 입력하세요.');
                    $('#name').focus();
                    e.preventDefault();
                    return;
                }

                // 전화번호 정규표현식
                var phonePattern = /^01([0|1|6|7|8|9])-[0-9]{3,4}-[0-9]{4}$/;
                if(!phonePattern.test(phone)){
                    $('#phoneError').text('올바른 전화번호 형식을 입력하세요. 예: 010-1234-5678');
                    alert('올바른 전화번호 형식을 입력하세요. 예: 010-1234-5678');
                    $('#phone').focus();
                    e.preventDefault();
                    return;
                }
            });
        });

        
    	//부모창에서 자식창으로 값 전달 : Query String 만들어서 팝업창 띄우기
    	function idDup(){
    		var left=window.screenX+350;
    		var top=window.screenY+200;
    		
    		//1.현재창에 아이디를 가져와서 
    		var id=document.memberFrm.id.value;
    		
    		//2. query string 만들어서 팝업을 띄운다.
    		window.open("id_dup.jsp?id="+id,"idDup", "width=460,height=380,left="+left+",top="+top);
    	}//idDup
        
        
        
        
        
        
        
        
        
    </script>
<body>
    <div id="wrap">
    <!-- 헤더 -->
    <c:import url="http://localhost/second_prj/common/header.jsp"/> 
    <div class="container">
        <h2 class="form-title">필수 정보 입력</h2>
        <p class="form-subtitle">가입을 위해 필수 정보를 입력해 주세요.</p>
        <form id="memberFrm" name="memberFrm">
          <!-- 아이디(이메일) -->
          <div class="mb-3">
              <label for="id" class="form-label">아이디 (이메일)</label>
              <div class="d-flex align-items-center gap-2">
                  <input type="text" class="form-control" id="id" name="id" placeholder="123@naver.com">
                  <button class="btn btn-light" type="button" style="white-space: nowrap; padding: 5px 10px;" onclick="idDup()">
                      ID 중복체크
                  </button>
              </div>
              <div class="error-message" id="idError"></div>
          </div>

            <!-- 비밀번호 -->
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" name="pass" placeholder="비밀번호">
                <small class="text-muted">8자 이상 입력하세요.</small>
                <div class="error-message" id="passwordError"></div>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="mb-3">
                <label for="confirm-password" class="form-label">비밀번호 확인</label>
                <input type="password" class="form-control" id="confirm-password" placeholder="비밀번호 확인">
                <div class="error-message" id="confirmPasswordError"></div>
            </div>

            <!-- 생년월일 -->
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

            <!-- 성별 -->
            <div class="mb-3">
                <label class="form-label">성별</label>
                <div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" id="male" value="male">
                        <label class="form-check-label" for="male">남자</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                        <label class="form-check-label" for="female">여자</label>
                    </div>
                </div>
                <div class="error-message" id="genderError"></div>
            </div>

            <!-- 이름 -->
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" class="form-control" id="name" name="userName" placeholder="예시이름">
                <div class="error-message" id="nameError"></div>
            </div>

            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="예: 010-1234-5678">
                <small class="text-muted">형식: 010-1234-5678</small>
                <div class="error-message" id="phoneError"></div>
            </div>

            <!-- 버튼 -->
            <button type="submit" class="btn btn-primary">확인</button>
        </form>
    </div>
    
    <c:import url="../common/footer.jsp"/> 
    	</div>
    
</body>
</html>
