package kr.co.sist.admin.member;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberShipVO {
	
	private String user_id;
	private String password;
	private String user_name;
	private String phone_number;
	private String gender;
	private String user_ip;
	private String user_status;
	private String member_type;
	private Date birth;
	private Date join_date;
	
}
