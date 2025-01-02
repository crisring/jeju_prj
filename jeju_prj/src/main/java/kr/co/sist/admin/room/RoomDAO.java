package kr.co.sist.admin.room;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class RoomDAO {
	
	public List<AdminRoomDomain> selectAllRoom(int acm_id) throws PersistenceException{
		List<AdminRoomDomain> list=null;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			list=handler.selectList("kr.co.sist.admin.room.selectAllRoom",acm_id);
		}finally {
			mbh.closeHandler(handler);
		}//end finally
		
		return list;
	}//selectAllRoom
	
	public AdminRoomDomain selectOneRoom(int room_id)throws PersistenceException{
		AdminRoomDomain arDomain=null;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			// 객실 기본 정보 조회
	        arDomain = handler.selectOne("kr.co.sist.admin.room.selectOneRoom", room_id);
	        
	        // 이미지 목록 조회
	        List<String> imgList = handler.selectList("kr.co.sist.admin.room.selectRoomImages", room_id);
	        
	        // List를 배열로 변환하여 설정
	        if(imgList != null && !imgList.isEmpty()) {
	            arDomain.setImg_name(imgList.toArray(new String[0]));
	        }//end if
		}finally {
			mbh.closeHandler(handler);
		}//end finally
		
		return arDomain;
	}//selectOneRoom
	
	public int updateRoom(AdminRoomDomain arDomain) throws PersistenceException {
		int cnt=0;
		
	    MyBatisHandler mbh = MyBatisHandler.getInstance();
	    SqlSession handler = mbh.getHandler();
	    
	    try {
	        // 1. 기존 객실 정보 업데이트
	    	cnt=handler.update("kr.co.sist.admin.room.updateRoom", arDomain);
	        
	        // 2. 기존 객실 상세정보 업데이트
	    	cnt+=handler.update("kr.co.sist.admin.room.updateRoomInfo", arDomain);
	        
	        // 3. 기존 이미지 정보 삭제
	    	cnt+=handler.delete("kr.co.sist.admin.room.deleteRoomImages", arDomain.getRoom_id());
	        
	        // 4. 새로운 이미지 정보 등록
	        if(arDomain.getImg_name() != null && arDomain.getImg_name().length > 0) {
	            for(String imgName : arDomain.getImg_name()) {
	                Map<String, Object> params = new HashMap<>();
	                params.put("room_id", arDomain.getRoom_id());
	                params.put("img_name", imgName);
	                handler.insert("kr.co.sist.admin.room.insertRoomImage", params);
	            }//end for
	            cnt++;
	        }//end if
	        
	        handler.commit();
	    } catch(Exception e) {
	        handler.rollback();
	        throw e;
	    } finally {
	        mbh.closeHandler(handler);
	    }//end finally
	    
	    return cnt;
	}//updateRoom
	
	public int insertRoom(RoomVO rVO) throws PersistenceException {
	    int cnt = 0;
	    MyBatisHandler mbh = MyBatisHandler.getInstance();
	    SqlSession handler = mbh.getHandler();
	    
	    try {
	        // 1. 객실 기본 정보 추가
	        cnt = handler.insert("kr.co.sist.admin.room.insertRoom", rVO);
	        
	        // 2. 기본 정보가 정상적으로 추가된 경우에만 진행
	        if (cnt == 1) {
	            // 3. 객실 상세 정보(room_info) 추가
	            handler.insert("kr.co.sist.admin.room.insertRoomInfo", rVO);
	            
	            // 4. 객실 이미지 정보 추가 (이미지가 있는 경우에만)
	            if (rVO.getImg_name() != null && rVO.getImg_name().length > 0) {
	                for (String imgName : rVO.getImg_name()) {
	                    Map<String, Object> param = new HashMap<>();
	                    param.put("room_id", rVO.getRoom_id());
	                    param.put("img_name", imgName);
	                    handler.insert("kr.co.sist.admin.room.insertRoomImage", param);
	                }
	            }
	            
	            handler.commit();  // 모든 작업이 성공적으로 완료된 경우에만 commit
	        }
	    } catch (Exception e) {
	        handler.rollback();  // 오류 발생시 롤백
	        e.printStackTrace();
	    } finally {
	        mbh.closeHandler(handler);
	    }
	    
	    return cnt;
	}
	
	public int deleteRoom(List<Integer> roomIds) throws PersistenceException{
		int cnt=0;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			for(Integer room_id : roomIds) {
                cnt += handler.update("kr.co.sist.admin.room.updateDltFlag", room_id);
            }
			handler.commit();
		}catch (Exception e) {
			e.printStackTrace();
			handler.rollback();
		}finally {
			mbh.closeHandler(handler);
		}
		
		return cnt;
	}
	
}
