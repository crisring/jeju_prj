package kr.co.sist.admin.reservation;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminReservationDomain {
	
	private int number_people;
	private int rsr_id;
	private int room_id;
	
	private String rsr_name;
	private String user_id;
	private String rsr_status;
	private String rsr_phone_number;
	
	private Date rsr_date;
	private Date check_in_date;
	private Date check_out_date;
	
	//room테이블
	private int price;
	private String address;
	private double longitude;
	private double latitude;
	private int acm_id;
	
	//accommodation테이블
	private String acm_name;
	private String main_img;
	private String admin_phone_number;
	private String admin_id;
	
	
}



