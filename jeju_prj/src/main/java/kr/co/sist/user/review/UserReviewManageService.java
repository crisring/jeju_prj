package kr.co.sist.user.review;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sist.user.mypage.ReviewVO;
import kr.co.sist.user.util.SearchVO;

@Service
public class UserReviewManageService {

	@Autowired
	private UserReviewManageDAO urDAO;

	

	/**
	 * user_id로 리뷰 목록 조회
	 */
	public List<ReviewDomain> searchAllReview(SearchVO sVO) {
		// DAO 호출
		return urDAO.selectAllReview(sVO);
	}

	/**
	 * review_id로 단일 리뷰 조회
	 */
	public ReviewDomain displayReview(int review_id) {
		ReviewDomain rDomain = urDAO.selectOneReview(review_id);
		return rDomain;
	}

	/**
	 * 리뷰 수정
	 */
	public boolean modifyReview(ReviewVO rVO) {
		// 실제로 update가 1건 이상 되었다면 성공
		int rowCnt = urDAO.updateReview(rVO);
		return rowCnt > 0;
	}

	/**
	 * 리뷰 삭제
	 */
	public boolean removeReview(int review_id) {
		int rowCnt = urDAO.deleteReview(review_id);
		return rowCnt > 0;
	}

	/**
	 * (선택) 리뷰 이미지 목록 조회 - 예: 리뷰 상세 페이지에서 썸네일들 불러올 때 사용
	 */
	public List<String> displayImg(int review_id) {
		List<String> imgs = urDAO.selectReviewImg(review_id);
		return imgs;
	}//displayImg

	public int totalCount(SearchVO sVO) {
		int cnt = 0;
		try {
			cnt = urDAO.selectTotalCount(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return cnt;
	}// totalCount

	public int pageScale() {
		int pageScale = 8;
		return pageScale;
	}// pageScacle

	public int totalPage(int totalCount, int pageScale) {
		int totalPage = (int) Math.ceil((double) totalCount / pageScale);
		return totalPage;
	}//totalPage

	public int currentPage(String paramPage) {
		int currentPage = 1;
		if (paramPage != null) {
			try {
				currentPage = Integer.parseInt(paramPage);
			} catch (NumberFormatException nfe) {
			} // end catch
		} // end if
		return currentPage;
	}//currentPage

	public int startNum(int currentPage, int pageScale) {
		int startNum = currentPage * pageScale - pageScale + 1;// 시작번호
		return startNum;
	}// startNum

	public int endNum(int startNum, int pageScale) {
		int endNum = startNum + pageScale - 1; // 끝 번호
		return endNum;
	}// endNum

}// class
