package kr.co.sist.admin.member;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;

@Repository
public class MemberShipDAO {
	
	public List<MemberShipDomain> selectMember(String keyword) throws PersistenceException {
	    List<MemberShipDomain> list = null;
	    
	    MyBatisHandler mbh = MyBatisHandler.getInstance();
	    SqlSession handler = mbh.getHandler();
	    
	    try {
	        list = handler.selectList("kr.co.sist.admin.membership.selectMember", keyword);
	        
	        // 1. 암호화 객체 얻기
	        String key = "sist1234";
	        String salt = "12345678";
	        TextEncryptor te = Encryptors.text(key, salt);
	        
	        // list의 각 항목에 대해 복호화 적용
	        for(MemberShipDomain msDomain : list) {
	            // 암호화된 user_id, birth 복호화
	            msDomain.setDecrypt_birth(te.decrypt(msDomain.getBirth()));
	        }
	        
	    } finally {
	        mbh.closeHandler(handler);
	    }
	    
	    return list;
	}//selectMember
	
	public MemberShipDomain selectOneMember(String user_id) throws PersistenceException{
		MemberShipDomain msDomain=new MemberShipDomain();
		
		MyBatisHandler mbh=MyBatisHandler.getInstance();
		
		SqlSession handler=mbh.getHandler();
		
		try {
			msDomain=handler.selectOne("kr.co.sist.admin.membership.selectOneMember",user_id);
			
			// 1. 암호화 객체 얻기
	        String key = "sist1234";
	        String salt = "12345678";
	        TextEncryptor te = Encryptors.text(key, salt);
	        
            // 암호화된 user_id, birth 복호화
            msDomain.setDecrypt_birth(te.decrypt(msDomain.getBirth()));
			
			
		}finally {
			mbh.closeHandler(handler);
		}//end finally
		
		return msDomain;
	}
}
