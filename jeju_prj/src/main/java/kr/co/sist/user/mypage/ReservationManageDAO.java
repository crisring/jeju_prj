package kr.co.sist.user.mypage;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.util.SearchVO;

@Repository
public class ReservationManageDAO {

	/**
	 * 스칼라 쿼리로 사용자 아이디를 넣어 조회 - 결제완료
	 * 
	 * @param user_id
	 * @return
	 * @throws PersistenceException
	 */
	public List<ReservationDomain> selectAllReservation(String user_id) throws PersistenceException {

		List<ReservationDomain> list = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.RSRManageMapper.selectAllReservation", user_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// selectAllReservation

	/**
	 * '이용완료' 총 게시물의 수 검색
	 * 
	 * @param sVO
	 * @return 게시물의 수
	 * @throws SQLException
	 */
	public int selectTotalCount(String user_id) throws PersistenceException {
		int totalCount = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		try {
			totalCount = handler.selectOne("kr.co.sist.RSRManageMapper.totalCnt", user_id);
		} finally {
			mbh.closeHandler(handler);
		} // end finally

		return totalCount;
	}// selectTotalCount

	/**
	 * 스칼라 쿼리로 사용자 아이디를 넣어 조회 - 이용완료
	 * 
	 * @param user_id
	 * @return
	 * @throws PersistenceException
	 */
	public List<ReservationDomain> selectAllReservation2(SearchVO sVO) throws PersistenceException {

		List<ReservationDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.RSRManageMapper.selectAllReservation2", sVO);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// selectAllReservation2

	/**
	 * 취소신청 update
	 * 
	 * @param rsr_id
	 * @return
	 */
	public int updateReservation(int rsr_id) {
		int rowCnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {
			rowCnt = handler.update("kr.co.sist.RSRManageMapper.updateReservation", rsr_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return rowCnt;
	}// updateReservation

	/**
	 * 트랜잭션 처리로 리뷰 추가 후 리뷰 이미지 추가
	 * 
	 * @param rVO
	 * @return
	 * @throws PersistenceException
	 */
	public boolean insertReview(ReviewVO rVO) throws PersistenceException {
		boolean flag = false;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(false); // auto commit 비활성

		try {
			int reviewId = handler.selectOne("kr.co.sist.RSRManageMapper.getReviewId");
			rVO.setReview_id(reviewId);

			// 리뷰 삽입
			int reviewInsertCount = handler.insert("kr.co.sist.RSRManageMapper.insertReview", rVO);

			// 이미지 삽입
			int imageInsertCount = insertReviewImages(handler, rVO);

			// 목표 행 수 = 리뷰 1개 + 이미지 수
			int expectedCount = 1 + rVO.getImg_names().length;
			if (reviewInsertCount + imageInsertCount == expectedCount) {
				handler.commit();
				flag = true;
			} else {
				handler.rollback();
			}
		} catch (Exception e) {
			handler.rollback();
			e.printStackTrace(); // 예외 로그 기록
		} finally {
			mbh.closeHandler(handler);
		}

		return flag;
	}// insertReview

	/**
	 * 리뷰 이미지 삽입
	 */
	private int insertReviewImages(SqlSession handler, ReviewVO rVO) throws PersistenceException {
		int cnt = 0;

		for (String imgName : rVO.getImg_names()) {
			rVO.setImg_name(imgName);
			cnt += handler.insert("kr.co.sist.RSRManageMapper.insertReviewImg", rVO);
		}

		return cnt;
	}// insertReviewImages

}
