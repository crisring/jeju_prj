package kr.co.sist.user.login;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberFindVO {
	private String user_id, user_name, phone_number;
}
