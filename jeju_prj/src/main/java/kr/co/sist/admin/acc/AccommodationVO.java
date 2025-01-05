package kr.co.sist.admin.acc;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommodationVO {

	private String acm_name, address, detail_address, description, main_img, admin_phone_number, dlt_flag, admin_id,
			acm_type;

	private int acm_type_id, fcl_id, acm_img_id;

	private long acm_id;
	
	private double longitude, latitude;

	private String[] sub_img_name, fcl_name, content;

}
