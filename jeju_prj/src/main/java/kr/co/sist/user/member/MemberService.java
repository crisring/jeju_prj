package kr.co.sist.user.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import jakarta.persistence.PersistenceException;

@Service
public class MemberService {

	@Autowired
	private MemberDAO mDAO;

	/**
	 * 회원가입하고 회원을 추가하는 service
	 * 
	 * @param mVO
	 * @return
	 */
	public boolean addMember(MemberVO mVO) {
		boolean flag = false;

		try {

			mVO.setUser_status("정상");
			mVO.setMember_type("일반회원");
			setEncryption(mVO);

			int rowCnt = mDAO.insertMember(mVO);

			if (rowCnt == 1) {

				idDup(mVO.getUser_id());
				flag = true;

			} // end if

		} catch (PersistenceException pe) {

			pe.printStackTrace();

		} // end catch

		return flag;
	}// addMember

	/**
	 * 아이디 중복체크를 하는 service
	 * 
	 * @param dupId
	 * @return
	 */
	public boolean idDup(String dupId) {
		boolean flag = false;
		try {
			
			String resultId = mDAO.selectMember(dupId);
			flag = (resultId == null || "".equals(resultId));
		} catch (PersistenceException pe) {

			pe.printStackTrace();

		} // end catch
		return flag;

	}// idDup

	/**
	 * 암호화 처리하는 메서드
	 * 
	 * @param mVO
	 */
	public void setEncryption(MemberVO mVO) {
		// 비밀번호는 일방향 해시로 처리

		// 1.일방향 해쉬 객체 생성
		PasswordEncoder pe = new BCryptPasswordEncoder();

		try {
			// 2.입력된값을 일방향 해쉬 비밀번호

			mVO.setPassword(pe.encode(mVO.getPassword()));

			String key = "sist1234";
			String salt = "12345678";

			TextEncryptor te = Encryptors.text(key, salt);


			// 생년월일 암호화
			String plainBirth = mVO.getBirth();
			String encptBirth = te.encrypt(plainBirth);

			// 비밀번호는 일방향 해시로 저장할거임

			// 암호화된 값을 VO에 다시 저장
			mVO.setBirth(encptBirth);
		} catch (PersistenceException e) {
			e.printStackTrace();
		}

	}// setEncryption

	/**
	 * 복호화 처리하는 메서드
	 * 
	 * @param mVO
	 */
	public void setDecryption(MemberVO mVO) {

		String key = "sist1234";
		String salt = "12345678"; // 암호화 강도 조절
		// 1.암호화 객체 생성
		TextEncryptor te = Encryptors.text(key, salt);
		try {

			//생일 복호화
			String encptBirth = mVO.getBirth();
			String decptBirth = te.decrypt(encptBirth);


			mVO.setBirth(decptBirth);

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

	}// setDecryption

}// class
