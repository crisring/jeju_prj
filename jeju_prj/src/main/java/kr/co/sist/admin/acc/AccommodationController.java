package kr.co.sist.admin.acc;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AccommodationController {

	@Autowired(required = false)
	private AccommodationService as;

	@RequestMapping(value = "/admin", method = { GET, POST })
	public String main() {

		return "admin_index";
	}// main

	@GetMapping("/admin/searchACM")
	public String searchProcess(SearchAccVO sVO, @RequestParam(defaultValue = "1") int page, Model model) {
		sVO.setCurrentPage(page);
		List<AccommodationDomain> list = as.searchAllAcc(sVO);
		int totalPages = as.totalPages(sVO);
		model.addAttribute("data", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);

		return "admin/acc/acc_list";
	}// searchProcess

}
