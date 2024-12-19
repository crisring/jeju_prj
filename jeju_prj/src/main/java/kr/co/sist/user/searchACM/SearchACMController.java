package kr.co.sist.user.searchACM;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

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
	public String main(Model model) {

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
	public String searchProc(SearchVO sVO, Model model) {

		return "user/acm/searchProcess";
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

		return "/acm/acmDetail";
	}// main

}
