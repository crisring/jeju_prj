package kr.co.sist.admin.review;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;

import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.util.SearchVO;

@Service
public class ReviewManageService {

	@Autowired
	ReviewManageDAO rmDAO;

	/**
	 * 1.총 레코드 수 구하기
	 * 
	 * @param sVO
	 * @return
	 */
	public int totalCount(SearchVO sVO) {
		int cnt = 0;
		try {
			cnt = rmDAO.selectTotalCount(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return cnt;
	}// totalCount

	/**
	 * 2.한 화면에 보여줄 레코드의 수
	 * 
	 * @return
	 */
	public int pageScale() {
		int pageScale = 8;
		return pageScale;
	}// pageScacle

	/**
	 * 3.총 페이지 수
	 * 
	 * @param totalCount
	 * @param pageScale
	 * @return
	 */
	public int totalPage(int totalCount, int pageScale) {
		int totalPage = (int) Math.ceil((double) totalCount / pageScale);
		return totalPage;
	}

	/**
	 * 현재 페이지 번호
	 * 
	 * @param paramPage
	 * @return
	 */
	public int currentPage(String paramPage) {
		int currentPage = 1;
		if (paramPage != null) {
			try {
				currentPage = Integer.parseInt(paramPage);
			} catch (NumberFormatException nfe) {
			} // end catch
		} // end if
		return currentPage;
	}

	/**
	 * 4.검색의 시작번호를 구하기
	 * 
	 * @param paramPage
	 * @param pageScale
	 * @return
	 */
	public int startNum(int currentPage, int pageScale) {
		int startNum = currentPage * pageScale - pageScale + 1;// 시작번호
		return startNum;
	}// startNum

	/**
	 * 5. 끝번호
	 * 
	 * @param startNum
	 * @param pageScale
	 * @return
	 */
	public int endNum(int startNum, int pageScale) {
		int endNum = startNum + pageScale - 1; // 끝 번호
		return endNum;
	}// endNum

	/**
	 * 리뷰 리스트
	 * 
	 * @param admin_id 관리자ID
	 * @return
	 */
	public List<ReviewManageDomain> searchAllReview(SearchVO sVO) {

		List<ReviewManageDomain> list = null;

		try {
			list = rmDAO.selectAllReview(sVO);

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// searchAllReview

	/**
	 * 상세 리뷰 조회
	 * 
	 * @param admin_id 관리자ID
	 * @return
	 */
	public ReviewManageDomain searchOneReview(int review_id) {

		ReviewManageDomain rmd = null;
		List<String> review_img = null;

		try {
			rmd = rmDAO.selectOneReview(review_id);
			review_img = rmDAO.selectReviewImg(review_id);

			if (rmd != null && review_img != null) {
				rmd.setImg_name(review_img);
			}

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return rmd;
	}// searchOneReview

	/**
	 * 리뷰 삭제 AJAX
	 * 
	 * @return jsonObj 삭제 flag
	 */
	public String removeReview(int review_id) {

		JSONObject jsonObj = new JSONObject();

		boolean flag = rmDAO.deleteReview(review_id) == 1;

		jsonObj.put("resultFlag", flag);

		return jsonObj.toJSONString();
	}// removeReview

}
