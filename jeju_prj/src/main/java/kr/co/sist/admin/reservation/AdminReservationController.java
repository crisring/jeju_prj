package kr.co.sist.admin.reservation;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.sist.admin.member.MemberShipDomain;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@SessionAttributes("admin_id")
@Controller
public class AdminReservationController {
	
	@Autowired(required = false)
	private AdminReservationService ars;
	
	@RequestMapping(value="/admin/res_list", method= {GET,POST})
	public String resList(String keyword, @SessionAttribute("admin_id") String admin_id, Model model) {
		List<AdminReservationDomain> list=new ArrayList<AdminReservationDomain>();
		SearchResVO srVO = new SearchResVO();
	    srVO.setAdmin_id(admin_id);
	    srVO.setKeyword(keyword);
	    
	    System.out.println(srVO.getAdmin_id());
	    
		list=ars.searchAllRes(srVO);
		
		model.addAttribute("resList", list);
		model.addAttribute("keyword",keyword);
			
		
		return "admin/reservation/reservation_list";
	}//resList
	
	@GetMapping("/admin/res_detail")
	public String resDetail(int rsr_id, Model model) {
		AdminReservationDomain arDomain=new AdminReservationDomain();
		
		arDomain=ars.searchOneRes(rsr_id);
		
		model.addAttribute("res",arDomain);
		
		return "admin/reservation/reservation_detail";
	}//resDetail
	
	@PostMapping("/admin/delete_res")
	public String deleteReservation(int rsr_id, Model model) {
		
		String msg="예약이 삭제되지 않았습니다.";
		boolean flag=false;
		
		try {
			
			flag=ars.removeRes(rsr_id);
			
		}catch(Exception e) {
			e.printStackTrace();
			msg="문제발생";
		}//end catch
		
		
		if(flag) {
			msg="예약 삭제가 완료되었습니다.";
		}

		model.addAttribute("msg",msg);
		
	    return "admin/reservation/res_result"; 
	}
	
	@PostMapping("/admin/update_res_status")
	public String updateReservationStatus(@RequestParam("rsr_id") int[] rsrIds, 
	                                    @RequestParam("rsr_status") String[] rsrStatuses,
	                                    Model model) {
		boolean flag=false;
		String msg="변경이 실패하였습니다";
		try {
			
		    // rsrIds와 rsrStatuses는 같은 인덱스끼리 매칭됨
		    List<AdminReservationVO> updateList = new ArrayList<>();
		    
		    for(int i = 0; i < rsrIds.length; i++) {
		        AdminReservationVO vo = new AdminReservationVO();
		        vo.setRsr_id(rsrIds[i]);
		        vo.setRsr_status(rsrStatuses[i]);
		        updateList.add(vo);
		    }
		    
		    flag=ars.modifyRes(updateList);
		    
		    if(flag) {
		    	msg="변경이 완료되었습니다.";
		    }
		}catch(Exception e) {
			e.printStackTrace();
			msg="문제발생";
		}
	    
		model.addAttribute("msg",msg);
	    
	    return "admin/reservation/res_result";
	}
	
	
}
