package kr.co.sist.admin.room;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class RoomService {

	@Autowired(required = false)
	private RoomDAO rDAO;

	public List<AdminRoomDomain> searchAllRoom(int acm_id) {
		List<AdminRoomDomain> list = null;

		try {
			list = rDAO.selectAllRoom(acm_id);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return list;
	}// searchAllRoom

	public AdminRoomDomain searchOneRoom(int room_id) {
		AdminRoomDomain arDomain = null;

		try {
			arDomain = rDAO.selectOneRoom(room_id);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return arDomain;
	}// searchOneRoom

	public boolean modifyRoom(AdminRoomDomain arDomain) {
		   boolean flag = false;
		   
		   try {
		       // DAO 호출
		       flag = rDAO.updateRoom(arDomain) == 4;
		   } catch (PersistenceException pe) {
		       pe.printStackTrace();
		   } // end catch
		   
		   return flag;
		}// modifyRoom
	
	public boolean addRoom(RoomVO rVO) {
	    boolean flag = false;
	    
	    try {
	        RoomDAO rDAO = new RoomDAO();
	        flag = rDAO.insertRoom(rVO) == 1;
	    } catch (PersistenceException pe) {
	        pe.printStackTrace();
	    }
	    
	    return flag;
	}
	
	public boolean removeRoom(List<Integer> roomIds) {
		boolean flag=false;
        try {
        	flag=rDAO.deleteRoom(roomIds) > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }

}
