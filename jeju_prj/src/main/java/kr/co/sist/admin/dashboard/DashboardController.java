package kr.co.sist.admin.dashboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpSession;

@Controller
@SessionAttributes("admin_id")
public class DashboardController {

	@Autowired
	DashboardService ds;

	@GetMapping("/admin/dashboard")
	public String adminMain(HttpSession session, Model model) {

		String admin_id = (String) session.getAttribute("admin_id");

		List<DashboardDomain> list = ds.calculateMonthlySales(admin_id);
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
