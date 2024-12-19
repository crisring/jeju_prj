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

<!-- jQuery CDN 시작 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- Chart.js 라이브러리 추가 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<!-- CSS 스타일 -->
<style type="text/css">
#wrap {
	width: 80%;
	margin: 0 auto;
}

#header h1 {
	text-align: center;
	margin-bottom: 30px;
}

.section {
	margin-bottom: 50px;
}

.chart-row {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	flex-wrap: wrap;
}

.chart-card {
	width: 30%;
	min-width: 300px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 15px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.chart-card canvas {
	width: 100%;
	height: 300px;
	margin-top: 30px;
}

h2 {
	font-size: 1.2em;
	margin-bottom: 15px;
}
</style>

<!-- Chart.js 스크립트 -->
<script type="text/javascript">
	$(function() {
		// 연간 매출 현황 차트
		const annualRevenueCtx = document.getElementById('annualRevenueChart')
				.getContext('2d');
		const annualRevenueChart = new Chart(annualRevenueCtx, {
			type : 'line', // 차트 종류 (선 그래프)
			data : {
				labels : [ '1월
	', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
						'9월', '10월', '11월', '12월' ], // x축 데이터
				datasets : [ {
					label : '연간 매출',
					data : [ 12000, 15000, 18000, 22000, 25000, 30000, 35000,
							40000, 45000, 50000, 55000, 60000 ], // y축 데이터
					borderColor : '#FF5733', // 선 색상
					fill : false, // 선 아래 영역을 채우지 않음
					tension : 0.1
				} ]
			},
			options : {
				responsive : true,
				scales : {
					x : {
						title : {
							display : true,
							text : '월'
						}
					},
					y : {
						title : {
							display : true,
							text : '매출 (단위: 원)'
						}
					}
				}
			}
		});

		// 일간 매출 현황 차트
		const dailyRevenueCtx = document.getElementById('dailyRevenueChart')
				.getContext('2d');
		const dailyRevenueChart = new Chart(dailyRevenueCtx, {
			type : 'bar', // 차트 종류 (막대 그래프)
			data : {
				labels : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
				datasets : [ {
					label : '일간 매출',
					data : [ 5000, 7000, 8000, 12000, 15000, 20000, 25000 ],
					backgroundColor : '#4CAF50',
					borderColor : '#4CAF50',
					borderWidth : 1
				} ]
			},
			options : {
				responsive : true,
				scales : {
					y : {
						beginAtZero : true,
						title : {
							display : true,
							text : '매출 (단위: 원)'
						}
					}
				}
			}
		});

		// 객실별 매출 현황 차트
		const roomRevenueCtx = document.getElementById('roomRevenueChart')
				.getContext('2d');
		const roomRevenueChart = new Chart(roomRevenueCtx, {
			type : 'pie', // 차트 종류 (원 그래프)
			data : {
				labels : [ '싱글룸', '더블룸', '스위트룸' ],
				datasets : [ {
					label : '객실별 매출',
					data : [ 15000, 30000, 50000 ],
					backgroundColor : [ '#FF5733', '#33FF57', '#3357FF' ]
				} ]
			}
		});

		// 취소율 통계 차트
		const cancellationRateCtx = document.getElementById(
				'cancellationRateChart').getContext('2d');
		const cancellationRateChart = new Chart(cancellationRateCtx, {
			type : 'doughnut', // 차트 종류 (도넛 그래프)
			data : {
				labels : [ '취소된 예약', '정상 예약' ],
				datasets : [ {
					label : '취소율 통계',
					data : [ 30, 70 ],
					backgroundColor : [ '#FF6347', '#4CAF50' ]
				} ]
			}
		});

		// 기간별 예약율 차트
		const bookingRateCtx = document.getElementById('bookingRateChart')
				.getContext('2d');
		const bookingRateChart = new Chart(bookingRateCtx, {
			type : 'line', // 차트 종류 (선 그래프)
			data : {
				labels : [ '1일', '7일', '15일', '30일' ],
				datasets : [ {
					label : '기간별 예약율',
					data : [ 20, 50, 70, 90 ],
					borderColor : '#2196F3',
					fill : false,
					tension : 0.1
				} ]
			},
			options : {
				responsive : true,
				scales : {
					x : {
						title : {
							display : true,
							text : '기간'
						}
					},
					y : {
						title : {
							display : true,
							text : '예약율 (%)'
						}
					}
				}
			}
		});

		// 객실별 예약 현황 차트
		const roomBookingCtx = document.getElementById('roomBookingChart')
				.getContext('2d');
		const roomBookingChart = new Chart(roomBookingCtx, {
			type : 'bar', // 차트 종류 (막대 그래프)
			data : {
				labels : [ '싱글룸', '더블룸', '스위트룸' ],
				datasets : [ {
					label : '객실별 예약 현황',
					data : [ 150, 200, 250 ],
					backgroundColor : '#FFC107',
					borderColor : '#FFC107',
					borderWidth : 1
				} ]
			},
			options : {
				responsive : true,
				scales : {
					y : {
						beginAtZero : true,
						title : {
							display : true,
							text : '예약 건수'
						}
					}
				}
			}
		});
	});//ready
</script>


</head>
<body>
	<jsp:include page="admin/common/header.jsp" />

	<div id="wrap">
		<!-- 대시보드 상단 영역 -->
		<div id="header">
			<h1>대시보드</h1>
		</div>

		<!-- 매출분석 영역 (윗칸) -->
		<div id="revenue-analysis" class="section">
			<div class="chart-row">
				<div class="chart-card">
					<h2>연간 매출 현황</h2>
					<canvas id="annualRevenueChart"></canvas>
				</div>
				<div class="chart-card">
					<h2>일간 매출 현황</h2>
					<canvas id="dailyRevenueChart"></canvas>
				</div>
				<div class="chart-card">
					<h2>객실별 매출 현황</h2>
					<canvas id="roomRevenueChart"></canvas>
				</div>
			</div>
		</div>

		<!-- 예약분석 영역 (아랫칸) -->
		<div id="booking-analysis" class="section">
			<div class="chart-row">
				<div class="chart-card">
					<h2>취소율 통계</h2>
					<canvas id="cancellationRateChart"></canvas>
				</div>
				<div class="chart-card">
					<h2>기간별 예약율</h2>
					<canvas id="bookingRateChart"></canvas>
				</div>
				<div class="chart-card">
					<h2>객실별 예약 현황</h2>
					<canvas id="roomBookingChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="admin/common/footer.jsp" />
</body>
</html>