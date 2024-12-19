<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style type="text/css">
/* 전체 헤더 스타일 */
header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 10px 20px;
	background-color: #f8f9fa;
	border-bottom: 1px solid #ddd;
}

/* 사이드바 스타일 */
.sidebar {
	width: 15%;
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

#logo {
	margin-left: 300px;
	width: 200px;
	height: auto;
}

/* 메뉴 스타일 */
.menu {
	display: flex;
	align-items: center;
	gap: 10px;
	position: relative;
	transform: translateX(-450px); /* 왼쪽으로 20px 이동 */
}

/* 로그인 버튼 스타일 */
.login-btn {
	padding: 5px 15px;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #fff;
	font-size: 14px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.login-btn:hover {
	background-color: #f1f1f1;
}

/* 햄버거 메뉴 스타일 */
.hamburger-menu {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	width: 20px;
	height: 15px;
	cursor: pointer;
}

.hamburger-menu span {
	display: block;
	height: 3px;
	background-color: #333;
	border-radius: 2px;
}

/* 드롭다운 메뉴 스타일 */
.dropdown-menu {
	position: absolute;
	top: 50px;
	right: 0;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	display: none; /* 기본적으로 숨김 */
	flex-direction: column;
	width: 150px;
	padding: 10px;
	z-index: 100;
}

.user-name {
	font-weight: bold;
	margin-bottom: 10px;
}

.dropdown-menu a {
	text-decoration: none;
	color: #333;
	padding: 5px 0;
	display: block;
	font-size: 14px;
	transition: color 0.3s ease;
}

.dropdown-menu a:hover {
	color: #007bff;
}
</style>



<script type="text/javascript">
	function toggleMenu() {
		const dropdown = document.getElementById("dropdownMenu");
		dropdown.style.display = dropdown.style.display === "block" ? "none"
				: "block";
	}

	// 페이지를 클릭했을 때 메뉴를 닫는 이벤트 추가
	document.addEventListener("click", function(event) {
		const dropdown = document.getElementById("dropdownMenu");
		const hamburger = document.querySelector(".hamburger-menu");
		if (!hamburger.contains(event.target)
				&& !dropdown.contains(event.target)) {
			dropdown.style.display = "none";
		}
	});
</script>


<header>
	<div class="sidebar">
		<a href="/"> <img src="http://localhost/common/svg/logo.svg"
			alt="제주어때 로고" id="logo">
		</a>
	</div>

	<div class="menu">
		<button class="login-btn">로그인/회원가입</button>
		<div class="hamburger-menu" onclick="toggleMenu()">
			<span></span> <span></span> <span></span>
		</div>
		<div class="dropdown-menu" id="dropdownMenu">
			<a href="/mypage/checkPassFrm" class="user-name">김지훈님</a> <a href="#">로그아웃</a>
			<a href="/mypage/rerListFrm">예약 내역</a>
		</div>

	</div>
</header>
