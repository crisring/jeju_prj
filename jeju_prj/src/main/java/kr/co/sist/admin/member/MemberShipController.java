package kr.co.sist.admin.member;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MemberShipController {
	
	@Autowired(required = false)
	private MemberShipService mss;
	
	@GetMapping("/admin/member_list")
	public String membershipList(String keyword, Model model) {
		List<MemberShipDomain> list = new ArrayList<MemberShipDomain>();
	    
	    // keyword null 체크 추가
	    if (keyword == null) {
	        keyword = "";  // 또는 적절한 기본값
	    }
	    
	    list = mss.searchAllMember(keyword);
	    
	    model.addAttribute("list", list);
	    model.addAttribute("keyword", keyword);  // 뷰에서 검색어 유지를 위해 추가
	    
	    return "admin/member/member_list";
	}//membershipList
	
	@GetMapping("/admin/member_detail")
	public String memberDetail(String user_id, Model model) {
		MemberShipDomain msDomain=new MemberShipDomain();
		
		msDomain=mss.searchOneMember(user_id);
		
		model.addAttribute("member", msDomain);
		
		return "admin/member/member_detail";
	}
	
	@PostMapping("/admin/update_member")
	public String modifyMember(MemberShipVO msVO, RedirectAttributes redirect) {
		try {
	        boolean result = mss.modifyMember(msVO);
	        
	        if(result) {
	            redirect.addFlashAttribute("message", "회원정보가 성공적으로 수정되었습니다.");
	        } else {
	            redirect.addFlashAttribute("message", "회원정보 수정에 실패했습니다.");
	        }
	        
	    } catch(Exception e) {
	        e.printStackTrace();
	        redirect.addFlashAttribute("message", "회원정보 수정 중 오류가 발생했습니다.");
	    }
	    
	    return "redirect:/admin/member_list";
	}
	
}
