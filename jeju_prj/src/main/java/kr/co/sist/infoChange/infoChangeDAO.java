package kr.co.sist.infoChange;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.stereotype.Repository;

import jakarta.persistence.PersistenceException;
import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@Repository
public class infoChangeDAO {

	/**
	 * 1) 특정 user_id의 회원정보 조회
	 */
	public MemberDomain selectOneMember(String userId) {
		MemberDomain member = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler(); // autoCommit = false (수동 커밋)

		try {
			member = handler.selectOne("kr.co.sist.infoChange.selectOneMember", userId);
		} finally {
			mbh.closeHandler(handler);
		}
		return member;
	}

	/**
	 * 2) 회원정보 수정 (UPDATE)
	 */
	public int updateInfo(MemberVO mVO) {
		int rowCnt = 0;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			rowCnt = handler.update("kr.co.sist.infoChange.updateInfo", mVO);
			handler.commit(); // 수정 후 커밋
		} finally {
			mbh.closeHandler(handler);
		}
		return rowCnt;
	}// updateInfo

	public int deleteMember(WithDrawDomain wdDomain) {
	    int rowCnt = 0;
	    MyBatisHandler mbh = MyBatisHandler.getInstance();
	    SqlSession handler = mbh.getHandler();

	    try {
	        // 1) 탈퇴 사유 INSERT
	        rowCnt = handler.insert("kr.co.sist.infoChange.withdrawChange", wdDomain);

	        // 2) 회원 DELETE
	        rowCnt += handler.delete("kr.co.sist.infoChange.deleteMember", wdDomain.getUser_id());

	        handler.commit();
	        System.out.println("삭제 후 rowCnt = " + rowCnt);
	    } finally {
	        mbh.closeHandler(handler);
	    }
	    return rowCnt;
	}


}// class
