package kr.co.sist.ACMDetail;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ACMDetailService {

    @Autowired
    private ACMDetailDAO acmdDAO;

    /**
     * 숙소 상세 정보 조회
     * @param acm_id 숙소 ID
     * @return 숙소 상세 정보
     */
    public ACMDomain findOneACM(int acm_id) {
        ACMDomain acmd = null;
        try {
            acmd = acmdDAO.selectOneACM(acm_id); // DAO 호출
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return acmd;
    }

    /**
     * 숙소의 모든 방 조회
     * @param acm_id 숙소 ID
     * @return 방 목록
     */
    public List<RoomDomain> findAllRoom(int acm_id) {
        List<RoomDomain> list = null;
        try {
            list = acmdDAO.selectAllRoom(acm_id); // DAO 호출
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return list;
    }

    /**
     * 숙소 서브 이미지 조회
     * @param acm_id 숙소 ID
     * @return 서브 이미지 목록
     */
    public List<ACMSubimgDomain> displayACMImg(int acm_id) {
        List<ACMSubimgDomain> list = null;
        try {
            list = acmdDAO.selectACM_img(acm_id); // DAO 호출
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return list;
    }

    /**
     * 방 이미지 조회
     * @param room_id 방 ID
     * @return 방 이미지 목록
     */
    public List<ACMDomain> displayRoomImg(int room_id) {
        List<ACMDomain> list = null;
        try {
            list = acmdDAO.selectRooomimg(room_id); // DAO 호출
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return list;
    }

    /**
     * 숙소 리뷰 조회
     * @param acm_id 숙소 ID
     * @param sort 정렬 기준
     * @return 리뷰 목록
     */
    public List<ReviewDomain> findReview(int acm_id, String sort) {
        List<ReviewDomain> list = null;
        try {
        	list = acmdDAO.selectReview(acm_id, sort);// DAO 호출
            
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return list;
    }

    /**
     * 숙소 시설 목록 조회
     * @param acm_id 숙소 ID
     * @return 시설 목록
     */
    public List<String> displayAcmFacility(int acm_id) {
        List<String> list = null;
        try {
            list = acmdDAO.selectACMFacility(acm_id); // DAO 호출
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return list;
    }

    /**
     * 방 상세 정보 조회
     * @param room_id 방 ID
     * @return 방 상세 정보
     */
    public RoomDomain displayRoomDetail(int room_id) {
        RoomDomain RDomain = null;
        try {
        	RDomain = acmdDAO.selectRoomDetail(room_id); // DAO 호출
        } catch (PersistenceException pe) {
            pe.printStackTrace();
        }
        return RDomain;
    }
}
