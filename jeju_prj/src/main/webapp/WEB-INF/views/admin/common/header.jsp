<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="/css/admin/admin-style.css">

<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">

</style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">
                <a href="http://localhost/project2/admin_index.jsp">
                <img alt="제주어때" src="/admin/images/logo.svg">
                </a>
            </div>
            
            <!-- Navigation Menu -->
            <nav class="nav-menu">
			    <div class="menu-category">MENU</div>
			    
			    <div class="nav-item">
			        <div class="nav-header">
			            <span>숙소관리</span>
			            <i class="arrow"></i>
			        </div>
			        <ul class="nav-submenu">
			            <li><a href="/admin/searchACM">숙소목록</a></li>
			            <li><a href="http://localhost/project2/admin/add_acc.jsp">숙소등록</a></li>
			        </ul>
			    </div>
			    
			    <div class="nav-item">
			        <div class="nav-header">
			            <span>예약관리</span>
			            <i class="arrow"></i>
			        </div>
			        <ul class="nav-submenu">
			            <li><a href="http://localhost/project2/admin/reservation_list.jsp">예약목록 조회</a></li>
			        </ul>
			    </div>
			    
			    <div class="nav-item">
			        <div class="nav-header">
			            <span>리뷰관리</span>
			            <i class="arrow"></i>
			        </div>
			        <ul class="nav-submenu">
			            <li><a href="http://localhost/project2/admin/review_list.jsp">리뷰목록</a></li>
			        </ul>
			    </div>
			
			    <div class="menu-category">MEMBERSHIP MANAGEMENT</div>
			    
			    <div class="nav-item">
			        <div class="nav-header">
			            <span>회원관리</span>
			            <i class="arrow"></i>
			        </div>
			        <ul class="nav-submenu">
			            <li><a href="http://localhost/project2/admin/member_list.jsp">회원목록</a></li>
			        </ul>
			    </div>
			</nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Top Navigation -->
            <div class="top-nav">
                <div class="user-menu">
                    <c:if test="${not empty sessionScope.adminId}">
                        <span>${sessionScope.adminId}</span>
                        <a href="/admin/logout" class="logout-link">로그아웃</a>
                    </c:if>
                    admin아이디 부분
                </div>
            </div>
           
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Toggle submenu with closing others
        const navHeaders = document.querySelectorAll('.nav-header');
        navHeaders.forEach(header => {
            header.addEventListener('click', function() {
                // 다른 모든 nav-item의 active 클래스 제거
                navHeaders.forEach(otherHeader => {
                    if (otherHeader !== header) {
                        otherHeader.parentElement.classList.remove('active');
                    }
                });
                // 클릭된 nav-item의 active 토글
                this.parentElement.classList.toggle('active');
            });
        });
        
        // 페이지와 메뉴 매핑
        const pageMenuMap = {
            'acc_list.jsp': '숙소목록',
            'add_acc.jsp': '숙소등록',
            'reservation_list.jsp':'예약목록 조회',
            'review_list.jsp':'리뷰목록',
            'member_list.jsp':'회원목록'
            
            // 여기에 다른 페이지와 메뉴 이름 매핑 추가
            // 'some_page.jsp': '해당메뉴이름',
        };
        
        // Highlight current page and keep submenu open
        const currentPath = window.location.pathname;
        const currentFile = currentPath.split('/').pop();
        const menuLinks = document.querySelectorAll('.nav-submenu a');
        
        menuLinks.forEach(link => {
            if (pageMenuMap[currentFile] === link.textContent) {
                // 메뉴 아이템 활성화
                link.parentElement.classList.add('active');
                // 부모 nav-item 찾아서 active 클래스 추가
                let parentNavItem = link.closest('.nav-item');
                if (parentNavItem) {
                    navHeaders.forEach(header => {
                        if (header.parentElement !== parentNavItem) {
                            header.parentElement.classList.remove('active');
                        }
                    });
                    parentNavItem.classList.add('active');
                }
            }
        });
    });
</script>
</body>
</html>