package kr.co.sist.user.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@SessionAttributes("user_info")
@Controller
public class LoginController {
	@Autowired
	private LoginService ls;

	@GetMapping("/login/loginFrm")
	public String loginFrm() {

		return "user/login/user_login";
	}// loginFrm

	@RequestMapping(value = "/login/loginProcess", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginFrmProcess(LoginVO lVO, Model model) {
		try {
			MemberDomain member = ls.searchLogin(lVO);

			// 🔑 @SessionAttributes("userInfo")에 의해 세션에 자동 저장
			model.addAttribute("user_info", member);

			return "redirect:/";
		} catch (RuntimeException e) {
			model.addAttribute("error", "아이디와 비밀번호를 정확히 입력해주세요.");
			return "user/login/normal_login";
		}
	}

	@GetMapping("/login/logout")
	public String logout(HttpSession session, SessionStatus status) {
		// @SessionAttributes 초기화
		status.setComplete();

		// HttpSession 초기화
		session.invalidate();

		return "redirect:/";
	}

	@GetMapping("/member/findId")
	public String findIdFrm() {
		return "user/find_account/find_id";
	}// findIdFrm

	@PostMapping("/member/findIdProcess")
	public String findIdProcess(MemberFindVO mfVO, Model model) {
		String userId = ls.findIdService(mfVO);

		if (userId != null && !userId.isEmpty()) {
			model.addAttribute("userId", userId);
			model.addAttribute("userName", mfVO.getUser_name());
			return "user/find_account/find_id_success"; // 성공 시 결과 페이지로 이동
		} else {
			model.addAttribute("error", "일치하는 아이디가 없습니다. \\n 이름과 연락처를 확인해주세요.");
			return "user/find_account/find_id"; // 실패 시 아이디 찾기 사이트로 이동해서 alert로 알릴거임
		} // end else
	}// findIdProcess

	@GetMapping("/member/findPass")
	public String findPassFrm() {

		return "user/find_account/find_pass";
	}// findPassFrm

	@PostMapping("/member/findPassProcess")
	public String findPassProcess(MemberFindVO mfVO, Model model) {
		boolean flag = ls.findPassService(mfVO);
		if (flag) {
			model.addAttribute("user_id", mfVO.getUser_id()); // user_id 전달
			return "user/find_account/reset_pass";
		} else {
			model.addAttribute("error", "해당하는 계정이 없습니다.\\n정보를 확인해주세요.");
			return "user/find_account/find_pass";
		}
	}

	@PostMapping("/member/resetPassFrm")
	public String resetPassFrm(Model model) {

		return "";
	}// resestPassFrm

	@PostMapping("/member/resetPassProcess")
	public String resetPassProcess(MemberVO mVO, Model model) {

		boolean flag = ls.resetPassword(mVO);
		if (flag) { // 재설정 성공한 경우
			model.addAttribute("success", true);
			model.addAttribute("user_id", mVO.getUser_id());
			return "user/find_account/find_pass_success";
		} else { // 비밀번호 재설정 실패한 경우
			model.addAttribute("error", "비밀번호 재설정에 실패했습니다. 다시 시도해주세요.");
			return "user/find_account/reset_pass";
		} // end else
	}// resetPassProcess

}// loginController
