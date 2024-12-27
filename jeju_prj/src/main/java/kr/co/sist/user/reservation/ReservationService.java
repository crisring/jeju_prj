package kr.co.sist.user.reservation;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {

	@Autowired
	ReservationDAO rDAO;

	/**
	 * 예약하는 객실의 정보를 보여줌
	 * 
	 * @param room_id
	 * @return
	 */
	public RoomDomain displayReservation(int room_id) {

		RoomDomain rd = null;

		try {
			rd = rDAO.selectRoom(room_id);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return rd;
	}// displayReservation

	/**
	 * 예약 추가
	 * 
	 * @param rVO 예약하는 정보
	 * @return flag 성공 실패 여부
	 */
	public boolean addReservation(ReservationVO rVO) {

		boolean flag = false;

		try {
			flag = rDAO.insertReservation(rVO) == 1;
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
		return flag;
	}
}
