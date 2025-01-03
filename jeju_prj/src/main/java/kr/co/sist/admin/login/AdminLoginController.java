package kr.co.sist.admin.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import jakarta.servlet.http.HttpSession;

@Controller
@SessionAttributes("admin_id")
public class AdminLoginController {

	@Autowired
	AdminLoginService als;

	@GetMapping("/admin/loginFrm")
	public String loginFrm() {

		return "admin/login/adminLoginFrm";
	}// loginFrm

	@PostMapping("/admin/loginProcess")
	@ResponseBody
	public String loginFrmProc(@RequestBody AdminLoginVO alVO, HttpSession session) {
		// 로그인 처리
		String jsonObj = als.findAdminId(alVO);

		// 로그인 성공 시 세션에 admin_id 저장
		if (jsonObj != null && !jsonObj.isEmpty()) { // 성공적으로 admin_id가 반환되었을 때
			session.setAttribute("admin_id", alVO.getAdmin_id());
		}

		return jsonObj;
	}

	@GetMapping("/admin/logout")
	public String logout(HttpSession session, SessionStatus status) {
		// @SessionAttributes 초기화
		status.setComplete();

		// HttpSession 초기화
		session.invalidate();

		return "redirect:/admin/loginFrm";
	}

}
