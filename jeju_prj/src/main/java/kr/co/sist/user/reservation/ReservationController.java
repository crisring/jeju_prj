package kr.co.sist.user.reservation;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.member.MemberVO;

@Controller
@SessionAttributes("user_info")
public class ReservationController {

	@Autowired
	ReservationService rs;

	/**
	 * 세션에서 memberVO 가져오기
	 * 
	 * @param session
	 * @return
	 */
	public static MemberVO getUserId(HttpSession session) {
		MemberVO mVO = (MemberVO) session.getAttribute("user_info");
		return mVO;
	}

	@RequestMapping(value = "/reservation", method = { GET, POST })
	public String reservationView(@RequestParam(required = false) int room_id,
			@RequestParam(required = false) String startDate, @RequestParam(required = false) String finishDate,
			@RequestParam(required = false) int numberPeople, HttpSession session, Model model) {

		MemberVO mVO = getUserId(session);

		model.addAttribute("user_info", mVO);

		RoomDomain rd = new RoomDomain();
		rd = rs.displayReservation(room_id);
		rd.setRoom_id(room_id);

		int priceToPay = rd.getDiscount_price() > 0 ? rd.getDiscount_price() : rd.getPrice();

		model.addAttribute("rd", rd);
		model.addAttribute("priceToPay", priceToPay);
		model.addAttribute("startDate", startDate);
		model.addAttribute("finishDate", finishDate);
		model.addAttribute("numberPeople", numberPeople);

		return "/user/reservation/reservation_page";
	}// reservationView

	@PostMapping("/reservation/rsrProcess")
	public String reservationProc(ReservationVO rVO, Model model) {
		boolean flag = rs.addReservation(rVO);
		String resultMsg = flag ? "결제가 완료되었습니다!" : "결제가 실패하였습니다! 다시 시도해주세요";

		model.addAttribute("resultMsg", resultMsg);

		return "/user/reservation/reservationProcess";
	}// reservationProc
}
