package kr.co.sist.admin.room;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminRoomDomain {
	
	private int room_id;
	private int price;
	private int discount_price;
	private int	room_img_id;
	private int max_person;
	
	private String room_name;
	private String check_info;
	private String beds_info;
	private String capacity_info;
	private String dlt_flag;
	
	private String[] img_name;
	
	private String check_in;
	private String check_out;
	
}
