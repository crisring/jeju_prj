package kr.co.sist.user.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jakarta.persistence.PersistenceException;
import kr.co.sist.dao.MyBatisHandler;
import kr.co.sist.user.mypage.ReviewVO;
import kr.co.sist.user.util.SearchVO;

@Repository
public class UserReviewManageDAO {

    public int selectTotalCount(SearchVO sVO) throws PersistenceException {
        int totalCount = 0;
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            // 매퍼에 정의된 "kr.co.sist.reviewManageMapper.totalCnt" 호출
            totalCount = handler.selectOne("kr.co.sist.userReview.totalCnt", sVO);
        } finally {
            mbh.closeHandler(handler);
        }
        return totalCount;
    }// selectTotalCount



    public List<ReviewDomain> selectAllReview(SearchVO sVO) throws PersistenceException {
        List<ReviewDomain> list = null;
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            // 주의: 매퍼 XML의 <select id="selectUserReviews" ...> 와 동일하게!
            list = handler.selectList("kr.co.sist.userReview.selectUserReviews", sVO);
        } finally {
            mbh.closeHandler(handler);
        }
        return list;
    }// selectAllReview

    public ReviewDomain selectOneReview(int review_id) throws PersistenceException {
        ReviewDomain rDomain = null;
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            rDomain = handler.selectOne("kr.co.sist.userReview.selectOneReview", review_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return rDomain;
    }// selectOneReview


    public int updateReview(ReviewVO rVO) throws PersistenceException {
        int rowCnt = 0;
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        // autoCommit = true
        SqlSession handler = mbh.getHandler(true);

        try {
            // 매퍼에 <update id="updateReview"> 정의해둬야 함
            rowCnt = handler.update("kr.co.sist.userReview.updateReview", rVO);
        } finally {
            mbh.closeHandler(handler);
        }
        return rowCnt;
    }// updateReview


    public List<String> selectReviewImg(int review_id) throws PersistenceException {
        List<String> img_names = null;
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();
        try {
            img_names = handler.selectList("kr.co.sist.reviewManageMapper.selectReviewImg", review_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return img_names;
    }// selectReviewImg


    public int deleteReview(int review_id) throws PersistenceException {
        int rowCnt = 0;
        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler(true);
        try {
            rowCnt = handler.delete("kr.co.sist.userReview.deleteReview", review_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return rowCnt;
    }// deleteReview

}// class
