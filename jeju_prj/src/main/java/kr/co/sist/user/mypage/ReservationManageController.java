package kr.co.sist.user.mypage;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.sist.user.member.MemberVO;
import kr.co.sist.user.util.BoardUtil;
import kr.co.sist.user.util.SearchVO;

@SessionAttributes("user_info")
@Controller
public class ReservationManageController {

	@Autowired
	private ReservationManageService rsrms;

	@Autowired
	private BoardUtil bu;

	/**
	 * 나의 예약 리스트
	 * 
	 * @return
	 */
	@RequestMapping(value = "/mypage/rerListFrm", method = { GET, POST })
	public String rsrListFrm(HttpSession session, SearchVO sVO, HttpServletRequest request, Model model) {

		// 세션에서 값을 가져오기
		MemberVO mVO = (MemberVO) session.getAttribute("user_info");
		model.addAttribute("user_info", mVO);

		if (mVO == null) {
			return "user/mypage/mypage_reservation_error";
		}

		String user_id = mVO.getUser_id();

		// 1. 총 레코드 수 구하기
		int totalCount = rsrms.totalCount(user_id);

		// 2. 한 화면에 보여줄 레코드의 수
		int pageScale = rsrms.pageScale();

		// 3. 총 페이지 수
		int totalPage = rsrms.totalPage(totalCount, pageScale);

		// 4. 현재 페이지 구하기
		String paramPage = request.getParameter("currentPage");
		int currentPage = rsrms.currentPage(paramPage);

		// 5. 시작 번호 및 끝 번호 계산
		int startNum = rsrms.startNum(currentPage, pageScale);
		int endNum = rsrms.endNum(startNum, pageScale);

		// SearchVO에 페이지 및 범위 정보 세팅
		sVO.setCurrentPage(currentPage);
		sVO.setStartNum(startNum);
		sVO.setEndNum(endNum);
		sVO.setTotalPage(totalPage);
		sVO.setTotalCount(totalCount);
		sVO.setUser_id(user_id);

		// 6. 예약 목록 조회 (페이지네이션을 적용한 데이터 조회)
		List<ReservationDomain> rsrList = rsrms.displayAllReservation(user_id);
		List<ReservationDomain> rsrList2 = rsrms.displayAllReservation2(sVO);

		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pageScale", pageScale);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("currentPage", currentPage);

		// 7. 페이지네이션 생성
		sVO.setUrl("/mypage/rerListFrm");
		String pagination = bu.pagination(sVO);
		model.addAttribute("pagination", pagination);

		// 8. 예약 목록 및 페이징 정보 모델에 전달
		model.addAttribute("rsrList", rsrList);
		model.addAttribute("rsrList2", rsrList2);

		return "user/mypage/mypage_reservation";
	}// rsrListFrm

	// 리뷰가 먼저 추가되고 -> 리뷰 아이디 받아서 번호 추가
	private String uploadDir = "C:/Users/crisring/git/jeju_prj/jeju_prj/src/main/resources/static/common/user/review_Img";

	@PostMapping("/mypage/ReviewWriteProcess")
	public String reviewWriteProc(@RequestParam("upfile") MultipartFile[] mf, @RequestParam("rsr_id") int rsrId,
			@RequestParam("content") String content, @RequestParam("user_id") String userId,
			@RequestParam("rating") int rating, @RequestParam("acm_id") int acm_id, Model model) throws Exception {

		// 파일 크기 제한 (5MB 이하)
		int maxSize = 1024 * 1024 * 5;
		for (MultipartFile file : mf) {
			if (maxSize < file.getSize()) {
				model.addAttribute("msg", "업로드 실패하였습니다! 업로드 파일의 크기는 최대 5MB까지만 가능합니다.");
				return "forward:/mypage/rerListFrm";
			}
		}

		List<String> fileNames = new ArrayList<>();

		for (MultipartFile file : mf) {
			String originalFilename = file.getOriginalFilename();

			// 파일명과 확장자 분리
			String fileName = originalFilename;
			String fileExt = "";

			if (originalFilename != null && originalFilename.contains(".")) {
				int lastDotIndex = originalFilename.lastIndexOf(".");
				fileExt = originalFilename.substring(lastDotIndex);
				fileName = originalFilename.substring(0, lastDotIndex);
			}

			// 중복 파일명 처리
			int cnt = 1;
			String finalFileName = fileName + fileExt;
			File uploadFile = new File(uploadDir + "/" + finalFileName);

			while (uploadFile.exists()) {
				finalFileName = fileName + "_" + cnt + fileExt;
				uploadFile = new File(uploadDir + "/" + finalFileName);
				cnt++;
			}

			// 파일 업로드 수행
			file.transferTo(uploadFile);

			// 최종 파일명(확장자 포함)을 리스트에 추가
			fileNames.add(finalFileName);
		}

		ReviewVO rVO = new ReviewVO();
		rVO.setRsr_id(rsrId);
		rVO.setContent(content);
		rVO.setUser_id(userId);
		rVO.setRating(rating);
		rVO.setAcm_id(acm_id);
		rVO.setImg_names(fileNames.toArray(new String[0]));

		boolean flag = rsrms.addReview(rVO);

		if (!flag) {
			model.addAttribute("msg", "리뷰 등록에 실패하였습니다!");
		} else {
			model.addAttribute("msg", "리뷰가 성공적으로 등록되었습니다!");
		}

		return "user/mypage/reviewProcess";
	}// reviewWriteProc

}
