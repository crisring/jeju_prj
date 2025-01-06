package kr.co.sist.ACMDetail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import jakarta.annotation.Resource;

@Resource
@Repository
public class ACMDetailDAO {

    public ACMDomain selectOneACM(int acm_id) throws PersistenceException {
        ACMDomain acmd = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            acmd = handler.selectOne("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectACMDetail", acm_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return acmd;
    }

    public List<ACMSubimgDomain> selectACM_img(int acm_id) throws PersistenceException {
        List<ACMSubimgDomain> list = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            list = handler.selectList("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectACMSubImages", acm_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return list;
    }

    public List<RoomDomain> selectAllRoom(int acm_id) throws PersistenceException {
        List<RoomDomain> list = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            list = handler.selectList("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectAllRooms", acm_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return list;
    }

    public List<ACMDomain> selectRooomimg(int room_id) throws PersistenceException {
        List<ACMDomain> list = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            list = handler.selectList("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectRoomImages", room_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return list;
    }

    public List<ReviewDomain> selectReview(int acm_id, String sort) throws PersistenceException {
        List<ReviewDomain> list = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            // 파라미터를 Map으로 전달
            Map<String, Object> params = new HashMap();
            params.put("acm_id", acm_id);
            params.put("sort", sort);

            list = handler.selectList("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectReviews", params);
        } finally {
            mbh.closeHandler(handler);
        }
        return list;
    }


    public List<String> selectACMFacility(int acm_id) throws PersistenceException {
        List<String> list = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            list = handler.selectList("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectFacilities", acm_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return list;
    }

    public RoomDomain selectRoomDetail(int room_id) throws PersistenceException {
        RoomDomain rDomain = null;

        MyBatisHandler mbh = MyBatisHandler.getInstance();
        SqlSession handler = mbh.getHandler();

        try {
            rDomain = handler.selectOne("kr.co.sist.user.ACMdetail.ACMDetailDAO.selectRoomDetail", room_id);
        } finally {
            mbh.closeHandler(handler);
        }
        return rDomain;
    }
}
