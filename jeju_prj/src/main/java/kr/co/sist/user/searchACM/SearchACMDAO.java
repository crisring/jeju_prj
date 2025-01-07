package kr.co.sist.user.searchACM;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.util.SearchVO;

@Repository
public class SearchACMDAO {
	/**
	 * SearchVO를 가지고 검색
	 * 
	 * @param sVO
	 * @return
	 */
	public List<SearchACMDomain> selectACM(SearchVO sVO) throws PersistenceException {

		List<SearchACMDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();
		try {

			list = handler.selectList("kr.co.sist.searchMapper.selectACM", sVO);

		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}// selectACM

	/**
	 * 숙소 타입 검색
	 * 
	 * @param acm_type_id
	 * @return
	 */
	public SearchACMDomain selectACMType(int acm_type_id) throws PersistenceException {

		SearchACMDomain sacmd = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {

			sacmd = handler.selectOne("kr.co.sist.searchMapper.selectACMType", acm_type_id);

		} finally {
			mbh.closeHandler(handler);
		}
		return sacmd;
	}// selectACMType

	public List<ACMTypeDomain> selectAllACMType() throws PersistenceException {
		List<ACMTypeDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {

			list = handler.selectOne("kr.co.sist.searchMapper.selectAllACMType");

		} finally {
			mbh.closeHandler(handler);
		}
		return list;
	}

	/**
	 * 각 숙소의 평균평점+리뷰수 계산
	 * 
	 * @param acm_id
	 * @return
	 */
	public SearchACMDomain selectRatingReview(int acm_id) throws PersistenceException {

		SearchACMDomain sacmd = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {

			sacmd = handler.selectOne("kr.co.sist.searchMapper.selectRatingReview", acm_id);

		} finally {
			mbh.closeHandler(handler);
		}

		return sacmd;
	}// selectRatingReview

	/**
	 * 숙소 유형을 가지고 검색 <br>
	 * 1.호텔, 2. 펜션 풀빌라, 3. 게하 한옥, 4. 캠핑 글램핑, 5. 홈 빌라 <br>
	 * 
	 * @param acm_type_id
	 * @return
	 */
	public List<SearchACMDomain> selectByACMType(int acm_type_id) throws PersistenceException {

		List<SearchACMDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.searchMapper.selectByACMType", acm_type_id);

		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}

	public List<FacilityDomain> selectAllFacility() throws PersistenceException {
		List<FacilityDomain> list = null;

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			list = handler.selectList("kr.co.sist.searchMapper.selectAllFacility");

		} finally {
			mbh.closeHandler(handler);
		}

		return list;
	}

	/*
	 * public static void main(String[] args) {
	 * 
	 * // DAO 객체 생성 SearchACMDAO sacmDAO = new SearchACMDAO();
	 * 
	 * // 검색 조건 객체 생성 SearchVO sVO = new SearchVO(); sVO.setStartDate("2024-11-28");
	 * sVO.setFinishDate("2024-11-29"); sVO.setKeyWord("제주"); // 키워드 설정
	 * sVO.setNumberPeople(3); // 인원수 설정
	 * 
	 * // selectACM 메서드 호출 시 파라미터로 SearchVO 객체 전달 List<SearchACMDomain> list =
	 * sacmDAO.selectACM(sVO);
	 * 
	 * // 결과 출력 System.out.println(list); }
	 */

}
