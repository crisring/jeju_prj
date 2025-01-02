package kr.co.sist.admin.room;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomVO {
	
	private int room_id;
	private int acm_id;
	private int max_person;
	private int price;
	private int discount_price;
	
	private String room_name;
	private String dlt_flag;
	private String reservation_flag;
	private String check_info;
	private String beds_info;
	private String capacity_info;
	
	private String check_in;
	private String check_out;
	
	private String[] img_name;
	
}
