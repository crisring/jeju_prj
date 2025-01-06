package kr.co.sist.user.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@Controller
@SessionAttributes("user_info")
public class MypageController {

	@Autowired(required = false)
	MypageService ms;

	@GetMapping("/mypage/checkPassFrm")
	public String checkPassFrm() {

		return "user/mypage/enter_mypage";
	}// checkPassFrm

	@PostMapping("/mypage/checkPassProcess")
	public String checkPassProcess(MemberVO mVO, Model model, HttpSession session) {
		// 1) 세션에서 user_info 가져오기
		MemberDomain userInfo = (MemberDomain) session.getAttribute("user_info");
		if (userInfo == null) {
			// 세션에 사용자 정보가 없으면(로그인 안 되어 있으면) 로그인 페이지로 이동
			model.addAttribute("error", "세션이 만료되었습니다. \\n 다시 로그인 해주세요.");
			return "redirect:/login/loginFrm";

		} // end if

		String userId = userInfo.getUser_id();
		mVO.setUser_id(userId);
		boolean chkFlag = ms.checkPass(mVO);

		// 4) 검증 결과에 따른 분기 처리
		if (chkFlag) {
			// 비밀번호가 일치하면 마이페이지로 이동
			return "user/mypage/mypage_reservation";
		} else {
			// 비밀번호가 불일치하면 에러 메시지 표시 후 다시 비밀번호 입력 페이지로 이동
			model.addAttribute("error", "비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
			return "user/mypage/enter_mypage";
		} // end else
	}// checkPassProcess
}// class
