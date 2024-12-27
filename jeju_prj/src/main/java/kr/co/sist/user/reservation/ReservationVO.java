package kr.co.sist.user.reservation;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationVO {

	private String rsr_name, rsr_phone_number, rsr_status, user_id;
	private int number_people, room_id, rsr_id;
	private String check_in_date, check_out_date;
	private Date rsr_date;

}
