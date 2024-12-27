package kr.co.sist.user.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mypage")
public class RestAPIController {

	@Autowired
	private ReservationManageService rsrms;

	/**
	 * 취소신청 AJAX
	 * 
	 * @param rsr_id
	 * @param model
	 * @return
	 */
	@PutMapping("/cancelReservation/{rsr_id}")
	public String cancelReservationProc(@PathVariable("rsr_id") String rsrId) {

		int rsr_id = Integer.parseInt(rsrId);

		String jsonObj = rsrms.cancelReservation(rsr_id);

		return jsonObj;
	}// cancelReservationProc

}
