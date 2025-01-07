package kr.co.sist.user.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.sist.user.mypage.ReviewVO;
import kr.co.sist.user.util.SearchVO;

@Service
public class UserReviewManageService {

    @Autowired
    private UserReviewManageDAO urDAO;

    public List<ReviewDomain> searchAllReview(SearchVO sVO) {
        List<ReviewDomain> reviews = urDAO.selectAllReview(sVO);
        for (ReviewDomain review : reviews) {
            List<String> imgNames = urDAO.selectReviewImg(review.getReview_id());
            if (imgNames != null && !imgNames.isEmpty()) {
                review.setImg_name(imgNames); // 첫 번째 이미지를 img_name으로 설정
            }
        }
        return reviews;
    }

    public ReviewDomain displayReview(int review_id) {
        ReviewDomain rDomain = urDAO.selectOneReview(review_id);
        rDomain.setImg_name(urDAO.selectReviewImg(review_id));
        return rDomain;
    }

    public boolean modifyReview(ReviewVO rVO) {
        return urDAO.updateReview(rVO) > 0;
    }

    public boolean removeReview(int review_id) {
        // 리뷰 삭제 전 이미지 삭제
        List<String> imgNames = urDAO.selectReviewImg(review_id);
        for (String imgName : imgNames) {
            urDAO.deleteReviewImage(review_id, imgName);
        }
        // 리뷰 삭제
        return urDAO.deleteReview(review_id) > 0;
    }

    public void addReviewImage(int review_id, String imgName) {
        urDAO.insertReviewImage(review_id, imgName);
    }

    public void deleteReviewImage(int review_id, String imgName) {
        urDAO.deleteReviewImage(review_id, imgName);
    }

    public int totalCount(SearchVO sVO) {
        return urDAO.selectTotalCount(sVO);
    }
}
