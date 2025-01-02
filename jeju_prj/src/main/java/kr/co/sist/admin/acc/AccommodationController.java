package kr.co.sist.admin.acc;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import kr.co.sist.admin.room.AdminRoomDomain;
import kr.co.sist.admin.room.RoomService;

@SessionAttributes("admin_id")
@Controller
public class AccommodationController {

	@Autowired(required = false)
	private AccommodationService as;
	
	@Autowired(required = false)
	private RoomService rs;

	@RequestMapping(value = "/admin", method = { GET, POST })
	public String main() {

		return "admin_index";
	}//main

	@GetMapping("/admin/acc_list")
	public String accList(SearchAccVO sVO, @SessionAttribute("admin_id") String admin_id,
			@RequestParam(defaultValue = "1") int page, Model model) {
		sVO.setCurrentPage(page);
		
		sVO.setAdmin_id(admin_id);
		
		List<AccommodationDomain> list = as.searchAllAcc(sVO);
		int totalPages = as.totalPages(sVO);
		model.addAttribute("data", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "admin/acc/acc_list";
	}// searchProcess

	@GetMapping("/admin/add_acc")
	public String addAcc(Model model) {

		return "admin/acc/add_acc";
	}// addAcc

	private String uploadDir = "C:/Users/user/git/jeju_prj/jeju_prj/src/main/resources/static/common/admin/images"; // 업로드
																													// 경로
	@PostMapping("/admin/add_acc_process")
	public String addAccProcess(AccommodationVO aVO, @RequestParam("mainFile") MultipartFile mainImg, // name 변경
			@RequestParam("subFiles") List<MultipartFile> subImgs, // name 변경
			@RequestParam(value = "fcl_name", required = false) String[] facilities,
			@RequestParam(value = "content", required = false) String[] contents, Model model) {

		try {
			// 파일 처리만 추가로 하고 나머지 데이터는 자동으로 VO에 바인딩됨
			if (!mainImg.isEmpty()) {
				mainImg.transferTo(new File(uploadDir + "/" + mainImg.getOriginalFilename()));
				aVO.setMain_img(mainImg.getOriginalFilename());
			}

			if (!subImgs.isEmpty()) {
				String[] subImgNames = new String[subImgs.size()];
				for (int i = 0; i < subImgs.size(); i++) {
					MultipartFile subImg = subImgs.get(i);
					if (!subImg.isEmpty()) {
						subImg.transferTo(new File(uploadDir + "/" + subImg.getOriginalFilename()));
						subImgNames[i] = subImg.getOriginalFilename();
					}
				}
				aVO.setSub_img_name(subImgNames);
			}

			boolean flag = as.addAcc(aVO);
			model.addAttribute("msg", flag ? "숙소가 성공적으로 등록되었습니다." : "숙소 등록에 실패했습니다.");

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "숙소 등록 중 오류가 발생했습니다.");
		}

		return "admin/acc/add_acc_result";
	}

	@GetMapping("/admin/acc_detail")
	public String accDetail(@RequestParam int acm_id, Model model) {
		AccommodationDomain acc = as.searchOneAcc(acm_id);
		
		// acc 객체 내부의 List들을 개별적으로 접근 가능
		List<String> subImages = acc.getSub_img_names(); // 서브이미지 목록
		List<String> contents = acc.getContents(); // 내용 목록
		List<String> facilities = acc.getFcl_names(); // 편의시설 목록

		// 모델에 데이터 추가
		model.addAttribute("acc", acc);
		// 필요하다면 List들을 개별적으로도 추가 가능
		model.addAttribute("subImages", subImages);
		model.addAttribute("contents", contents);
		model.addAttribute("facilities", facilities);
		
		List<AdminRoomDomain> roomList=null;
		roomList=rs.searchAllRoom(acm_id);
		
		model.addAttribute("room", roomList);
		

		return "admin/acc/acc_detail";
	}// accDetail

	@PostMapping("/admin/acc_modify")
	public String updateAccommodation(
		    @RequestParam(value = "fcl_names", required = false) List<String> fcl_names,
		    @RequestParam(value = "mainFile", required = false) MultipartFile mainImg,
		    @RequestParam(value = "subFiles", required = false) List<MultipartFile> subImgs,
		    @RequestParam(value = "existingSubFiles", required = false) List<String> existingSubFiles,  // 기존 이미지 파일명
		    @RequestParam(value = "content", required = false) List<String> contents,
		    AccommodationDomain acc, Model model) {

	    try {
	        // 편의시설 처리
	        acc.setFcl_names(fcl_names != null ? fcl_names : new ArrayList<>());

	        // 메인이미지 처리
	        if (mainImg != null && !mainImg.isEmpty()) {
	            // 새 메인이미지가 업로드된 경우 기존 이미지 삭제
	            if (acc.getMain_img() != null) {
	                File oldFile = new File(uploadDir + "/" + acc.getMain_img());
	                if (oldFile.exists()) oldFile.delete();
	            }
	            // 새 이미지 저장
	            mainImg.transferTo(new File(uploadDir + "/" + mainImg.getOriginalFilename()));
	            acc.setMain_img(mainImg.getOriginalFilename());
	        } else {
	            // 새 이미지가 없으면 기존 이미지를 유지
	            System.out.println("메인이미지 유지: " + acc.getMain_img());
	        }

	     // 서브이미지와 컨텐츠 처리
	        if (subImgs != null && contents != null) {
	            List<String> newSubImgNames = new ArrayList<>();
	            List<String> newContents = new ArrayList<>();

	            // 기존 이미지 파일명 받아오기
	            if (existingSubFiles != null) {
	                newSubImgNames.addAll(existingSubFiles);
	                // contents는 순서대로 매칭
	                for (int i = 0; i < existingSubFiles.size(); i++) {
	                    newContents.add(contents.get(i));
	                }
	            }

	            // 새로 추가된 이미지 처리
	            for (int i = 0; i < subImgs.size(); i++) {
	                MultipartFile subImg = subImgs.get(i);
	                int contentIndex = newContents.size();  // 현재까지 추가된 content 개수를 기준으로
	                if (!subImg.isEmpty() && contentIndex < contents.size()) {
	                    // 새 서브이미지 저장
	                    subImg.transferTo(new File(uploadDir + "/" + subImg.getOriginalFilename()));
	                    newSubImgNames.add(subImg.getOriginalFilename());
	                    newContents.add(contents.get(contentIndex));
	                }
	            }

	            acc.setSub_img_names(newSubImgNames);
	            acc.setContents(newContents);

	        } else {
	            // 서브이미지와 컨텐츠가 null이면 기존 데이터 유지
	            System.out.println("서브이미지와 컨텐츠를 유지합니다.");
	        }

	        boolean flag = as.modifyAcc(acc);
	        System.out.println("수정 결과: " + flag); // 디버깅
	        model.addAttribute("msg", flag ? "수정이 완료되었습니다." : "수정이 실패하였습니다.");

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("msg", "수정 중 오류가 발생했습니다: " + e.getMessage());
	    }

	    return "admin/acc/add_acc_result";
	}
	
	@GetMapping("/admin/acc_remove")
	public String removeAcc(int acm_id, Model model) {
		boolean flag=false;
		String msg="";
		flag=as.removeAcc(acm_id);
		
		if(flag) {
			msg="삭제가 정상적으로 완료되었습니다.";
		}else {
			msg="삭제가 정상적으로 처리되지 않았습니다.";
		}
		
		model.addAttribute("msg",msg);
		
		return "admin/acc/add_acc_result";
	}

}
