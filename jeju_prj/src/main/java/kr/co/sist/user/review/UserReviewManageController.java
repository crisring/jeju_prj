/*
 * package kr.co.sist.user.review;
 * 
 * import java.net.http.HttpRequest; import java.util.List;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; // 파라미터 받을
 * 때 @RequestParam 등 사용 가능 import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.SessionAttribute; import
 * org.springframework.web.bind.annotation.SessionAttributes;
 * 
 * import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
 * import jakarta.servlet.http.HttpServletRequest; import
 * kr.co.sist.admin.review.ReviewManageDomain; import
 * kr.co.sist.user.ACMdetail.ReviewDomain; import
 * kr.co.sist.user.member.MemberDomain; import kr.co.sist.user.mypage.ReviewVO;
 * import kr.co.sist.user.util.BoardUtil; import kr.co.sist.user.util.SearchVO;
 * 
 * @SessionAttributes("user_info")
 * 
 * @Controller public class UserReviewManageController {
 * 
 * @Autowired private UserReviewManageService urService;
 * 
 * 
 * 
 * @Autowired BoardUtil bu;
 * 
 * 
 *//**
	 * 1) 나의 리뷰 목록 보기 - 세션에서 user_id를 가져왔다고 가정
	 */
/*
 * @RequestMapping(value = "/mypage/reviewList", method = { RequestMethod.GET,
 * RequestMethod.POST }) public String reviewList(@SessionAttribute(name =
 * "user_info", required = false) MemberDomain memberDomain,SearchVO sVO,
 * HttpServletRequest request, Model model) { // 세션이 없거나 user_id가 없으면 로그인 필요 예외
 * 처리 if (memberDomain == null || memberDomain.getUser_id() == null) { throw new
 * IllegalArgumentException("로그인이 필요합니다. 세션에 user_id가 존재하지 않습니다."); } // end if
 * 
 * 
 * sVO.setUser_id(memberDomain.getUser_id());
 * 
 * // 1. 총 레코드 수 구하기 int totalCount = urService.totalCount(sVO);
 * 
 * // 2. 한 화면에 보여줄 레코드의 수 int pageScale = urService.pageScale();
 * 
 * // 3. 총 페이지 수 int totalPage = urService.totalPage(totalCount, pageScale);
 * 
 * // 4. 현재 페이지 구하기 String paramPage = request.getParameter("currentPage"); int
 * currentPage = urService.currentPage(paramPage);
 * 
 * // 5. 시작 번호 및 끝 번호 계산 int startNum = urService.startNum(currentPage,
 * pageScale); int endNum = urService.endNum(startNum, pageScale);
 * 
 * // SearchVO에 페이지 및 범위 정보 세팅 sVO.setCurrentPage(currentPage);
 * sVO.setStartNum(startNum); sVO.setEndNum(endNum);
 * sVO.setTotalPage(totalPage); sVO.setTotalCount(totalCount);
 * 
 * // 7. 페이지네이션 생성 sVO.setUrl("/mypage/review_list"); List<ReviewDomain>
 * myReviewList = urService.searchAllReview(sVO);
 * 
 * String pagination = bu.pagination(sVO); model.addAttribute("pagination",
 * pagination);
 * 
 * 
 * 
 * 
 * // JSP에서 반복문으로 활용할 수 있도록 Model에 담기 model.addAttribute("myReviewList",
 * myReviewList);
 * 
 * // 예: /WEB-INF/views/user/mypage/mypage_review.jsp로 이동 return
 * "user/mypage/mypage_review"; }// reviewList
 * 
 *//**
	 * 3) 리뷰 수정 처리 - 수정 폼에서 POST로 받은 데이터를 DB에 반영
	 */
/*
 * @PostMapping("/mypage/modifyReviewProcess") public String
 * modifyReviewProcess(ReviewVO rVO, Model model) { // 실제 DB update 처리 boolean
 * isSuccess = urService.modifyReview(rVO);
 * 
 * // 성공/실패 여부에 따라 메시지나 이동 경로 설정 if (isSuccess) { // 예: 성공 시 내 리뷰 목록 페이지로 이동
 * return "redirect:/mypage/reviewList"; } else { // 예: 실패 시 폼으로 다시
 * model.addAttribute("errorMsg", "리뷰 수정에 실패했습니다."); return
 * "user/mypage/mypage_review_modify"; } }
 * 
 *//**
	 * 4) 리뷰 삭제 처리
	 *//*
		 * @PostMapping("/mypage/removeReviewProcess") public String
		 * removeReviewProcess(@RequestParam("review_id") int reviewId) { boolean
		 * isSuccess = urService.removeReview(reviewId);
		 * 
		 * // 삭제 후 목록 페이지로 리다이렉트 return "redirect:/mypage/reviewList"; }
		 * 
		 * }// class
		 */



