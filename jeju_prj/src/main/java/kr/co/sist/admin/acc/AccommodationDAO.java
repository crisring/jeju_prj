package kr.co.sist.admin.acc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class AccommodationDAO {

	//숙소목록조회
	public List<AccommodationDomain> selectAllAcc(SearchAccVO sVO) throws PersistenceException {
		List<AccommodationDomain> list = new ArrayList<AccommodationDomain>();

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		list = handler.selectList("kr.co.sist.admin.accommodation.selectACM", sVO);
		mbh.closeHandler(handler);

		return list;
	}//selectAllAcc

	//숙소목록 페이지네이션
	public int getAccommodationCount(SearchAccVO sVO) throws PersistenceException {
		int cnt = 0;

		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		try {
			cnt = handler.selectOne("kr.co.sist.admin.accommodation.getAccommodationCount", sVO);
		} finally {
			mbh.closeHandler(handler);
		}//end finally

		return cnt;
	}//getAccommodationCount
	
	//숙소추가
	public int insertAcc(AccommodationVO aVO) throws PersistenceException {
	    int cnt = 0;

	    MyBatisHandler mbh = MyBatisHandler.getInstance();
	    SqlSession handler = mbh.getHandler();

	    try {
	        // 1. 숙소 타입 ID 조회
	        int typeId = handler.selectOne("kr.co.sist.admin.accommodation.selectAccTypeId", aVO.getAcm_type());
	        aVO.setAcm_type_id(typeId);

	        // 2. 숙소 기본 정보 추가 (useGeneratedKeys="true"로 설정되어 있어 aVO에 acm_id가 자동 설정됨)
	        cnt = handler.insert("kr.co.sist.admin.accommodation.insertAccommodation", aVO);

	        // 데이터가 제대로 들어갔는지 확인
	        if (cnt == 1) {  // 숙소 기본정보가 정상적으로 추가된 경우에만 진행
	        	// 3. 편의시설 정보 추가 (체크된 시설이 있는 경우에만)
	        	if (aVO.getFcl_name() != null && aVO.getFcl_name().length > 0) {
	        	    // 편의시설 정보 추가
	        	    for (String fcl : aVO.getFcl_name()) {
	        	        // fcl_name을 기준으로 fcl_id 조회
	        	        Integer fclId = handler.selectOne("kr.co.sist.admin.accommodation.selectFclIdByName", fcl);

	        	        if (fclId != null) {
	        	            // provided_facilities 테이블에 acm_id와 fcl_id 추가
	        	            Map<String, Object> params = new HashMap<>();
	        	            params.put("acm_id", aVO.getAcm_id());  // 방금 삽입된 acm_id
	        	            params.put("fcl_id", fclId);  // 조회한 fcl_id

	        	            handler.insert("kr.co.sist.admin.accommodation.insertProvidedFacility", params);
	        	        }//end if
	        	    }//end for
	        	}//end if

	        	// 4. 서브이미지 정보 추가
	        	if (aVO.getSub_img_name() != null && aVO.getSub_img_name().length > 0) {
	        	    for(int i=0; i < aVO.getSub_img_name().length; i++) {
	        	        Map<String, Object> param = new HashMap<>();
	        	        param.put("acm_id", aVO.getAcm_id());
	        	        param.put("sub_img_name", aVO.getSub_img_name()[i]);
	        	        param.put("content", aVO.getContent()[i]);
	        	        handler.insert("kr.co.sist.admin.accommodation.insertSubImages", param);
	        	    }
	        	}

	            handler.commit();  // 모든 작업이 성공적으로 완료된 경우에만 commit
	        }
	    } catch (Exception e) {
	        handler.rollback();  // 오류 발생시 롤백
	        e.printStackTrace();
	    } finally {
	        mbh.closeHandler(handler);
	    }//emd finally

	    return cnt;
	}//insertAcc
	
	//상세조회
	public List<AccommodationDomain> selectOneAcc(int acm_id) throws PersistenceException {
		List<AccommodationDomain> list=null;
		
		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		try {
			list = handler.selectList("kr.co.sist.admin.accommodation.selectOneAcc", acm_id);
		} finally {
			mbh.closeHandler(handler);
		}//end finally
		
		return list;
	}//selectOneAcc
	
	public int updateAccommodation(AccommodationDomain acc) throws PersistenceException {
        int cnt=0;
		MyBatisHandler mbh = MyBatisHandler.getInstance();

		SqlSession handler = mbh.getHandler();
		
		try {
	        // 2. 기본 정보 업데이트
	        cnt=handler.update("kr.co.sist.admin.accommodation.updateAccommodation", acc);
	        if(cnt == 0) {  // 기본 정보 업데이트 실패시 롤백
	            handler.rollback();
	            return cnt;
	        }
	        
	        // 3. 기존 편의시설 삭제 후 새로운 편의시설 추가
	        handler.delete("kr.co.sist.admin.accommodation.deleteProvidedFacilities", acc.getAcm_id());
	        if(acc.getFcl_names() != null && !acc.getFcl_names().isEmpty()) {
	            for(String fclName : acc.getFcl_names()) {
	                // 편의시설 ID 조회
	                int fclId = handler.selectOne("kr.co.sist.admin.accommodation.selectFclIdByName", fclName);
	                Map<String, Object> params = new HashMap<>();
	                params.put("acm_id", acc.getAcm_id());
	                params.put("fcl_id", fclId);
	                handler.insert("kr.co.sist.admin.accommodation.insertProvidedFacility", params);
	            }//end for
	        }//end if
	        
	        // 4. 기존 서브이미지 삭제 후 새로운 서브이미지 추가
	        handler.delete("kr.co.sist.admin.accommodation.deleteSubImages", acc.getAcm_id());
	        if(acc.getSub_img_names() != null && !acc.getSub_img_names().isEmpty()) {
	            for(int i = 0; i < acc.getSub_img_names().size(); i++) {
	                Map<String, Object> params = new HashMap<>();
	                params.put("acm_id", acc.getAcm_id());
	                params.put("sub_img_name", acc.getSub_img_names().get(i));
	                params.put("content", acc.getContents().get(i));
	                handler.insert("kr.co.sist.admin.accommodation.insertSubImages", params);
	            }//end for
	        }//end if
	        //cnt=3
	        handler.commit();
	        
		}catch(Exception e) {
			handler.rollback();
			e.printStackTrace();
		}finally {
			mbh.closeHandler(handler);
		}//end finally
        
        return cnt;
    }//updateAccommodation
	
	public int deleteAcc(int acm_id) throws PersistenceException {
		int cnt=0;
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		try {
			cnt=handler.update("kr.co.sist.admin.accommodation.deleteAccommodation",acm_id);
			handler.commit();
		}finally {
			mbh.closeHandler(handler);
		}
		System.out.println("acm_id =============="+acm_id);
		
		return cnt;
	}

}
