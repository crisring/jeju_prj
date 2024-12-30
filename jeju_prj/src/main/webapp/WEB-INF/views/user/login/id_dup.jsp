<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- bootstrap CDN 끝-->
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
#wrap{ width: 452px; height: 370px ;margin: 0px auto;}
#idBg{ width: 452px; height: 370px ;
	background: #FFFFFF url("http://localhost/common/user/images/id_dup_bg.png")  no-repeat;position: relative; }
#resultDiv{ margin-top: 260px; margin-bottom: 10px; position: absolute; left:10px}
#resultDiv2{ margin-top: 260px; margin-bottom: 10px; position: absolute; left:60px}
#idFrm{ position: absolute;top:220px ;left:70px }

</style>
<script type="text/javascript">
$(function(){
	
	
$("#btn").click(function(){
		chkNull();	
	});//btn_click 	
	$("#id").keydown(function(evt){
		if(evt.which ==13){
			chkNull();
			
		}//end if
	})

	$("#btnUse").click(function(){
	useId();
	});//btn_click 	
	
	
	
})//ready


function useId(){
    var id = $("#id").val();
    // 부모 창과 동일하게 'user_id'로
    opener.window.document.memberFrm.user_id.value = id;
    // 중복 확인 여부
    opener.window.document.memberFrm.idDupFlag.value = 'Y';
    self.close();
}

function chkNull(){
var id=$("#id").val();
	
	if( id.replace(/ /g,"")==""){
		alert("아이디는 필수 입력 입니다.");
		$("#id").val("");
		$("#id").focus();
		return;
	}//end if

	$("#idDupFrm").submit();//action이 걸려있는 page로 이동..
	
}//chkNull


</script>
</head>

<body>
<div id="wrap">
	<div id="idBg">
	<form name="idDupFrm" id="idDupFrm" action="/member/idDup">
	<div id="idFrm">
		<input type="text" name="id" id="id" class="inputBox" value="${param.id}"/>
		<input type="button" id="btn" value="아이디 중복확인" class="btnMy" style="width: 140px" name="chkId" id="chkId"/>
		<input type="text" style="display: none;"/>
		<!-- web browser에서 키입력을 받는 HTML Form Control이 하나인 경우,
		엔터를 치면 자동으로 submit이 된다..(자바스크립트 유효성 검증을 실패해도, submit이 된다.)
		이를 막기위해 <input type="text" style="display: none;"/> 보이지 않게 생성해서
		input이 하나 더 있는것처럼 브라우저에 인식시킨다.
		 -->
			</div>
	</form>
	<c:choose>
    <c:when test="${empty idDupFlag}">
    </c:when>

    <c:when test="${idDupFlag}">
        <div id="resultDiv" style="margin-top: 260px; position: absolute; left:10px;">
            사용하실 아이디는(은) 
            <span id="resultMsg">사용 가능 한 </span> 아이디 입니다.
            <div style="text-align: center">
                <input type="button" value="사용" id="btnUse" class="btn btn-info"/>
            </div>
        </div>
    </c:when>

    <c:otherwise>
        <div id="resultDiv2" style="margin-top: 260px; position: absolute; left:60px;">
            입력하신 아이디는 
            <span id="resultMsg" style="color:#FF0000">사용중인</span> 아이디입니다.
        </div>
    </c:otherwise>
</c:choose>

	
	
	
	</div>
</div>
</body>
</html>