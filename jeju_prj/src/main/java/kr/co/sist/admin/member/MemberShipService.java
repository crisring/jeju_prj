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
}
