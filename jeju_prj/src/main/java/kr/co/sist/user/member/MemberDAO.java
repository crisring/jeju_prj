package kr.co.sist.user.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jakarta.persistence.PersistenceException;
import kr.co.sist.dao.MyBatisHandler;

@Repository
public class MemberDAO {
	/**
	 * id에 해당하는 회원 1명을 조회하는 일
	 * 
	 * @param id
	 * @return
	 */
	public String selectMember(String id) throws PersistenceException {
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();
		String result = "";
		try {
			result = handler.selectOne("kr.co.sist.user.member.selectId", id);

		} finally {
			mbh.closeHandler(handler);
		}

		return result;
	}// selectMember

	/**
	 * 회원가입시 회원정보를 추가하는 일
	 * 
	 * @param mVO
	 * @return
	 */
	public int insertMember(MemberVO mVO) throws PersistenceException {
		int insertCnt = 0;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();
		try {
			insertCnt = handler.insert("kr.co.sist.user.member.insertMember", mVO);
			if (insertCnt == 1) {
				handler.commit();
			} // end if
		} finally {
			mbh.closeHandler(handler);
		} // end finally

		return insertCnt;
	}// insertMember

}// class
