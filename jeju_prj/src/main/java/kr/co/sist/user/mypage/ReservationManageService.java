package kr.co.sist.user.mypage;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sist.user.util.SearchVO;

@Service
public class ReservationManageService {

	@Autowired
	private ReservationManageDAO rsrmDAO;

	/**
	 * 1.총 레코드 수 구하기
	 * 
	 * @param sVO
	 * @return
	 */
	public int totalCount(String user_id) {
		int cnt = 0;
		try {
			cnt = rsrmDAO.selectTotalCount(user_id);
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
		int pageScale = 2;
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
	 * 예약 내역에서 상태가 '결제완료'인 것만 조회
	 * 
	 * @param user_id 사용자 아이디(세션)
	 * @return
	 */
	public List<ReservationDomain> displayAllReservation(String user_id) {

		List<ReservationDomain> list = null;

		try {
			list = rsrmDAO.selectAllReservation(user_id);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;

	}// displayAllReservation

	/**
	 * 예약 내역에서 상태가 '이용완료'인 것만 조회
	 * 
	 * @param user_id 사용자 아이디(세션)
	 * @return
	 */
	public List<ReservationDomain> displayAllReservation2(SearchVO sVO) {

		List<ReservationDomain> list = null;

		try {
			list = rsrmDAO.selectAllReservation2(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// displayAllReservation2

	/**
	 * 예약 번호를 받아서 취소신청 update
	 * 
	 * @param rsr_id
	 * @return
	 */
	public String cancelReservation(int rsr_id) {

		JSONObject jsonObj = new JSONObject();

		boolean flag = rsrmDAO.updateReservation(rsr_id) == 1;

		jsonObj.put("resultFlag", flag);

		return jsonObj.toJSONString();
	}// cancelReservation

	/**
	 * ReviewVO를 받아서 리뷰 추가 후 이미지이름 DB 추가
	 * 
	 * @return
	 */
	public boolean addReview(ReviewVO rVO) {

		boolean flag = false;

		try {
			flag = rsrmDAO.insertReview(rVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return flag;
	}// addReview

}
