package kr.co.sist.user.reservation;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.member.MemberDomain;
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
	public static MemberDomain getUserId(HttpSession session) {
		MemberDomain md = (MemberDomain) session.getAttribute("user_info");
		return md;
	}

	@RequestMapping(value = "/reservation", method = { GET, POST })
	public String reservationView(@RequestParam(required = false) int room_id,
			@RequestParam(required = false) String startDate, @RequestParam(required = false) String finishDate,
			@RequestParam(required = false) int numberPeople, HttpSession session, Model model) throws ParseException {

		MemberDomain md = getUserId(session);

		model.addAttribute("user_info", md);

		RoomDomain rd = new RoomDomain();
		rd = rs.displayReservation(room_id);
		rd.setRoom_id(room_id);

		int day = getDateDifference(startDate, finishDate);

		// 날짜당 총합 계산
		int priceToPay = (rd.getDiscount_price() > 0 ? rd.getDiscount_price() : rd.getPrice()) * day;

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

	/**
	 * 날짜 차이를 int로 반환하는 method
	 * 
	 * @param startDateStr  시작날짜
	 * @param finishDateStr 종료날짜
	 * @return day 일 수
	 * @throws ParseException
	 */
	public static int getDateDifference(String startDateStr, String finishDateStr) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// 문자열을 Date 객체로 변환
		Date startDate = sdf.parse(startDateStr);
		Date finishDate = sdf.parse(finishDateStr);

		// 날짜 차이를 계산
		long differenceInMillis = finishDate.getTime() - startDate.getTime();

		// 밀리초를 일수로 변환하여 반환
		return (int) (differenceInMillis / (24 * 60 * 60 * 1000));
	}
}
