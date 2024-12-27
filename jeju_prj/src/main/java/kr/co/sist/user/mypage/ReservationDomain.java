package kr.co.sist.user.mypage;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class ReservationDomain {

	private String rsr_id, rsr_name, rsr_status, acm_main_img, acm_name, room_name;
	private int room_id, price, discount_price, review_id, cnt, acm_id;
	private Date check_in_date, check_out_date, rsr_date;
}
