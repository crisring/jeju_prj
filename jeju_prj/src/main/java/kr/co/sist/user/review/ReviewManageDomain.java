package kr.co.sist.user.review;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewManageDomain {

	private int review_id;
	private String acm_name;
	private String content;
	private String user_id;
	private Date created_at;
	private List<String> img_name;
	private int rating;

}
