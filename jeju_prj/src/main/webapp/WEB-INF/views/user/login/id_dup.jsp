<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- bootstrap CDN 끝-->

<style type="text/css">
#wrap{ width: 452px; height: 370px ;margin: 0px auto;}
#idBg{ width: 452px; height: 370px ;
	background: #FFFFFF url(../common/images/id_dup_bg.png) no-repeat;position: relative; }
#resultDiv{ margin-top: 10px; margin-bottom: 10px}
#idFrm{ position: absolute;top:220px ;left:70px }

</style>
<script type="text/javascript">
window.onload= function() {
document.getElementById("btnUse").addEventListener("click",sendId);
	
	
}//onload

function sendId() {
	
	
	//1.자식창의 아이디 값을 가져와서
	var subId=document.idDupFrm.id.value;
	
	//2. 부모창에 HTML Form Control에 섲렁하고
	opener.window.document.memberFrm.id.value=subId;
	//3. 자식창을 닫는다.
	self.close();
}//sendId



</script>
</head>
<body>
<div id="wrap">
	<div id="idBg">
	<form name="idDupFrm">
	<div id="idFrm">
		<input type="text" name="id" id="id" class="inputBox" value="${param.id}"/>
		<input type="button" value="아이디 중복확인" class="btnMy" style="width: 140px"/>
		
		<div id="resultDiv">사용하실 아이디는(은) <span id="resultMsg">사용 가능 한 </span>아이디 입니다.</div>
		<div style="text-align: center">
		<input type="button" value="사용" id="btnUse" class="btn btn-info"/>
		</div>
	</div>
	</form>
	</div>
</div>
</body>
</html>