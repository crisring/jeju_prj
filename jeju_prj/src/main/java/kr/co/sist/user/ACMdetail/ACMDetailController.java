package kr.co.sist.ACMDetail;

import java.awt.Dialog.ModalExclusionType;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class ACMDetailController {
	
	@Autowired
	private ACMDetailService acmds;


    @GetMapping("/acm/acmDetail")
    public String acmView(int acm_id, Model model, String sort) {
    	ACMDomain acmDetail = acmds.findOneACM(acm_id);
        model.addAttribute("acmDetail", acmDetail);

        // 숙소 방 목록 가져오기
        List<RoomDomain> roomList = acmds.findAllRoom(acm_id);
        model.addAttribute("roomList", roomList);

        List<ACMSubimgDomain> acmsub=acmds.displayACMImg(acm_id);
        model.addAttribute("acmsub",acmsub);
        
        List<ReviewDomain> review = acmds.findReview(acm_id, sort);
        model.addAttribute("review", review);
        
        List<String> facility=acmds.displayAcmFacility(acm_id);
        model.addAttribute("facility",facility);

        return "acm/acmDetail"; 
    }
    @GetMapping("/acm/roomimg")
    @ResponseBody
    public String roomingView(int room_id) {
        // RoomDomain 객체로 방 이미지 리스트 받아오기
        List<ACMDomain> list = acmds.displayRoomImg(room_id);
        
        // JSON 변환
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("roomingView", list);
        
        return jsonObj.toJSONString(); // JSON 형태로 반환
    }
     
    @GetMapping("/acm/roomDetail")
    @ResponseBody
    public ACMDomain roomDetail(int room_id, Model model) {
        RoomDomain roomDomain = acmds.displayRoomDetail(room_id);

        ACMDomain acmdDomain = new ACMDomain();
        
        acmdDomain.setAcm_id(roomDomain.getRoom_id());  // 예: room_id를 acm_id로 설정
        acmdDomain.setRoom_img_name(roomDomain.getImg_name()); // RoomDomain의 이미지 리스트 설정
        acmdDomain.setAddress("주소 정보"); 

        model.addAttribute("roomDetail", acmdDomain);

        return acmdDomain; // ACMDomain 객체 반환
    }


	 
}