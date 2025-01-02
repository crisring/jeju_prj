package kr.co.sist.admin.login;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class AdminLoginDAO {

	// 관리자 로그인 - 아이디만 필요
	public String selectAdminId(AdminLoginVO alVO) throws PersistenceException {

		String admin_id = "";

		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			admin_id = handler.selectOne("kr.co.sist.admin.login.selectAdminId", alVO);

		} finally {
			mbh.closeHandler(handler);
		}

		return admin_id;
	}// selectAdminId

}
