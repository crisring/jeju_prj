package kr.co.sist.admin.dashboard;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DashboardService {

	@Autowired
	private DashboardDAO dDAO;

	// 월간 매출 현황
	public List<DashboardDomain> calculateMonthlySales() {

		List<DashboardDomain> list = null;

		try {
			list = dDAO.getMonthlySales();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// calculateMonthlySales

	// 주간 매출 현황
	public List<DashboardDomain> calculateWeeklySales() {

		List<DashboardDomain> list = null;

		try {
			list = dDAO.getWeeklySales();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// calculateWeeklySales

	// 숙소 유형별 매출 현황
	public List<DashboardDomain> calculateACCTypeSales() {

		List<DashboardDomain> list = null;

		try {
			list = dDAO.getACCTypeSales();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// calculateACCTypeSales

	// 취소율 현황
	public DashboardDomain calculateCancelRate() {

		DashboardDomain dd = null;

		try {
			dd = dDAO.getCancelRate();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return dd;
	}// calculateCancelRate

	// 회원수 검색
	public DashboardDomain searchMemberCount() {

		DashboardDomain dd = null;

		try {
			dd = dDAO.selectMember();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return dd;
	}// searchMemberCount

	// 인기 숙소 매출 현황
	public List<DashboardDomain> calculatePopularACM() {

		List<DashboardDomain> list = null;

		try {
			list = dDAO.selectPopularACM();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// calculatePopularACM

}
