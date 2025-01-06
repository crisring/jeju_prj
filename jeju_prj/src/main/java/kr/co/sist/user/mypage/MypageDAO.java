package kr.co.sist.user.mypage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.member.MemberVO;

@Repository
public class MypageDAO {

	public String selectPass(MemberVO mVO) {
		String pass = "";
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			pass = handler.selectOne("kr.co.sist.mypageMapper.chkPass", mVO);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			mbh.closeHandler(handler);
		}

		return pass;
	}
}// class
