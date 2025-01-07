package kr.co.sist.user.searchACM;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sist.user.util.SearchVO;

@Service
public class SearchACMService {

	@Autowired
	private SearchACMDAO sacmDAO;

	public List<SearchACMDomain> displayDetail(SearchVO sVO) {

		List<SearchACMDomain> list = null;

		try {
			// 1. 숙소 타입에 맞는 숙소 목록을 가져옴
			list = sacmDAO.selectACM(sVO);

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

				// 3. 평점 순으로 내림차순 정렬 (높은 평점부터 순서대로)
				Collections.sort(list, new Comparator<SearchACMDomain>() {
					@Override
					public int compare(SearchACMDomain o1, SearchACMDomain o2) {
						return Double.compare(o2.getRating(), o1.getRating()); // 내림차순
					}
				});

			}

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}

	public List<ACMTypeDomain> displayACMType() {
		List<ACMTypeDomain> list = null;
		try {
			list = sacmDAO.selectAllACMType();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
		return list;
	}

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

				// 3. 평점 순으로 내림차순 정렬 (높은 평점부터 순서대로)
				Collections.sort(list, new Comparator<SearchACMDomain>() {
					@Override
					public int compare(SearchACMDomain o1, SearchACMDomain o2) {
						return Double.compare(o2.getRating(), o1.getRating()); // 내림차순
					}
				});
			}

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return list;
	}// displayPopularTypes

	public List<ACMTypeDomain> displayAllType() {
		List<ACMTypeDomain> list = new ArrayList<>();
		try {
			int acm_type_id = 0;
			List<SearchACMDomain> searchList = sacmDAO.selectByACMType(acm_type_id);

			// SearchACMDomain을 ACMTypeDomain으로 변환
			for (SearchACMDomain search : searchList) {
				ACMTypeDomain acmType = new ACMTypeDomain();
				// SearchACMDomain에서 ACMTypeDomain으로 값 복사
				// 예: acmType.setId(search.getId());
				list.add(acmType);
			}
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
		return list;
	}

	public List<FacilityDomain> displayAllFacility() {
		List<FacilityDomain> list = null;
		try {
			list = sacmDAO.selectAllFacility();
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}
		return list;
	}

}
