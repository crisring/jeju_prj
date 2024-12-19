package kr.co.sist.user.searchACM;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchACMService {

	@Autowired
	private SearchACMDAO sacmDAO;

	/**
	 * 1.호텔, 2. 펜션 풀빌라, 3. 게하 한옥, 4. 캠핑 글램핑, 5. 홈 빌라 <br>
	 * 
	 * @param acm_type_id
	 * @return
	 */
	public List<SearchACMDomain> displayPopularTypes(int acm_type_id) {

		List<SearchACMDomain> list = null;

		try {

			// 1. 숙소 타입에 맞는 숙소 목록을 가져옴
			list = sacmDAO.selectByACMType(acm_type_id);

			// 2. 해당 숙소들에 대해 평점과 리뷰수를 추가
			if (list != null && !list.isEmpty()) {
				for (SearchACMDomain accommodation : list) {
					// 각 숙소에 대해 평점과 리뷰 수를 갱신
					SearchACMDomain ratingAndReview = sacmDAO.selectRatingReview(accommodation.getAcm_id());
					if (ratingAndReview != null) {
						accommodation.setRating(ratingAndReview.getRating());
						accommodation.setReviewCnt(ratingAndReview.getReviewCnt());
					}
				}
			}

		} catch (PersistenceException pe) {
			pe.printStackTrace();

		}

		return list;
	}// displayPopularTypes

	// public List<search> displayDetail(SearchVO sVO)

}
