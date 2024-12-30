package kr.co.sist.user.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.stereotype.Repository;

import jakarta.persistence.PersistenceException;
import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@Repository
public class LoginDAO {

	public MemberDomain selectLogin(LoginVO lVO) throws PersistenceException {
		MemberDomain mVO = null;
		MyBatisHandler mbh = MyBatisHandler.getInstnace();

		SqlSession handler = mbh.getHandler();
		try {
			mVO = handler.selectOne("kr.co.sist.user.login.userLogin",lVO);

		} finally {
			mbh.closeHandler(handler);
		} // end finally
		System.out.println(mVO);
		return mVO;
	}// selectLogin

	/**
	 * 사용자로부터 이름과 연락처를 입력받아서 아이디를 찾는 일.
	 * 
	 * @param mfVO
	 * @return
	 * @throws PersistenceException
	 */
	public String selectId(MemberFindVO mfVO) throws PersistenceException {
		String findId = "";
		MyBatisHandler mbh = MyBatisHandler.getInstnace();
		SqlSession handler = mbh.getHandler();
		try {

			findId = handler.selectOne("kr.co.sist.user.login.findId", mfVO);

		} finally {
			mbh.closeHandler(handler);
		} // end finally

		return findId;

	}// selectId

	public String selectPass(MemberFindVO mfVO) throws PersistenceException {
		String userId = null; // String으로 수정
		MyBatisHandler mbh = MyBatisHandler.getInstnace();
		SqlSession handler = mbh.getHandler();
		try {
			userId = handler.selectOne("kr.co.sist.user.login.findPass", mfVO);
		} finally {
			mbh.closeHandler(handler);
		}
		System.out.println("찾은 USER_ID: " + userId);
		return userId;
	}// selectPass

	public int updatePass(MemberVO mVO) throws PersistenceException {
		int rowCnt = 0;
		MyBatisHandler mbh = MyBatisHandler.getInstnace();
		SqlSession handler = mbh.getHandler();
		try {
			System.out.println("Updating password for user_id: " + mVO.getUser_id());
			rowCnt = handler.update("kr.co.sist.user.login.resetPass", mVO);
		} finally {
			mbh.closeHandler(handler);
		}
		System.out.println("Rows updated: " + rowCnt);
		return rowCnt;
	}// updatePass

}// loginDAO
