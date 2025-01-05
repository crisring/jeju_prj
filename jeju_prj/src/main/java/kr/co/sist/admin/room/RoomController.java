package kr.co.sist.admin.room;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RoomController {

	@Autowired(required = false)
	private RoomService rs;
	
	@GetMapping("/admin/room_detail")
	public String selectOneRoom(int room_id, Model model) {
		AdminRoomDomain arDomain=null;
		
		arDomain=rs.searchOneRoom(room_id);
		
		model.addAttribute("room",arDomain);
		
		return "admin/acc/room_detail";
	}//selectOneRoom
	
	private String uploadDir = "C:/Users/user/git/jeju_prj/jeju_prj/src/main/resources/static/common/admin/images";
	
	
	@GetMapping("/admin/add_room")
	public String addRoom(@RequestParam("acm_id") int acm_id, Model model) {
	    model.addAttribute("acm_id", acm_id);
	    return "admin/acc/add_room";
	}
	
	@PostMapping("/admin/add_room_process")
	public String addRoomProcess(RoomVO rVO, 
	        @RequestParam("images") List<MultipartFile> images,  // name 변경
	        Model model) {
	    String msg = "";
	    
	    try {
	        // 디렉토리 확인 및 생성
	        File directory = new File(uploadDir);
	        if (!directory.exists()) {
	            directory.mkdirs();
	        }

	        // 이미지 처리
	        if (!images.isEmpty()) {
	            String[] imageNames = new String[images.size()];
	            for (int i = 0; i < images.size(); i++) {
	                MultipartFile image = images.get(i);
	                if (!image.isEmpty()) {
	                    image.transferTo(new File(uploadDir + "/" + image.getOriginalFilename()));
	                    imageNames[i] = image.getOriginalFilename();
	                }
	            }
	            rVO.setImg_name(imageNames);
	        }

	        // 서비스 호출 및 결과 처리
	        boolean flag = rs.addRoom(rVO);
	        msg = flag ? "객실이 성공적으로 등록되었습니다." : "객실 등록에 실패했습니다.";
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        msg = "객실 등록 중 오류가 발생했습니다.";
	    }
	    
	    model.addAttribute("msg", msg);
	    return "admin/acc/add_acc_result";
	}
	
	@PostMapping("/admin/room_update")
	public String modifyRoom(
	       @RequestParam(value="existingImages", required=false) List<String> existingImages,  // 기존 이미지 파일명
	       @RequestParam(value="newImages", required=false) List<MultipartFile> newImages,     // 새로 추가된 이미지
	       AdminRoomDomain arDomain, Model model) {
	   try {
	       // 이미지 처리
	       if(newImages != null) {
	           List<String> allImageNames = new ArrayList<>();
	           
	           // 기존 이미지 파일명 처리
	           if(existingImages != null) {
	               allImageNames.addAll(existingImages);
	           }
	           
	           // 새로 추가된 이미지 처리
	           for(MultipartFile newImage : newImages) {
	               if(!newImage.isEmpty()) {
	                   // 새 이미지 저장
	                   newImage.transferTo(new File(uploadDir + "/" + newImage.getOriginalFilename()));
	                   allImageNames.add(newImage.getOriginalFilename());
	               }
	           }
	           
	           // 모든 이미지 이름을 배열로 변환하여 도메인에 설정
	           arDomain.setImg_name(allImageNames.toArray(new String[0]));
	       } else {
	           // 새 이미지가 없으면 기존 이미지만 설정
	           if(existingImages != null) {
	               arDomain.setImg_name(existingImages.toArray(new String[0]));
	           }
	       }

	       boolean flag = rs.modifyRoom(arDomain);
	       model.addAttribute("msg", flag ? "객실 수정이 완료되었습니다." : "객실 수정이 실패하였습니다.");
	       model.addAttribute("room_id", arDomain.getRoom_id());
	   } catch(Exception e) {
	       e.printStackTrace();
	       model.addAttribute("msg", "객실 수정 중 오류가 발생했습니다: " + e.getMessage());
	   }
	   
	   return "admin/acc/room_update_result";
	}
	
	@PostMapping("/admin/removeRoom")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> removeRoom(@RequestParam List<Integer> roomIds) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean result = rs.removeRoom(roomIds);
	        response.put("success", result);
	    } catch(Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	    }
	    return ResponseEntity.ok(response);
	}

}
