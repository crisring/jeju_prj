package kr.co.sist.admin.member;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberShipDomain {
	private String user_id;
	private String user_name;
	private String gender;
	private String phone_number;
	private String user_status;
	private String member_type;
	private String birth;
	private Date join_date;

	private String decrypt_user_id;
	private String decrypt_birth;
}
