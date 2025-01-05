package kr.co.sist.admin.reservation;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class AdminReservationDAO {

	public List<AdminReservationDomain> selectAllRes(SearchResVO srVO) throws PersistenceException{
		List<AdminReservationDomain> list=null;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			list=handler.selectList("kr.co.sist.admin.reservation.selectReservation",srVO);
		}finally {
			mbh.closeHandler(handler);
		}//end finally
		
		return list;
	}//selectAllRes
	
	public AdminReservationDomain selectOneRes(int rsr_id) throws PersistenceException{
		AdminReservationDomain arDomain=null;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			
			arDomain=handler.selectOne("kr.co.sist.admin.reservation.selectOneReservation",rsr_id);
			
		}finally {
			mbh.closeHandler(handler);
		}//end finally
		
		return arDomain;
	}//selectOneRes
	
	public int deleteRes(int rsr_id) throws PersistenceException{
		int cnt=0;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			
			cnt=handler.delete("kr.co.sist.admin.reservation.deleteReservation", rsr_id);
			
			handler.commit();
		}catch(Exception e) {
			e.printStackTrace();
			handler.rollback();
		}finally {
			mbh.closeHandler(handler);
		}
		
		return cnt;
	}//deleteRes
	
	public int updateRes(List<AdminReservationVO> list) throws PersistenceException{
		int cnt=0;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			
			cnt=handler.update("kr.co.sist.admin.reservation.updateReservationStatus", list);
			
			handler.commit();
		}catch(Exception e) {
			e.printStackTrace();
			handler.rollback();
		}finally {
			mbh.closeHandler(handler);
		}
		
		return cnt;
	}//updateRes
	
	
	
}
