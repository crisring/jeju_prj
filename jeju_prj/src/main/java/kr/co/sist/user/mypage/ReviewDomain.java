package kr.co.sist.user.mypage;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReviewDomain {
	 private int review_id;
	    private String acm_name;
	    private int rating;
	    private String content;
	    private String created_at;
	    private List<String> img_names; // 다중 이미지 이름 추가
	    
	    
	    
}