package kr.co.sist.user.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.mypage.ReviewVO;
import kr.co.sist.user.util.BoardUtil;
import kr.co.sist.user.util.SearchVO;

/**
 *  세션 속성 "user_info"를 통해 user_id를 가져온다고 가정
 */
@SessionAttributes("user_info")
@Controller
public class UserReviewManageController {

    @Autowired
    private UserReviewManageService urService;

    @Autowired
    private BoardUtil bu;

    /**
     * 1) [나의 리뷰 목록 보기]
     * - 세션에서 user_id를 가져와 페이징 처리된 리뷰 목록을 조회
     */
    @RequestMapping(value = "/mypage/reviewList", method = {RequestMethod.GET, RequestMethod.POST})
    public String reviewList(
            @SessionAttribute(name = "user_info", required = false) MemberDomain memberDomain,
            SearchVO sVO,
            HttpServletRequest request,
            Model model) {

        // 1. 세션 유효성 검사
        if (memberDomain == null || memberDomain.getUser_id() == null) {
            throw new IllegalArgumentException("로그인이 필요합니다. 세션에 user_id가 존재하지 않습니다.");
        }

        // 2. SearchVO에 user_id 세팅
        sVO.setUser_id(memberDomain.getUser_id());

        // 3. 총 게시물 수 (DB에서 계산)
        int totalCount = urService.totalCount(sVO);

        // 4. 한 화면에 보여줄 게시물 수
        int pageScale = urService.pageScale();

        // 5. 전체 페이지 수
        int totalPage = urService.totalPage(totalCount, pageScale);

        // 6. 현재 페이지 번호 파라미터 처리
        String paramPage = request.getParameter("currentPage");
        int currentPage = urService.currentPage(paramPage);

        // 7. 시작 번호, 끝 번호 계산
        int startNum = urService.startNum(currentPage, pageScale);
        int endNum = urService.endNum(startNum, pageScale);

        // 8. SearchVO에 페이징 정보 세팅
        sVO.setCurrentPage(currentPage);
        sVO.setStartNum(startNum);
        sVO.setEndNum(endNum);
        sVO.setTotalPage(totalPage);
        sVO.setTotalCount(totalCount);

        System.out.println("totalCount = " + totalCount);
        System.out.println("totalPage = " + totalPage);
        System.out.println("currentPage = " + currentPage);
        
        
        
        
        // 9. 페이지네이션 URL 설정
        //    Controller 매핑 주소와 동일하게 "/mypage/reviewList" 사용
        sVO.setUrl("/mypage/reviewList");

        // 10. 리뷰 목록 조회 (페이징 적용)
        List<ReviewDomain> myReviewList = urService.searchAllReview(sVO);

        // 11. 페이지네이션 HTML 생성
        String pagination = bu.pagination(sVO);
        System.out.println(pagination);
        System.out.println("pagination = " + pagination);

        // 12. Model에 결과 담기
        model.addAttribute("myReviewList", myReviewList);
        model.addAttribute("pagination", pagination);

        // 13. 뷰(JSP) 반환
        return "user/mypage/mypage_review";
    }

    /**
     * 3) [리뷰 수정 처리]
     * - 수정 폼에서 POST로 받은 데이터를 DB에 반영
     */
    @PostMapping("/mypage/modifyReviewProcess")
    public String modifyReviewProcess(ReviewVO rVO, Model model) {
        boolean isSuccess = urService.modifyReview(rVO);
        if (isSuccess) {
            return "redirect:/mypage/reviewList";
        } else {
            model.addAttribute("errorMsg", "리뷰 수정에 실패했습니다.");
            return "user/mypage/mypage_review_modify";
        }
    }

    /**
     * 4) [리뷰 삭제 처리]
     */
    @PostMapping("/mypage/removeReviewProcess")
    public String removeReviewProcess(@RequestParam("review_id") int reviewId) {
        boolean isSuccess = urService.removeReview(reviewId);
        // 삭제 후 목록 페이지 리다이렉트
        return "redirect:/mypage/reviewList";
    }

}
