package kr.co.sist.admin.acc;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class AccommodationDAO {

	public List<AccommodationDomain> selectAllAcc(SearchAccVO sVO) {
		List<AccommodationDomain> list = new ArrayList<AccommodationDomain>();

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		list = handler.selectList("kr.co.sist.admin.accommodation.selectACM", sVO);
		mbh.closeHandler(handler);

		return list;
	}// end selectACM

	public int getAccommodationCount(SearchAccVO sVO) {
		int cnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		cnt = handler.selectOne("kr.co.sist.admin.accommodation.getAccommodationCount", sVO);
		mbh.closeHandler(handler);

		return cnt;
	}// getAccommodationCount

}
