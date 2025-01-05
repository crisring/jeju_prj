package kr.co.sist.user.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.persistence.PersistenceException;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@Service
public class LoginService {

	@Autowired
	private LoginDAO lDAO;

	/**
	 * 사용자 로그인 검증 및 정보 조회
	 */
	public MemberDomain searchLogin(LoginVO lVO) {
		// DAO를 통해 사용자 정보 조회

		MemberDomain mDomain = lDAO.selectLogin(lVO);
		System.out.println(lVO);
		// 조회된 사용자 정보가 없는 경우 예외 처리
		if (mDomain == null) {
			throw new RuntimeException("해당 사용자가 존재하지 않습니다.");
		} // end if

		// 비밀번호 검증
		PasswordEncoder pe = new BCryptPasswordEncoder();
		boolean loginFlag = pe.matches(lVO.getPassword(), mDomain.getPassword());

		if (loginFlag) {
			System.out.println("비번일치" + lVO.getPassword());
			// 비밀번호 검증 성공: 비밀번호는 반환하지 않음
			mDomain.setPassword(null);
			return mDomain;
		} else {
			System.out.println("비번틀림" + lVO.getPassword());
			// 비밀번호 검증 실패
			throw new RuntimeException("비밀번호가 일치하지 않습니다.");
		} // end else
	}// searchLogin

	public String findIdService(MemberFindVO mfVO) {
		String findId = null; // 초기값을 null로 설정
		try {
			// 1️ 데이터베이스에서 아이디 조회
			findId = lDAO.selectId(mfVO);

			// 2️ 아이디가 존재할 경우 로직 (복호화 불필요)
			if (findId != null && !findId.isEmpty()) {
				System.out.println("조회된 아이디: " + findId);
			}

		} catch (PersistenceException e) {
			e.printStackTrace();
		} // end catch

		// 3️ 결과 반환
		return findId;
	}// findIdService

	public boolean findPassService(MemberFindVO mfVO) {
		boolean flag = false;
		try {
			// USER_ID가 존재하면 true
			String userId = lDAO.selectPass(mfVO);
			flag = (userId != null && !userId.isEmpty());
			System.out.println("계정 유무: " + flag);
		} catch (PersistenceException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean resetPassword(MemberVO mVO) {

		boolean flag = false;
		PasswordEncoder pe = new BCryptPasswordEncoder();
		System.out.println(mVO.getPassword() + "비번입력값");
		try {
			String pass = pe.encode(mVO.getPassword());
			mVO.setPassword(pass);// 일방향 암호화해서 비번넣기
			if (flag = lDAO.updatePass(mVO) == 1) {
				// 비밀번호 업데이트에 성공한 경우
				flag = true;
				System.out.println("비밀번호 재설정 성공" + mVO.getPassword());
			} else {
				flag = false;
			} // end else

		} catch (PersistenceException e) {
			e.printStackTrace();
		} // end catch

		return flag;
	}// resetPassword

	
	 public boolean isWithdrawnUser(String userId) {
	        String status = lDAO.getUserStatus(userId);
	        return "탈퇴".equals(status); // user_status가 WITHDRAWN인지 확인
	    }
	
	
}// class
