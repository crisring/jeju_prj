package kr.co.sist.infoChange;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.stereotype.Service;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.member.MemberVO;

@Service
public class infoChangeService {

	@Autowired
	private infoChangeDAO icDAO;

	/**
	 * 특정 회원(user_id) 정보 조회 및 생년월일 형식 변환
	 */
	public MemberDomain getMemberInfo(String userId) {
		String key = "sist1234";
		String salt = "12345678"; // 암호화 강도 조절
		// 복호화 객체 생성
		TextEncryptor te = Encryptors.text(key, salt);
		MemberDomain member = icDAO.selectOneMember(userId);

		if (member != null && member.getBirth() != null && !member.getBirth().equals("-")) {
			try {
				String decryptedBirth = te.decrypt(member.getBirth()); // '20051120'

				if (decryptedBirth.length() == 8) {
					// 'yyyyMMdd' 형식을 'yyyy-MM-dd' 형식으로 변환
					String formattedBirth = decryptedBirth.substring(0, 4) + "-" + decryptedBirth.substring(4, 6) + "-"
							+ decryptedBirth.substring(6, 8);
					member.setBirth(formattedBirth); // '2005-11-20'
				}
			} catch (Exception e) {
				// 복호화 실패 시, birth를 null로 설정하거나 적절한 처리
				member.setBirth(null);
			}
		}
		return member;
	}

	/**
	 * 회원정보 수정
	 */
	public boolean modifyInfo(MemberVO mVO) {
		String key = "sist1234";
		String salt = "12345678"; // 암호화 강도 조절
		// 암호화 객체 생성
		TextEncryptor te = Encryptors.text(key, salt);

		// 생년월일 가져오기
		String birth = mVO.getBirth(); // '2005-12-20'

		// 'yyyy-MM-dd' → 'yyyyMMdd'
		if (birth != null && birth.contains("-")) {
			birth = birth.replace("-", ""); // '20051220'
			try {
				// 암호화
				String encryptedBirth = te.encrypt(birth);
				mVO.setBirth(encryptedBirth);
			} catch (Exception e) {
				// 암호화 실패 시, 수정 실패로 처리
				return false;
			}
		}

		// DB update
		int row = icDAO.updateInfo(mVO);
		return (row == 1); // 성공 시 true
	}

	/**
	 * 회원탈퇴 처리
	 */
	public boolean withdrawMember(WithDrawDomain wdDomain) {
		// [1] 파라미터 유효성 검사
		if (wdDomain.getUser_id() == null || wdDomain.getUser_id().trim().isEmpty()) {
			throw new IllegalArgumentException("user_id가 유효하지 않습니다.");
		}

		// [2] DAO 메서드 호출 → 내부에서 (1) 회원 삭제 + (2) 탈퇴 사유 INSERT + commit
		int rowCnt = icDAO.deleteMember(wdDomain);

		// rowCnt는 DELETE + INSERT의 합산 개수
		return (rowCnt >= 2);
	}
}
