package kr.co.sist.admin.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.util.BoardUtil;
import kr.co.sist.user.util.SearchVO;

@Controller
@SessionAttributes("admin_id")
public class ReviewManageController {

	@Autowired
	ReviewManageService rms;

	@Autowired
	BoardUtil bu;

	@GetMapping("/admin/review_list")
	public String reviewList(SearchVO sVO, HttpServletRequest request, HttpSession session, Model model) {

		String admin_id = (String) session.getAttribute("admin_id");
		sVO.setAdmin_id(admin_id);

		// 1. 총 레코드 수 구하기
		int totalCount = rms.totalCount(sVO);

		// 2. 한 화면에 보여줄 레코드의 수
		int pageScale = rms.pageScale();

		// 3. 총 페이지 수
		int totalPage = rms.totalPage(totalCount, pageScale);

		// 4. 현재 페이지 구하기
		String paramPage = request.getParameter("currentPage");
		int currentPage = rms.currentPage(paramPage);

		// 5. 시작 번호 및 끝 번호 계산
		int startNum = rms.startNum(currentPage, pageScale);
		int endNum = rms.endNum(startNum, pageScale);

		// SearchVO에 페이지 및 범위 정보 세팅
		sVO.setCurrentPage(currentPage);
		sVO.setStartNum(startNum);
		sVO.setEndNum(endNum);
		sVO.setTotalPage(totalPage);
		sVO.setTotalCount(totalCount);

		// 6. 예약 목록 조회 (페이지네이션을 적용한 데이터 조회)
		List<ReviewManageDomain> list = rms.searchAllReview(sVO);
		model.addAttribute("reviewList", list);

		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pageScale", pageScale);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", currentPage);

		// 7. 페이지네이션 생성
		sVO.setUrl("/admin/review_list");
		String pagination = bu.pagination(sVO);
		model.addAttribute("pagination", pagination);

		return "admin/review/review_list";
	}// reviewList

	@GetMapping("/admin/review_detail/{review_id}")
	public String reviewDetail(@PathVariable("review_id") int review_id, Model model) {

		ReviewManageDomain rmd = rms.searchOneReview(review_id);

		if (rmd != null) {
			rmd.setReview_id(review_id);
		}

		model.addAttribute("review", rmd);

		return "admin/review/review_detail";
	}// reviewDetail
}
