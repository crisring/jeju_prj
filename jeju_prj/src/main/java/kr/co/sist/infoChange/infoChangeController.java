package kr.co.sist.infoChange;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@Controller
public class infoChangeController {
	@Autowired(required = false)
	private infoChangeService is;

	    @GetMapping("/mypage/mypage_main")
	    public String modifyForm(HttpSession session, Model model) {
	        // 세션에서 user_info 가져오기
	        MemberDomain userInfo = (MemberDomain) session.getAttribute("user_info");
	        if (userInfo == null) {
	            // 로그인되지 않았으면 로그인 페이지로
	            return "redirect:/login/loginFrm";
	        }

	        // DB에서 최신 정보 조회 및 생년월일 복호화
	        MemberDomain member = is.getMemberInfo(userInfo.getUser_id());

	        if (member == null) {
	            model.addAttribute("error", "회원 정보를 찾을 수 없습니다.");
	            return "redirect:/login/loginFrm";
	        }

	        // 모델에 회원 정보 추가
	        model.addAttribute("user_info", member);
	        // 실제 JSP 페이지로 포워딩
	        return "user/mypage/mypage_main"; // main.jsp의 실제 경로
	    }// showModifyForm

	    @PostMapping("/mypage/modifyinfoProcess")
	    public String modifyInfoProcess(HttpSession session, MemberVO mVO, Model model) {
	        // 세션에서 user_id 확인
	        MemberDomain userInfo = (MemberDomain) session.getAttribute("user_info");
	        if (userInfo == null) {
	            return "redirect:/login/loginFrm";
	        }
	        // MemberVO에 user_id를 세팅
	        mVO.setUser_id(userInfo.getUser_id());

	        // Service 호출하여 DB 수정
	        boolean success = is.modifyInfo(mVO);
	        if (success) {
	            // 수정 성공
	            // 세션 정보도 최신화하기 위해 다시 DB 조회
	            MemberDomain updatedInfo = is.getMemberInfo(mVO.getUser_id());
	            session.setAttribute("user_info", updatedInfo);

	            model.addAttribute("msg", "정보 수정이 완료되었습니다.");
	            // 수정 완료 후 마이페이지 메인으로 리다이렉트
	            return "redirect:/mypage/mypage_main";
	        } else {
	            // 수정 실패
	            model.addAttribute("error", "정보 수정에 실패했습니다. 다시 시도해주세요.");
	            return "redirect:/mypage/mypage_main";
	        }
	    }// modifyInfoProcess

	@GetMapping("/mypage/withdrawFrm")
	public String withdrawFrm(Model model) {

		return "user/login/leave_member";
	}//withdrawFrm
	
	    @PostMapping("/mypage/withdrawProcess")
	    public String withdrawProcess(WithDrawDomain wdDomain, Model model, SessionStatus status,HttpSession session) {
	        // wdDomain에는 user_id, reason_id가 바인딩됨
	        boolean result = is.withdrawMember(wdDomain);

	        if (result) {
	        	model.addAttribute("success","탈퇴에 성공하였습니다. \\n 그동안 이용해 주세셔 감사합니다.");
	            // 탈퇴 성공
	            // 세션 로그아웃/무효화 필요하면 여기서 처리
	        	// @SessionAttributes 초기화
	    		status.setComplete();

	    		// HttpSession 초기화
	    		session.invalidate();
	            return "user/login/success_leave";
	        } else {
	            // 탈퇴 실패
	            model.addAttribute("error", "에러발생으로 회원탈퇴가 실패하였습니다. 잠시후 다시 시도해주세요");
	            return "redirect:/mypage/withdrawFrm";
	        }
	    }

	@GetMapping("/mypage/reset_pass")
	public String resetPassFrm() {

		return "user/mypage/reset_pass";
	}// modifyInfoFrm

	@RequestMapping(value = "/mypage/displayMember", method = { RequestMethod.GET, RequestMethod.POST })
	public String displayMember(String id, Model model) {

		return null;
	}// displayMember

}// infoChangeController
