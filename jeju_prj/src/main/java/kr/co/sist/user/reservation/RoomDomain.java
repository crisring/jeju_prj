package kr.co.sist.user.reservation;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomDomain {

	private String room_name;
	private String acm_name;
	private String check_info;
	private String capacity_info;
	private String beds_info;
	private int room_id;
	private int price;
	private int discount_price;
	private int room_img_id;
	private String check_in, check_out;
	private List<String> img_name;
	private String room_img_name;
}
