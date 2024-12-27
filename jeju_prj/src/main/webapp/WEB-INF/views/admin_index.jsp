<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대시보드</title>
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

.chart-card2 {
	width: 30%;
	min-width: 300px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 15px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.chart-card2 canvas {
	width: 100%;
	margin-top: 80px;
}

h2 {
	font-size: 1.2em;
	margin-bottom: 15px;
}
</style>

<!-- Chart.js 스크립트 -->
<script type="text/javascript">
	$(function() {
		createMonthlyRevenueChart();
		createDailyRevenueChart();
		createRoomRevenueChart();
		createCancellationRateChart();
		createMemberCountChart();
		createPopularACMChart();
	});

	function createMonthlyRevenueChart() {
	    // 숨겨진 input 요소에서 데이터 읽기
	    const labelsData = [...document.querySelectorAll('input[name="reservation_month"]')];
	    const valuesData = [...document.querySelectorAll('input[name="month_total_revenue"]')];

	    const chartData = processChartData(labelsData, valuesData);

	    // 차트 데이터가 유효하지 않으면 종료
	    if (!chartData) return;
	    
	    // 데이터 추출
	    const labels = chartData.map(item => item.label);
	    const data = chartData.map(item => item.data);

	    // 차트 컨텍스트 가져오기
	    const monthlyRevenueChartElement = document.getElementById('monthlyRevenueChart').getContext('2d');
	    chkElement(monthlyRevenueChartElement);
	        
	    // 차트 생성
	    new Chart(monthlyRevenueChartElement, {
	        type: 'line',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: '월간 매출',
	                data: data,
	                borderColor: '#FF5733',
	                backgroundColor: 'rgba(255, 87, 51, 0.2)',
	                fill: false,
	                tension: 0.1,
	            }],
	        },
	        options: {
	            responsive: true,
	            plugins: {
	                legend: {
	                    position: 'top',
	                },
	            },
	            scales: {
	                x: {
	                    title: {
	                        display: true,
	                        text: '월',
	                    },
	                },
	                y: {
	                    title: {
	                        display: true,
	                        text: '매출 (단위: 원)',
	                    },
	                    beginAtZero: true,
	                },
	            },
	        },
	    });
	}// createMonthlyRevenueChart

	// 주간 매출 현황 차트
	function createDailyRevenueChart() {
		const dailyRevenueChartElement = document.getElementById('dailyRevenueChart')
				.getContext('2d');
		
		chkElement(dailyRevenueChartElement);
		
		
	    // 숨겨진 input 요소에서 데이터 읽기
	    const labelsData = [...document.querySelectorAll('input[name="reservation_weekday"]')];
	    const valuesData = [...document.querySelectorAll('input[name="week_total_revenue"]')];

	    const chartData = processChartData(labelsData, valuesData);

	    // 차트 데이터가 유효하지 않으면 종료
	    if (!chartData) return;
	    
	    // 데이터 추출
	    const labels = chartData.map(item => item.label);
	    const data = chartData.map(item => item.data);
	    
	    
		new Chart(dailyRevenueChartElement, {
			type : 'bar',
			data : {
				labels : labels,
				datasets : [ {
					label : '주간 매출',
					data : data,
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
	}// createDailyRevenueChart

	// 숙소유형별 매출 현황 차트
	function createRoomRevenueChart() {
		const accTypeChartElement = document.getElementById('accTypeChart')
				.getContext('2d');
		chkElement(accTypeChartElement);
		
		
	    // 숨겨진 input 요소에서 데이터 읽기
	    const labelsData = [...document.querySelectorAll('input[name="acm_type"]')];
	    const valuesData = [...document.querySelectorAll('input[name="ACCType_total_revenue"]')];

	    const chartData = processChartData(labelsData, valuesData);

	    // 차트 데이터가 유효하지 않으면 종료
	    if (!chartData) return;
	    
	    // 데이터 추출
	    const labels = chartData.map(item => item.label);
	    const data = chartData.map(item => item.data);
		
		
		

		new Chart(accTypeChartElement, {
			type : 'pie',
			data : {
				labels : labels,
				datasets : [ {
					label : '숙소 유형별 매출',
					data : data,
					backgroundColor : [ '#FF5733', '#33FF57', '#3357FF' ]
				} ]
			}
		});
	}// createRoomRevenueChart

	
	// 취소율 통계 차트
	function createCancellationRateChart() {
	  const cancellationRateChartElement = document.getElementById('cancellationRateChart').getContext('2d');
	  chkElement(cancellationRateChartElement);
	  
	  // 숨겨진 input 요소에서 데이터 읽기
	  const cancellation_count = parseInt(document.querySelector('input[name="cancellation_count"]').value);
	  const total_reservation_count = parseInt(document.querySelector('input[name="total_reservation_count"]').value);
	  
	  // 데이터 준비 (전체 예약에서 취소 예약의 비율 계산)
	  const data = {
	    cancellation_count: cancellation_count,
	    total_reservation_count: total_reservation_count
	  };
	  
	  // 차트 그리기
	  new Chart(cancellationRateChartElement, {
	    type: 'doughnut',
	    data: {
	      labels: ['취소된 예약', '전체 예약'],
	      datasets: [{
	        label: '취소율 통계',
	        data: [data.cancellation_count, data.total_reservation_count - data.cancellation_count], // 전체 예약에서 취소 예약을 제외한 값
	        backgroundColor: ['#FF6347', '#4CAF50']
	      }]
	    }
	  });
	} // createCancellationRateChart


	// 회원수 차트
	function createMemberCountChart() {
		const memberCountChartElement = document.getElementById('memberCountChart')
				.getContext('2d');
		  chkElement(memberCountChartElement);
		  
		  // 숨겨진 input 요소에서 데이터 읽기
		  const newMemberCnt = parseInt(document.querySelector('input[name="newMemberCnt"]').value);
		  const totalMemberCnt = parseInt(document.querySelector('input[name="totalMemberCnt"]').value);
		  
		  // 데이터 준비 (전체 예약에서 취소 예약의 비율 계산)
		  const data = {
				  newMemberCnt: newMemberCnt,
				  totalMemberCnt: totalMemberCnt
		  };
		  	
		  // 차트 그리기
		  new Chart(memberCountChartElement, {
		    type: 'doughnut',
		    data: {
		      labels: ['신규 회원수', '전체 회원수'],
		      datasets: [{
		        label: '회원율 통계',
		        data: [data.newMemberCnt, data.totalMemberCnt - data.newMemberCnt],
		        backgroundColor: ['#1E90FF', '#87CEEB'] 
		      }]
		    }
		  });
		
	}// createMemberCountChart

	// 인기있는 숙소 Top3 차트
	function createPopularACMChart() {
		const createPopularACMChartElement = document.getElementById('popularACMChart')
				.getContext('2d');
		  chkElement(createPopularACMChartElement);

		    // 숨겨진 input 요소에서 데이터 읽기
		    const labelsData = [...document.querySelectorAll('input[name="acm_name"]')];
		    const valuesData = [...document.querySelectorAll('input[name="popular_total_revenue"]')];

		    const chartData = processChartData(labelsData, valuesData);

		    // 차트 데이터가 유효하지 않으면 종료
		    if (!chartData) return;
		    
		    // 데이터 추출
		    const labels = chartData.map(item => item.label);
		    const data = chartData.map(item => item.data);
		  
		    console.log(labels)
		    
		new Chart(createPopularACMChartElement, {
			type : 'bar',
			data : {
				labels : labels,
				datasets : [ {
					label : '인기 매출',
					data : data,
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
							text : '매출 (단위: 원)'
						}
					}
				}
			}
		});
	}
	
	// 차트 데이터 처리 함수
	function processChartData(labelsData, valuesData) {
	    // 두 배열의 길이 확인 및 일치하지 않으면 처리하지 않음
	    if (labelsData.length !== valuesData.length) {
	        console.error("차트 라벨과 데이터의 개수가 일치하지 않습니다.");
	        return null; // 데이터가 일치하지 않으면 null 반환
	    }

	    // 데이터 매핑 및 필터링
	    const chartData = labelsData
	        .map((labelInput, index) => ({
	            label: labelInput.value.trim(), 
	            data: parseFloat(valuesData[index]?.value.trim()) || 0, 
	        }))
	        .filter(item => item.label && !isNaN(item.data)); // 공백 및 NaN 제거

	    // 필터링 후 데이터가 비어 있으면 경고 및 종료
	    if (chartData.length === 0) {
	        console.warn("유효한 데이터가 없습니다.");
	        return null;
	    }

	    return chartData;
	}
	
	// 캔버스 요소 검사
	function chkElement(chartElement){
		 if (!chartElement) {
		        console.error("캔버스 요소를 찾을 수 없습니다.");
		        return;
		    }
	}// chkElement
	
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
				<div class="chart-card2">
					<h2>월간 매출 현황</h2>
					<canvas id="monthlyRevenueChart"></canvas>
					<c:forEach var="month" items="${monthlyList}" varStatus="i">
						<input type="hidden" name="reservation_month"
							value="${month.reservation_month}" />
						<input type="hidden" name="month_total_revenue"
							value="${month.total_revenue}" />
					</c:forEach>

				</div>
				<div class="chart-card2">
					<h2>주간 매출 현황</h2>
					<canvas id="dailyRevenueChart"></canvas>
					<c:forEach var="week" items="${weeklyList}" varStatus="i">
						<input type="hidden" name="reservation_weekday"
							value="${week.reservation_weekday}" />
						<input type="hidden" name="week_total_revenue"
							value="${week.total_revenue}" />
					</c:forEach>

				</div>
				<div class="chart-card">
					<h2>숙소 유형별 매출 현황</h2>
					<canvas id="accTypeChart"></canvas>
					<c:forEach var="ACCType" items="${ACCTypeList}" varStatus="i">
						<input type="hidden" name="acm_type" value="${ACCType.acm_type}" />
						<input type="hidden" name="ACCType_total_revenue"
							value="${ACCType.total_revenue}" />
					</c:forEach>

				</div>
			</div>
		</div>

		<!-- 예약분석 영역 (아랫칸) -->
		<div id="booking-analysis" class="section">
			<div class="chart-row">
				<div class="chart-card">
					<h2>취소율 통계</h2>
					<canvas id="cancellationRateChart"></canvas>
					<input type="hidden" name="cancellation_count"
						value="${cancelRate.cancellation_count}" /> <input type="hidden"
						name="total_reservation_count"
						value="${cancelRate.total_reservation_count}" />

				</div>
				<div class="chart-card">
					<h2>이번달 신규 회원수</h2>
					<canvas id="memberCountChart"></canvas>
					<input type="hidden" name="newMemberCnt"
						value="${memberCnt.newMemberCnt}" /> <input type="hidden"
						name="totalMemberCnt" value="${memberCnt.totalMemberCnt}" />

				</div>
				<div class="chart-card2">
					<h2>TOP3 숙소 매출 현황</h2>
					<canvas id="popularACMChart"></canvas>
					<c:forEach var="popular" items="${popularACM}" varStatus="i">
						<input type="hidden" name="acm_name" value="${popular.acm_name}" />
						<input type="hidden" name="popular_total_revenue"
							value="${popular.total_revenue}" />
					</c:forEach>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="admin/common/footer.jsp" />
</body>
</html>