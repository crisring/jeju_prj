package kr.co.sist.user.ACMdetail;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RoomDomain {

	private String room_name, check_info, capacity_info, beds_info;
	private int room_id, price, discount_price, room_img_id;
	private List<String> img_name;
}
