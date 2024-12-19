<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="JSP 공통 헤더"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
footer {
	background-color: #f9f9f9;
	padding: 20px 0;
	font-family: 'Arial', sans-serif;
	font-size: 14px;
	color: #666;
}

.footer-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between;
}

.customer-center {
	flex: 1;
	min-width: 250px;
	margin-right: 20px;
}

.customer-center h3 {
	font-size: 16px;
	font-weight: bold;
}

.contact {
	margin-top: 10px;
}

.phone {
	font-size: 18px;
	font-weight: bold;
	color: #000;
}

.kakao-btn {
	background-color: #ffde3c;
	color: #000;
	padding: 5px 10px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.kakao-btn:hover {
	background-color: #ffc107;
}

.footer-links {
	flex: 2;
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
}

.footer-links div {
	min-width: 150px;
}

.footer-links h4 {
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 10px;
}

.footer-links ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.footer-links li {
	margin-bottom: 5px;
}

.footer-info {
	flex: 1 1 100%;
	margin-top: 20px;
	font-size: 12px;
	color: #999;
}

.footer-info ul {
	list-style: none;
	padding: 0;
	margin: 10px 0;
	display: flex;
	flex-wrap: wrap;
}

.footer-info li {
	margin-right: 15px;
}

.footer-info a {
	color: #666;
	text-decoration: none;
}

.footer-info a:hover {
	text-decoration: underline;
}
</style>


<footer>
	<div class="footer-container">
		<div class="customer-center">
			<h3>고객센터</h3>
			<p>
				고객행복센터(전화): 오전 9시 ~ 새벽 3시 운영<br>카카오톡 문의: 24시간 운영
			</p>
			<div class="contact">
				<div class="phone">📞 1670-6250</div>
				<button class="kakao-btn">카카오 문의</button>
			</div>
		</div>
		<div class="footer-links">
			<div>
				<h4>회사</h4>
				<ul>
					<li>회사소개</li>
				</ul>
			</div>
			<div>
				<h4>서비스</h4>
				<ul>
					<li>공지사항</li>
					<li>자주 묻는 질문</li>
					<li>기업 출장/복지 서비스 문의</li>
				</ul>
			</div>
			<div>
				<h4>혜택</h4>
				<ul>
					<li>엘리트 멤버십</li>
					<li>트립플리 혜택 안내</li>
					<li>제주어때 상품권 조회</li>
				</ul>
			</div>
			<div>
				<h4>모든 숙소</h4>
				<ul>
					<li>호텔/리조트</li>
					<li>펜션/풀빌라</li>
					<li>캠핑/글램핑</li>
					<li>홈/빌라</li>
					<li>게하/한옥</li>
				</ul>
			</div>
		</div>
		<div class="footer-info">
			<p>
				(주)제주어때컴퍼니<br> 주소: 서울특별시 강남구 봉은사로 479, 479타워 11층 | 대표이사: 정명훈<br>
				사업자등록번호: 742-86-00224 사업자정보확인<br> 전자우편주소: help@yeogi.com |
				통신판매업신고번호: 2017-서울강남-01779 | 관광사업자 등록번호: 제1026-24호 | 전화번호: 1670-6250<br>
				(주)제주어때컴퍼니는 통신판매중개자로서 통신판매의 당사자가 아니며, 상품의 예약, 이용 및 환불 등에 관한 의무와 책임은
				각 판매자에게 있습니다.
			</p>
			<ul class="terms">
				<li><a href="#">이용약관</a></li>
				<li><a href="#">개인정보처리방침</a></li>
				<li><a href="#">소비자 분쟁해결 기준</a></li>
				<li><a href="#">콘텐츠산업진흥법에 의한 표시</a></li>
			</ul>
			<p>Copyright GC COMPANY Corp. All rights reserved.</p>
		</div>
	</div>
</footer>