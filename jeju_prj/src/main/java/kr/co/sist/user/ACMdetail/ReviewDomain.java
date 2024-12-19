package kr.co.sist.user.ACMdetail;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDomain {

	private int review_id, acm_id, rating, rsr_id;
	private String content, acm_name, user_id, acm_main_img;
	private Timestamp created_at;
	private List<String> img_name;
}
