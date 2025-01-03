package kr.co.sist.admin.member;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberShipService {
	
	@Autowired(required = false)
	private MemberShipDAO msDAO;
	
	public List<MemberShipDomain> searchAllMember(String keyword){
		List<MemberShipDomain> list=null;
		
		try {
			list=msDAO.selectMember(keyword);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		
		return list;
	}//searchAllMember
	
	public MemberShipDomain searchOneMember(String user_id) {
		MemberShipDomain msDomain=new MemberShipDomain();
		
		try {
			msDomain=msDAO.selectOneMember(user_id);
		}catch (PersistenceException pe) {
			pe.printStackTrace();
		}//end catch
		
		return msDomain;
	}//searchOneMember
	
	public boolean modifyMember(MemberShipVO msVO) throws Exception {
	    boolean result = false;
	    
	    // 1. null 체크 및 기본 유효성 검증
	    if(msVO == null || msVO.getUser_id() == null) {
	        throw new Exception("필수 정보가 누락되었습니다.");
	    }
	    
	    try {
	        result = msDAO.updateMember(msVO) == 1;  // 1행이 수정되면 true
	        
	    } catch(PersistenceException pe) {
	        pe.printStackTrace();
	        throw pe;
	    }
	    
	    return result;
	}
}
