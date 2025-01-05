<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN 시작 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/css/admin/admin-style.css">

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">
</style>
</head>
<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<div class="sidebar">
			<div class="logo">
				<a href="/admin/dashboard"> <img alt="제주어때"
					src="/common/admin/images/logo.svg">
				</a>
			</div>

			<!-- Navigation Menu -->
			<nav class="nav-menu">
				<div class="menu-category">MENU</div>

				<div class="nav-item">
					<div class="nav-header">
						<span>숙소관리</span> <i class="arrow"></i>
					</div>
					<ul class="nav-submenu">
						<li><a href="/admin/acc_list">숙소목록</a></li>
						<li><a href="/admin/add_acc">숙소등록</a></li>
					</ul>
				</div>

				<div class="nav-item">
					<div class="nav-header">
						<span>예약관리</span> <i class="arrow"></i>
					</div>
					<ul class="nav-submenu">
						<li><a href="/admin/res_list">예약목록 조회</a></li>
					</ul>
				</div>

				<div class="nav-item">
					<div class="nav-header">
						<span>리뷰관리</span> <i class="arrow"></i>
					</div>
					<ul class="nav-submenu">
						<li><a href="/admin/review_list">리뷰목록</a></li>
					</ul>
				</div>

				<div class="menu-category">MEMBERSHIP MANAGEMENT</div>

				<div class="nav-item">
					<div class="nav-header">
						<span>회원관리</span> <i class="arrow"></i>
					</div>
					<ul class="nav-submenu">
						<li><a href="/admin/member_list">회원목록</a></li>
					</ul>
				</div>
			</nav>
		</div>

		<!-- Main Content -->
		<div class="main-content">
			<!-- Top Navigation -->
			<div class="top-nav">
				<div class="user-menu">
					<c:if test="${not empty sessionScope.admin_id}">
						<span>${sessionScope.admin_id}</span>
						<a href="/admin/logout" class="logout-link">로그아웃</a>
					</c:if>
				</div>
			</div>



			<script>
			document.addEventListener('DOMContentLoaded', function() {
			    // Toggle submenu with closing others
			    const navHeaders = document.querySelectorAll('.nav-header');
			    navHeaders.forEach(header => {
			        header.addEventListener('click', function() {
			            // Remove active class from all other nav-items
			            navHeaders.forEach(otherHeader => {
			                if (otherHeader !== header) {
			                    otherHeader.parentElement.classList.remove('active');
			                }
			            });
			            // Toggle active class for clicked nav-item
			            this.parentElement.classList.toggle('active');
			        });
			    });
			    
			    // Page and menu mapping using controller URLs
			    const pageMenuMap = {
			        '/admin/acc_list': '숙소목록',
			        '/admin/add_acc': '숙소등록',
			        '/admin/res_list': '예약목록 조회',
			        '/admin/review_list': '리뷰목록',
			        '/admin/member_list': '회원목록'
			    };
			    
			    // Get current path and activate corresponding menu
			    const currentPath = window.location.pathname;
			    
			    // Find and activate the corresponding menu item
			    const menuLinks = document.querySelectorAll('.nav-submenu a');
			    menuLinks.forEach(link => {
			        // Check if the link's href matches the current path
			        if (link.getAttribute('href') === currentPath) {
			            // Activate menu item
			            link.parentElement.classList.add('active');
			            
			            // Find and activate parent nav-item
			            const parentNavItem = link.closest('.nav-item');
			            if (parentNavItem) {
			                // Close other nav-items
			                navHeaders.forEach(header => {
			                    if (header.parentElement !== parentNavItem) {
			                        header.parentElement.classList.remove('active');
			                    }
			                });
			                // Open current nav-item
			                parentNavItem.classList.add('active');
			            }
			        }
			    });

			    // Debug information (optional, can be removed in production)
			    console.log('Current path:', currentPath);
			    console.log('Available menu items:', Object.keys(pageMenuMap));
			});
</script>
</body>
</html>