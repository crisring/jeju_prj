package kr.co.sist.admin.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin")
public class ReviewRestController {

	@Autowired
	ReviewManageService rms;

	/**
	 * 리뷰 삭제 AJAX
	 * 
	 * @return json
	 */
	@DeleteMapping("/review_remove/{review_id}")
	public String removeReviewProc(@PathVariable int review_id) {

		String jsonObj = "";

		jsonObj = rms.removeReview(review_id);

		return jsonObj;
	}// removeReviewProc

}
