package kr.co.sist.user.reservation;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class ReservationDAO {

	public RoomDomain selectRoom(int room_id) throws PersistenceException {

		RoomDomain rd = null;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		SqlSession handler = mbh.getHandler();

		try {
			rd = handler.selectOne("kr.co.sist.reservationMapper.selectRoom", room_id);

		} finally {
			mbh.closeHandler(handler);
		}

		return rd;
	}// selectRoom

	public int insertReservation(ReservationVO rVO) throws PersistenceException {

		int rowCnt = 0;
		MyBatisHandler mbh = MyBatisHandler.getInstance();
		// commit 막아놓기 -> 나중에 풀기
		SqlSession handler = mbh.getHandler(true);

		try {
			rowCnt = handler.insert("kr.co.sist.reservationMapper.insertReservation", rVO);
		} finally {
			mbh.closeHandler(handler);
		}

		return rowCnt;

	}// insertReservation

}
