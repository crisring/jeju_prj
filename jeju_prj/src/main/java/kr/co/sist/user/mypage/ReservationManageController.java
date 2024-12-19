package kr.co.sist.user.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReservationManageController {

	/**
	 * 나의 예약 리스트
	 * 
	 * @return
	 */
	@GetMapping("/mypage/rerListFrm")
	public String rsrListFrm(Model model) {

		return "user/mypage/mypage_reservation";
	}

}
