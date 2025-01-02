package kr.co.sist.admin.member;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
	@GetMapping("/member/member_detail")
	public String memberDetail(String user_id, Model model) {
		MemberShipDomain msDomain=new MemberShipDomain();
		
		msDomain=mss.searchOneMember(user_id);
		
		model.addAttribute("member", msDomain);
		
		return "admin/member/member_detail";
	}
	
	
}
