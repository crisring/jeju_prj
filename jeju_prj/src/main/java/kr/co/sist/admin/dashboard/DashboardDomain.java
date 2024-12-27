package kr.co.sist.admin.dashboard;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DashboardDomain {

	// 총 매출
	private int total_revenue;

	// 월간 매출
	private String reservation_month;

	// 일간 매출
	private String reservation_date;
	private String reservation_weekday;

	// 숙소 유형별 매출
	private String acm_type;

	// 취소율 계산
	private int cancellation_count;
	private int total_reservation_count;

	// 회원수 계산
	private int newMemberCnt;
	private int totalMemberCnt;

	// 인기 숙소 매출
	private String acm_name;

}
