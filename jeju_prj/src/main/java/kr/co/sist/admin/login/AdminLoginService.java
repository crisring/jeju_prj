package kr.co.sist.admin.login;

import org.apache.ibatis.exceptions.PersistenceException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminLoginService {

	@Autowired
	AdminLoginDAO alDAO;

	// 로그인
	public String findAdminId(AdminLoginVO alVO) {
		JSONObject jsonObj = new JSONObject();
		String admin_id = null; // 초기화
		boolean loginFlag = false;

		try {
			admin_id = alDAO.selectAdminId(alVO);

			if (admin_id == null || admin_id.isEmpty()) {
				loginFlag = false;
			} else {
				loginFlag = true;
			}

			// JSON 객체에 결과 저장
			jsonObj.put("admin_id", admin_id);
			jsonObj.put("loginFlag", loginFlag);

		} catch (PersistenceException pe) {
			pe.printStackTrace();
			jsonObj.put("error", "데이터베이스 처리 중 오류가 발생했습니다.");
		}

		return jsonObj.toJSONString();
	}

}
