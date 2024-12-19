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
    
 .frm{
 margin-top: 30px;
 }
 .bld{
 font-weight: bold;
 }
 
 label{
 margin-top: 15px;
 }
</style>

</head>


<body>
    <!-- 헤더 -->
	<c:import url="../common/header.jsp"/> 
    <!-- 로그인 컨텐츠 -->
    <div class="container">
        <div  style="text-align: center">
		<h4 class="bld">회원탈퇴</h4>
		<h5>다음에 꼭 다시 만나요</h5>
		<h5 style=" color:#0B5ED7;">더 나은 모습으로 기다릴게요!</h5>
		<img alt="" src="http://localhost/second_prj/common/images/leave_member.png">
	           			<input type="button" class="btn btn-primary btn-lg " value="메인으로"  >

        </div>
        
        
        
        
    </div>
	<c:import url="../common/footer.jsp"/> 
    
</body>


</html>
