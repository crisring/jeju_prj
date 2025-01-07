package kr.co.sist.user.review;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.sist.user.member.MemberDomain;
import kr.co.sist.user.mypage.ReviewVO;
import kr.co.sist.user.util.BoardUtil;
import kr.co.sist.user.util.SearchVO;

@SessionAttributes("user_info")
@Controller
public class UserReviewManageController {

    @Autowired
    private UserReviewManageService urService;

    @Autowired
    private BoardUtil bu;

    // 업로드 디렉토리 설정 (application.properties에서 주입)
    @Value("${file.upload.review-dir}")
    private String uploadDir;

    /**
     * [나의 리뷰 목록 보기]
     */
    @RequestMapping(value = "/mypage/reviewList", method = { RequestMethod.GET, RequestMethod.POST })
    public String reviewList(
            @SessionAttribute(name = "user_info", required = false) MemberDomain memberDomain,
            SearchVO sVO,
            HttpServletRequest request,
            Model model) {

        // 세션 유효성 검사
        if (memberDomain == null || memberDomain.getUser_id() == null) {
            return "redirect:/login/loginFrm";
        }

        // 페이징 및 조회 설정
        sVO.setUser_id(memberDomain.getUser_id());
        int totalCount = urService.totalCount(sVO);
        int pageScale = 8; // 한 화면에 보여줄 게시물 수
        int totalPage = (int) Math.ceil((double) totalCount / pageScale);
        String paramPage = request.getParameter("currentPage");
        int currentPage = (paramPage != null) ? Integer.parseInt(paramPage) : 1;
        int startNum = (currentPage - 1) * pageScale + 1;
        int endNum = startNum + pageScale - 1;

        sVO.setStartNum(startNum);
        sVO.setEndNum(endNum);
        sVO.setTotalPage(totalPage);
        sVO.setTotalCount(totalCount);
        sVO.setUrl("/mypage/reviewList");

        // 리뷰 목록 조회
        List<ReviewDomain> myReviewList = urService.searchAllReview(sVO);
        String pagination = bu.pagination(sVO);

        model.addAttribute("myReviewList", myReviewList);
        model.addAttribute("pagination", pagination);

        return "user/mypage/mypage_review";
    }

    /**
     * [리뷰 수정 처리]
     */
    @PostMapping("/mypage/modifyReviewProcess")
    public String modifyReviewProcess(
            ReviewVO rVO,
            @RequestParam(value = "upfiles", required = false) List<MultipartFile> upfiles,
            @RequestParam(value = "deleteImgNames", required = false) List<String> deleteImgNames,
            Model model) {
        try {
            // 리뷰 내용 수정
            boolean isUpdateSuccess = urService.modifyReview(rVO);
            if (!isUpdateSuccess) {
                model.addAttribute("errorMsg", "리뷰 수정에 실패했습니다.");
                return "user/mypage/mypage_review_modify";
            }

            // 기존 이미지 삭제
            if (deleteImgNames != null && !deleteImgNames.isEmpty()) {
                for (String imgName : deleteImgNames) {
                    // 경로에서 파일명만 추출
                    String fileName = imgName.substring(imgName.lastIndexOf("/") + 1);
                    // 파일 삭제
                    File imgFile = new File(uploadDir + File.separator + fileName);
                    if (imgFile.exists()) {
                        imgFile.delete();
                    }
                    // DB에서 이미지 정보 삭제
                    urService.deleteReviewImage(rVO.getReview_id(), fileName);
                }
            }

            // 새로운 이미지 업로드
            if (upfiles != null && !upfiles.isEmpty()) {
                for (MultipartFile upfile : upfiles) {
                    if (!upfile.isEmpty()) {
                        String originalFilename = upfile.getOriginalFilename();
                        if (originalFilename == null) continue;

                        // 현재 시간을 이용한 고유한 파일명 생성
                        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
                        String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
                        String newFileName = timeStamp + "_" + rVO.getReview_id() + fileExt;

                        // 파일 저장
                        File uploadFile = new File(uploadDir + File.separator + newFileName);

                        // 디렉토리 존재 여부 확인 및 생성
                        File dir = uploadFile.getParentFile();
                        if (!dir.exists()) {
                            dir.mkdirs();
                        }

                        // 파일 저장
                        upfile.transferTo(uploadFile);
                        
                        // DB에 저장할 때는 웹 경로 형식으로 저장
                        String webPath = newFileName; // 파일명만 저장
                        urService.addReviewImage(rVO.getReview_id(), webPath);
                    }
                }
            }

            return "redirect:/mypage/reviewList";

        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "파일 업로드 중 오류가 발생했습니다.");
            return "user/mypage/mypage_review_modify";
        }
    }

    /**
     * [리뷰 삭제 처리]
     */
    @PostMapping("/mypage/removeReviewProcess")
    public String removeReviewProcess(@RequestParam("review_id") int reviewId) {
        urService.removeReview(reviewId);
        return "redirect:/mypage/reviewList";
    }
}
