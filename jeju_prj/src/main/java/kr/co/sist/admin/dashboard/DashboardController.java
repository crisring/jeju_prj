package kr.co.sist.admin.dashboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

	@Autowired
	DashboardService ds;

	@GetMapping("/admin/dashboard")
	public String adminMain(Model model) {

		List<DashboardDomain> list = ds.calculateMonthlySales();
		model.addAttribute("monthlyList", list);

		List<DashboardDomain> list2 = ds.calculateWeeklySales();
		model.addAttribute("weeklyList", list2);

		List<DashboardDomain> list3 = ds.calculateACCTypeSales();
		model.addAttribute("ACCTypeList", list3);

		DashboardDomain dd = ds.calculateCancelRate();
		model.addAttribute("cancelRate", dd);

		DashboardDomain dd2 = ds.searchMemberCount();
		model.addAttribute("memberCnt", dd2);

		List<DashboardDomain> list4 = ds.calculatePopularACM();
		model.addAttribute("popularACM", list4);

		return "admin_index";
	}// adminMain

}
