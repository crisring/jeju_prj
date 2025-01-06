package kr.co.sist.user.searchACM;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.ACMdetail.ACMDomain;

@SessionAttributes("user_info")
@Controller
public class SearchACMController {

	@Autowired
	private SearchACMService sacms;

	/**
	 * 메인 페이지 이동
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/", method = { GET, POST })
	public String main(HttpSession session, Model model) {

		model.addAttribute("user_info", session.getAttribute("user_info"));

		List<SearchACMDomain> list = null;

		// 1.호텔, 2. 펜션 풀빌라, 3. 게하 한옥, 4. 캠핑 글램핑, 5. 홈 빌라
		for (int i = 1; i < 6; i++) {
			list = sacms.displayPopularTypes(i);
			model.addAttribute("list" + i, list);
		}
		return "index";
	}// main

	/**
	 * 숙소 검색
	 * 
	 * @param sVO
	 * @param model
	 * @return
	 */
	@GetMapping("/acm/searchProcess")
	public String searchProc(SearchVO sVO, RedirectAttributes redirectAttributes, Model model) {

		redirectAttributes.addAttribute("room_id", 44);
		redirectAttributes.addAttribute("startDate", sVO.getStartDate());
		redirectAttributes.addAttribute("finishDate", sVO.getFinishDate());
		redirectAttributes.addAttribute("numberPeople", sVO.getNumberPeople());

		return "redirect:/reservation";
	}// searchProc

	/**
	 * 상세 검색 페이지
	 * 
	 * @param sVO
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/acm/searchDetailFrm", method = { GET, POST })
	public String searchDetailFrm(SearchVO sVO, Model model) {
	    // 서비스에서 검색 결과를 가져옴
	    List<SearchACMDomain> searchResults = sacms.displayDetail(sVO);  // displayDetail 메서드 호출

	    // SearchACMDomain을 ACMTypeDomain으로 변환
	    List<ACMTypeDomain> acmTypeResults = new ArrayList<>();
	    for (SearchACMDomain search : searchResults) {
	        ACMTypeDomain acmType = new ACMTypeDomain();
	        
	        // SearchACMDomain에서 필요한 정보를 가져와서 ACMTypeDomain에 설정
	        acmType.setAcm_type_id(search.getAcm_type_id());  // 예: 숙소 타입 ID
	        acmType.setAcm_type(search.getAcm_name());  // 예: 숙소 이름
	        
	        acmTypeResults.add(acmType);
	    }

	    // 변환된 검색 결과를 모델에 추가
	    model.addAttribute("searchResults", acmTypeResults);

	    return "/acm/acmDetail";  // 결과 페이지로 이동
	}

}
