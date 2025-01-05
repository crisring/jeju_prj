package kr.co.sist.user.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MemberController {

	@Autowired(required = false)
	private MemberService ms;

	@GetMapping("/member/loginType")
	public String loginType() {
		return "";
	}// loginType

	// 약관으로 이동함.
	@GetMapping("/member/agree")
	public String memberAgree() {
		return "user/login/register";
	}// memberAgree

	@GetMapping("/member/joinFrm")
	public String joinFrm() {
		return "user/login/register_frm";
	}// joinFrm

	@GetMapping("/member/kakaoJoinFrm")
	public String kakaoJoinFrm() {
		return null;
	}// joinFrm

	@GetMapping("/member/idDup")
	public String idDupFrm(
	    @RequestParam(value = "id", required = false) String dupId,
	    Model model) 
	{
	    // 아이디가 비어있는지 먼저 체크
	    if(dupId == null || dupId.trim().isEmpty()) {
	        // 아직 검사 전이므로 idDupFlag를 넣지 않거나 null로 세팅
	        model.addAttribute("idDupFlag", null);
	        model.addAttribute("dupId", null);
	        
	        System.out.println("처음 로딩: 아이디 없음(검사 전)");
	        
	    } else {
	        // 아이디가 있으면 중복 검사
	        boolean idDupFlag = ms.idDup(dupId);
	        System.out.println("idDupFlag ====" + idDupFlag);
	        
	        // 결과를 모델에 담음
	        model.addAttribute("idDupFlag", idDupFlag);
	        model.addAttribute("dupId", dupId);

	        System.out.println(idDupFlag + "/" + dupId + " 중복검사 통과(서비스 호출 완료)");
	    }

	    return "user/login/id_dup";
	}//idDupFrm


	@PostMapping("/member/joinProcess")
	public String addMember(MemberVO mVO, HttpServletRequest request, Model model) {
	    // (1) IP 주소 설정
	    String userIp = request.getRemoteAddr();
	    mVO.setUser_ip(userIp);

	    // (2) 생년월일 조합
	    String birth = request.getParameter("birthYear") 
	        + request.getParameter("birthMonth") 
	        + request.getParameter("birthDay");
	    mVO.setBirth(birth);

	    // (3) 회원가입 서비스 호출
	    boolean flag = ms.addMember(mVO);

	    // (4) 결과 전달
	    model.addAttribute("insertFlag", flag);

	    return flag ? "user/login/success_join" : "user/login/register_frm";
	}


}// class