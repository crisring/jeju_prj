package kr.co.sist.user.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.mypage.ReviewVO;
import kr.co.sist.user.util.SearchVO;

@Repository
public class UserReviewManageDAO {

    public int selectTotalCount(SearchVO sVO) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            return handler.selectOne("kr.co.sist.userReview.totalCnt", sVO);
        } finally {
            mbh.closeHandler(handler);
        }
    }

    public List<ReviewDomain> selectAllReview(SearchVO sVO) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            return handler.selectList("kr.co.sist.userReview.selectUserReviews", sVO);
        } finally {
            mbh.closeHandler(handler);
        }
    }

    public ReviewDomain selectOneReview(int review_id) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            return handler.selectOne("kr.co.sist.userReview.selectOneReview", review_id);
        } finally {
            mbh.closeHandler(handler);
        }
    }

    public int updateReview(ReviewVO rVO) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler(true);
        try {
            return handler.update("kr.co.sist.userReview.updateReview", rVO);
        } finally {
            mbh.closeHandler(handler);
        }
    }

    public List<String> selectReviewImg(int review_id) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            return handler.selectList("kr.co.sist.userReview.selectReviewImg", review_id);
        } finally {
            mbh.closeHandler(handler);
        }
    }

    public int deleteReview(int review_id) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler(true);
        try {
            return handler.delete("kr.co.sist.userReview.deleteReview", review_id);
        } finally {
            mbh.closeHandler(handler);
        }
    }

    /**
     * 리뷰 이미지 추가
     */
    public void insertReviewImage(int review_id, String imgName) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler(true);
        try {
            handler.insert("kr.co.sist.userReview.insertReviewImage", new ReviewImageVO(review_id, imgName));
        } finally {
            mbh.closeHandler(handler);
        }
    }

    /**
     * 리뷰 이미지 삭제
     */
    public void deleteReviewImage(int review_id, String imgName) {
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler(true);
        try {
            ReviewImageVO vo = new ReviewImageVO(review_id, imgName);
            handler.delete("kr.co.sist.userReview.deleteReviewImage", vo);
        } finally {
            mbh.closeHandler(handler);
        }
    }
}
