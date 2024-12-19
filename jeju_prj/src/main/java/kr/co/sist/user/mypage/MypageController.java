package kr.co.sist.user.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {

	@GetMapping("/mypage/checkPassFrm")
	public String checkPassFrm() {

		return "user/mypage/enter_mypage";
	}

}
