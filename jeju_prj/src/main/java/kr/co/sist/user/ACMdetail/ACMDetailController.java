package kr.co.sist.user.ACMdetail;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ACMDetailController {

	@GetMapping("/acm/acmDetail")
	public String acmView(int acm_id, Model model) {

		return "";
	}

	/*
	 * @ResponseBody("/acm/roomimg") public String roomingView(int room_id, Model
	 * model) { return ""; }
	 * 
	 * @RequestBody("/acm/roomDetail") public String roomDetail(int room_id, Model
	 * model) { return ""; }
	 */
}