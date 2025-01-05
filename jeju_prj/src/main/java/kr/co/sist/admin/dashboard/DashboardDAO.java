package kr.co.sist.admin.dashboard;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class DashboardDAO {

	// 월간 매출 현황
	public List<DashboardDomain> getMonthlySales(String admin_id) throws PersistenceException {

		List<DashboardDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.dashboardMapper.selectMonthlySales", admin_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// getMonthlySales

	// 주간 매출 현황
	public List<DashboardDomain> getWeeklySales(String admin_id) throws PersistenceException {

		List<DashboardDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.dashboardMapper.selectWeeklySales", admin_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// getWeeklySales

	// 숙소 유형별 매출 현황
	public List<DashboardDomain> getACCTypeSales(String admin_id) throws PersistenceException {

		List<DashboardDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.dashboardMapper.selectACCTypeSales", admin_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// getACCTypeSales

	// 취소율 현황
	public DashboardDomain getCancelRate(String admin_id) throws PersistenceException {

		DashboardDomain dd = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			dd = handler.selectOne("kr.co.sist.dashboardMapper.selectCancelRate", admin_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return dd;
	}// getCancelRate

	// 회원수(총회원, 신규회원) 현황
	public DashboardDomain selectMember() throws PersistenceException {

		DashboardDomain dd = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			dd = handler.selectOne("kr.co.sist.dashboardMapper.selectMemberCount");
		} finally {
			mbh.closeHandler(handler);
		}

		return dd;
	}// selectMember

	// 인기 상위 top3 숙소 매출 현황
	public List<DashboardDomain> selectPopularACM(String admin_id) throws PersistenceException {

		List<DashboardDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.dashboardMapper.selectPopularACM", admin_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// selectPopularACM

	public static void main(String[] args) {

		DashboardDAO dDAO = new DashboardDAO();
		DashboardDomain list = dDAO.getCancelRate("admin");
		System.out.println(list);

	}

}// class
