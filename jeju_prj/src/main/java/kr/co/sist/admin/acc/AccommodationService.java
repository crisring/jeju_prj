package kr.co.sist.admin.acc;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccommodationService {

	@Autowired(required = false)
	private AccommodationDAO saDAO;

	/**
	 * 전체 숙소 조회(검색어가 있다면 검색된 숙소 검색)
	 * @param saVO
	 * @return
	 */
	public List<AccommodationDomain> searchAllAcc(SearchAccVO sVO) {
		List<AccommodationDomain> list = null;

		int pageSize = 10;
		int startRow = (sVO.getCurrentPage() - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;

		sVO.setStartRow(startRow);
		sVO.setEndRow(endRow);

		try {
			list = saDAO.selectAllAcc(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return list;
	}// searchAllAcc

	//숙소목록 페이지네이션
	public int totalPages(SearchAccVO sVO) {
		int totalCount = 1;
		try {
			int tempNo = saDAO.getAccommodationCount(sVO);
			totalCount = (int) Math.ceil((double) tempNo / 10);
		}catch( PersistenceException pe) {
			pe.printStackTrace();
			totalCount=1;
		}//end catch

		return totalCount;
	}// totalPages
	
	//숙소추가
	public boolean addAcc(AccommodationVO aVO) {
		boolean flag=false;
		int cnt=0;
		try {
			
			cnt = saDAO.insertAcc(aVO);
			flag = cnt == 1;
			
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		return flag;
	}//addAcc
	
	//숙소 상세조회
	public AccommodationDomain searchOneAcc(int acm_id) {
		List<AccommodationDomain> list =null; 
		try {
			list=saDAO.selectOneAcc(acm_id);
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}
			
	    if(list == null || list.isEmpty()) {
	        return null;
	    }
	    
	    // 첫 번째 row의 기본 정보를 가져옴
	    AccommodationDomain acc = list.get(0);
	    
	    // 편의시설을 위한 Set (중복 제거용)
	    Set<String> facilities = new HashSet<>();
	    // 서브이미지와 콘텐츠를 위한 Set
	    List<String> subImages = new ArrayList<>();
	    List<String> contents = new ArrayList<>();
	    
	    // 한 번의 순회로 처리
	    for(AccommodationDomain row : list) {
	        // 편의시설 추가
	        if(row.getFcl_names() != null) {
	            facilities.add(row.getFcl_name());
	        }//end if
	        // 서브이미지와 콘텐츠 추가(중복처리)
	        if(row.getSub_img_name() != null && !subImages.contains(row.getSub_img_name())) {
	            subImages.add(row.getSub_img_name());
	            contents.add(row.getContent());
	        }//end if
	    }//end for
	    
	    // 최종 결과물에 설정
	    acc.setFcl_names(new ArrayList<>(facilities));
	    acc.setSub_img_names(new ArrayList<>(subImages));
	    acc.setContents(new ArrayList<>(contents));
	    
	    return acc;
	}//searchOneAcc
	
	public boolean modifyAcc(AccommodationDomain acc) {
		boolean flag=false;
		int cnt=0;
		try {
			cnt = saDAO.updateAccommodation(acc);
			
			flag = cnt == 1;
			
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		
		return flag;
	}//modifyAcc
	
	public boolean removeAcc(int acm_id) {
		boolean flag=false;
		try {
			flag=saDAO.deleteAcc(acm_id)==1;
		}catch(PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		
		return flag;
	}//removeAcc

}
