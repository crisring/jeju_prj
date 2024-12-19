<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- sidebar.jsp -->

<!-- sidebar 관련 HTML -->
<div id="sidebar" class="btn-group-vertical" role="group"
	aria-label="Vertical button group">
	<a href="/mypage/rerListFrm" class="btn btn-outline-secondary"
		onclick="setActive(this)">예약내역</a> <a href="#"
		class="btn btn-outline-secondary" onclick="setActive(this)">내정보관리</a>
	<a href="#" class="btn btn-outline-secondary" onclick="setActive(this)">리뷰관리</a>
</div>

<!-- sidebar 관련 CSS -->
<style type="text/css">
#sidebar {
	height: 200px;
	width: 200px;
	position: absolute;
	margin-left: 325px;
	margin-top: 30px;
}

/* sidebar 내부 버튼 스타일 */
#sidebar .btn-outline-secondary {
	color: #6c757d;
	background-color: white;
	border: 1px solid #dee2e6;
	text-align: left;
	position: relative;
	padding-right: 30px;
}

/* Hover 상태 */
#sidebar .btn-outline-secondary:hover {
	color: #6c757d;
	background-color: white;
}

/* Active 상태 */
#sidebar .btn-outline-secondary.active {
	color: #007bff;
}

/* 오른쪽 기호 추가 */
#sidebar .btn-outline-secondary::after {
	content: ">";
	position: absolute;
	right: 10px;
	color: #6c757d;
}

/* 클릭된 버튼의 기호 색 변경 */
#sidebar .btn-outline-secondary.active::after {
	color: #007bff;
}

/* 반응형: 사이드바를 화면 크기에 따라 재배치 */
@media screen and (max-width: 1200px) {
	#sidebar {
		position: relative;
		margin-left: auto;
		margin-right: auto;
		margin-top: 20px;
	}
}

@media screen and (max-width: 768px) {
	#sidebar {
		width: 100%;
		margin-top: 0;
	}
}
</style>

<!-- sidebar 관련 스크립트 -->
<script type="text/javascript">
function setActive(element) {
  // 모든 버튼에서 active 클래스 제거
  document.querySelectorAll("#sidebar .btn-outline-secondary").forEach((btn) => {
    btn.classList.remove("active");
  });
  // 클릭된 버튼에 active 클래스 추가
  element.classList.add("active");
}
</script>
