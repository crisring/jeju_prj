package kr.co.sist.user.searchACM;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jakarta.annotation.Resource;
import kr.co.sist.dao.MyBatisHandler;

@Repository
public class SearchACMDAO {

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
	 * SearchVO를 가지고 검색
	 * 
	 * @param sVO
	 * @return
	 */
	public List<SearchACMDomain> selectACM(SearchVO sVO) throws PersistenceException {

		List<SearchACMDomain> list = null;

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

		return sacmd;
	}// selectACMType

	public static void main(String[] args) {

		/*
		 * SearchACMDAO sacmDAO = new SearchACMDAO();
		 * 
		 * System.out.println(sacmDAO.selectRatingReview(1000));
		 */

	}// main

}
