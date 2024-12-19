package kr.co.sist.user.searchACM;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString

public class SearchACMDomain {

	private int acm_id, reviewCnt, price, discountPrice, acm_type_id;
	private float rating;
	private String acm_name, detail_address, main_img;
}
