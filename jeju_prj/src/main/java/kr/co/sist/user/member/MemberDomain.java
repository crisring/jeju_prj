package kr.co.sist.user.member;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDomain {

	private String user_id, password, user_name, phone_number, birth, gender, user_ip, user_status, member_type;

	private Timestamp join_date;

}
