package kr.co.sist.admin.review;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.util.SearchVO;

@Repository
public class ReviewManageDAO {

	/**
	 * 총 게시물의 수 검색
	 * 
	 * @param sVO
	 * @return 게시물의 수
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO) throws PersistenceException {
		int totalCount = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			totalCount = handler.selectOne("kr.co.sist.reviewManageMapper.totalCnt", sVO);
		} finally {
			mbh.closeHandler(handler);
		} // end finally

		return totalCount;
	}// selectTotalCount

	/**
	 * 리뷰 리스트
	 * 
	 * @return
	 * @throws PersistenceException
	 */
	public List<ReviewManageDomain> selectAllReview(SearchVO sVO) throws PersistenceException {

		List<ReviewManageDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.reviewManageMapper.selectAllReview", sVO);
		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// selectAllReview

	/**
	 * 상세 리뷰 조회
	 * 
	 * @return
	 * @throws PersistenceException
	 */
	public ReviewManageDomain selectOneReview(int review_id) throws PersistenceException {

		ReviewManageDomain rmd = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			rmd = handler.selectOne("kr.co.sist.reviewManageMapper.selectOneReview", review_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return rmd;
	}// selectOneReview

	/**
	 * 리뷰 이미지 조회
	 * 
	 * @return img_names 이미지 이름
	 * @throws PersistenceException
	 */
	public List<String> selectReviewImg(int review_id) throws PersistenceException {

		List<String> img_names = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			img_names = handler.selectList("kr.co.sist.reviewManageMapper.selectReviewImg", review_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return img_names;
	}// selectReviewImg

	/**
	 * 리뷰 삭제
	 * 
	 * @param review_id 리뷰 ID
	 * @return cnt 삭제 성공 여부
	 */
	public int deleteReview(int review_id) {

		int rowCnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(true);

		try {
			rowCnt = handler.delete("kr.co.sist.reviewManageMapper.deleteReview", review_id);
		} finally {
			mbh.closeHandler(handler);
		}

		return rowCnt;
	}// deleteReview

}
