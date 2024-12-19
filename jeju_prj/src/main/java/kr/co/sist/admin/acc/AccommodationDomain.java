package kr.co.sist.admin.acc;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommodationDomain {

	private String main_img, acm_name, fcl_type, admin_phone_number, address, detail_address, content, acm_type;

	private int acm_type_id, acm_id;

	private String[] sub_img_name;

	private double longtitude, latitude;

}
