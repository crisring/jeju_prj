package kr.co.sist.admin.reservation;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminReservationService {
	
	@Autowired(required = false)
	private AdminReservationDAO arDAO;
	
	public List<AdminReservationDomain> searchAllRes(SearchResVO srVO){
		List<AdminReservationDomain> list=null;
		
		try {
			list=arDAO.selectAllRes(srVO);
		}catch(PersistenceException pe){
			pe.printStackTrace();
		}//end catch
		
		return list;
	}//searchAllRes
	
	public AdminReservationDomain searchOneRes(int rsr_id) {
		AdminReservationDomain arDomain=null;
		
		try {
			arDomain=arDAO.selectOneRes(rsr_id);
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		
		return arDomain;
	}//searchOneRes
	
	public boolean removeRes(int rsr_id) {
		boolean flag=false;		
		try {
			flag=arDAO.deleteRes(rsr_id)==1;
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}
		
		return flag;
	}//removeRes
	
	public boolean modifyRes(List<AdminReservationVO> updateList) {
		boolean flag=false;
		
		try {
			
			flag=arDAO.updateRes(updateList)>0;
			
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		
		return flag;
	}
}
