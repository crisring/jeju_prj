package kr.co.sist.user.member;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {

	public MemberVO(String user_id, String password, String user_name, String user_ip, String member_type,
			String phone_number) {
		super();
		this.user_id = user_id;
		this.password = password;
		this.user_name = user_name;
		this.user_ip = user_ip;
		this.member_type = member_type;
		this.phone_number = phone_number;
	}

	private String user_id, password, user_name, phone_number, birth, gender, user_ip, user_status, member_type;

	private Timestamp join_date;

	private int cesessionReason;

}
