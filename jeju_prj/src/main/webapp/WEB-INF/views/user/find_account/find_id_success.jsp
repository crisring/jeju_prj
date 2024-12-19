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
    
 .frm{
 margin-top: 30px;
 }
</style>

</head>


<body>
    <!-- 헤더 -->
	<c:import url="../common/header.jsp"/> 
    <!-- 로그인 컨텐츠 -->
    <div class="container" >
        <div  style="text-align: center">
            <img src="http://localhost/second_prj/common/svg/logo.svg" alt="제주어때 로고" id="logo" style="display: block; margin: 0 auto;">
            <p class="text-muted">아이디 찾기 성공!</p>
        </div>
      	<div class="d-grid" style="margin-top: 50px">
      		<p style="text-align: center"> XXX님의 아이디는 1234 입니다</p>
	          			<input type="button" class="btn btn-primary btn-lg  frm" value="로그인 페이지로">
	           
        </div>
            <!-- 헤더 -->
    </div>
	<c:import url="../common/footer.jsp"/> 
</body>


</html>
