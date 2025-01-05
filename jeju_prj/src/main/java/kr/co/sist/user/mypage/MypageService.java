package kr.co.sist.user.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.sist.user.member.MemberVO;

@Service
public class MypageService {

	@Autowired
	MypageDAO mDAO;

	public boolean checkPass(MemberVO mVO) {
		PasswordEncoder pe = new BCryptPasswordEncoder();
		boolean chkFlag = false;

		// (1) 아이디로 DB에서 암호화된 비밀번호 조회
		String dbPassword = mDAO.selectPass(mVO);
		System.out.println(mVO.getPassword()+"mvopass");
		if (dbPassword == null) {
			System.out.println("사용자 ID에 해당하는 비밀번호가 존재하지 않습니다.");
			return false;
		}//nd if

		// (2) 평문(사용자 입력)과 DB 해시값 비교
		chkFlag = pe.matches(mVO.getPassword(), dbPassword);
		System.out.println(mVO.getPassword());
		System.out.println(dbPassword);
		if (chkFlag) {
			System.out.println("비밀번호가 일치합니다."+chkFlag);
		} else {
			System.out.println("비밀번호가 일치하지 않습니다."+chkFlag);
		}//end else

		return chkFlag;
	}
}// class
