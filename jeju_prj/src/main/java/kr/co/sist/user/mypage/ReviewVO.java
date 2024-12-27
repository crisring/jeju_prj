package kr.co.sist.user.mypage;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString

public class ReviewVO {

	private int acm_id, rating, rsr_id, review_id;
	private String content, user_id;
	private String img_name; // 이미지 이름
	private String[] img_names;
}
