package kr.co.sist.user.ACMdetail;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ACMDomain {

	private int acm_id, acm_img_id, acm_type_id;
	private String acm_name, address, dtail_Address, description, main_Img, admin_Phone_number, dit_flag, admin_id,
			acm_type;
	private double longitude, latitude;
	private List<String> room_img_name;
}
