<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> <!-- fn 태그 라이브러리 추가 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제주어때 - 마이페이지 리뷰관리</title>

<!-- 부트스트랩 & jQuery -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style>
/* 간단 스타일 */
#main {
    width: 800px;
    margin: 80px auto; /* 가운데 정렬 */
    min-height: 600px;
}

.table-responsive {
    margin-top: 30px;
}

/* 페이지네이션 링크 스타일 */
#pagination a {
    text-decoration: none; /* 밑줄 제거 */
    color: inherit; /* 부모 요소 색상 상속 */
}

#pagination a:hover {
    text-decoration: underline; /* 호버 시 밑줄 표시 */
    color: inherit; /* 호버 시 색상 변경 없음 */
}
</style>

</head>
<body>

    <div id="wrap">
        <!-- header import -->
        <jsp:include page="../common/jsp/header.jsp" />

        <!-- sidebar import -->
        <jsp:include page="../common/jsp/mypage_sidebar.jsp" />

        <div id="main">
            <h5 class="fw-bold">리뷰 관리</h5>
            <p>내가 작성한 리뷰를 조회하고, 상세보기/수정을 진행할 수 있습니다.</p>

            <!-- 나의 리뷰 목록 -->
            <div class="table-responsive">
                <table class="table table-bordered text-center align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>번호</th>
                            <th>숙소명</th>
                            <th>별점</th>
                            <th>작성일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="review" items="${myReviewList}" varStatus="i">
                            <tr>
                                <td>${i.count}</td>
                                <td>${review.acm_name}</td>
                                <td>
                                    <c:forEach var="star" begin="1" end="${review.rating}">
                                        ★
                                    </c:forEach>
                                    <c:forEach var="star" begin="${review.rating + 1}" end="5">
                                        ☆
                                    </c:forEach>
                                </td>

                                <td>
                                    <fmt:formatDate value="${review.created_at}"
                                        pattern="yyyy-MM-dd" />
                                </td>

                                <td>
                                    <div class="btn-group">
                                        <!-- [상세/수정] : 모달 오픈 -->
                                        <button type="button"
                                            class="btn btn-primary btn-sm btn-open-modal"
                                            data-review-id="${review.review_id}"
                                            data-acm-name="${review.acm_name}"
                                            data-rating="${review.rating}"
                                            data-content="${review.content}"
                                            data-img="${fn:escapeXml(review.img_name)}"
                                            data-created="${review.created_at}" data-bs-toggle="modal"
                                            data-bs-target="#reviewModal">상세/수정</button>

                                        <!-- [삭제] : POST 방식 -->
                                        <form action="/mypage/removeReviewProcess" method="post"
                                            style="display: inline;"
                                            onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                            <input type="hidden" name="review_id"
                                                value="${review.review_id}" />
                                            <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- 리뷰가 없는 경우 -->
                        <c:if test="${empty myReviewList}">
                            <tr>
                                <td colspan="5">작성한 리뷰가 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <div class="d-flex justify-content-center mt-4" id="pagination">
                    <c:out value="${pagination}" escapeXml="false" />
                </div>
            </div>
        </div>


        <div id="footer">
            <jsp:include page="../common/jsp/footer.jsp" />
        </div>
    </div>


    <div class="modal fade" id="reviewModal" tabindex="-1"
        aria-labelledby="reviewModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg"> <!-- 이미지 다중 표시를 위해 modal-lg 사용 -->
            <div class="modal-content">

                <!-- 수정 처리 action -->
                <form id="frmReviewUpdate" method="post"
                    action="/mypage/modifyReviewProcess" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title" id="reviewModalLabel">리뷰 상세/수정</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <!-- 수정 시 식별자 -->
                        <input type="hidden" name="review_id" id="modal_review_id">

                        <!-- 숙소명 표시 (수정 시 변경 불가라면 readonly) -->
                        <div class="mb-3">
                            <label>숙소명</label> 
                            <input type="text" id="modal_acm_name"
                                class="form-control" name="acm_name" readonly>
                        </div>

                        <!-- 별점 예시 -->
                        <div class="mb-3">
                            <label>평점</label>
                            <!-- rating: hidden -->
                            <input type="hidden" name="rating" id="modal_rating">
                            <!-- 별 5개 -->
                            <div>
                                <span class="star" data-value="1">★</span> 
                                <span class="star" data-value="2">★</span> 
                                <span class="star" data-value="3">★</span>
                                <span class="star" data-value="4">★</span> 
                                <span class="star" data-value="5">★</span>
                            </div>
                        </div>

                        <!-- 리뷰 내용 -->
                        <div class="mb-3">
                            <label>내용</label>
                            <textarea class="form-control" name="content" id="modal_content"
                                rows="5"></textarea>
                        </div>

                        <!-- 기존 이미지 미리보기 -->
                        <div class="mb-3" id="oldImgWrap">
                            <img id="modal_old_img" alt="리뷰 이미지"
                                style="max-width: 150px; max-height: 150px; display: none;">
                        </div>

                        <!-- 이미지 수정 업로드 -->
                        <div class="mb-3">
                            <label>이미지 수정</label> 
                            <input type="file" class="form-control"
                                name="upfiles" accept="image/*" multiple id="newImageInput">
                        </div>
                        <!-- 새로운 이미지 미리보기 -->
                        <div id="newImagesPreview" class="d-flex flex-wrap mt-2">
                            <!-- 새로운 이미지 미리보기가 여기에 동적으로 추가됩니다 -->
                        </div>
                    </div>

                    <div class="modal-footer">
                        <!-- 닫기 -->
                        <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">닫기</button>
                        <!-- 수정 -->
                        <button type="button" class="btn btn-primary" id="btnUpdateReview">수정하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function() {

       // [별점 클릭 시] 동작
       $(".star").on("click", function() {
           var value = $(this).data("value");
           // 모든 별 초기화
           $(".star").removeClass("selected").css("color", "#ccc");
           // 선택한 별까지 색칠
           for (var i = 1; i <= value; i++) {
               $(".star[data-value='" + i + "']").addClass("selected").css("color", "#FFD700");
           }
           // hidden rating에 값 세팅
           $("#modal_rating").val(value);
       });

       // [수정하기] 버튼 클릭
       $("#btnUpdateReview").on("click", function() {
           // 간단 검증
           var rating = $("#modal_rating").val();
           var content = $("#modal_content").val();
           if (!rating || rating < 1) {
               alert("별점을 선택하세요.");
               return false;
           }
           if (!content || content.trim().length < 5) {
               alert("리뷰 내용을 5자 이상 입력해주세요.");
               return false;
           }
           // 폼 제출
           $("#frmReviewUpdate").submit();
       });

       // [상세/수정] 버튼 클릭 -> 모달 띄울 때 기존 데이터 세팅
       $(".btn-open-modal").on("click", function() {
           // 1) 별 초기화
           $(".star").removeClass("selected").css("color", "#ccc");
           $("#modal_rating").val("");

           // 2) data-* 속성에서 값 추출
           var reviewId = $(this).data("review-id");
           var acmName = $(this).data("acm-name");
           var rating = $(this).data("rating");
           var content = $(this).data("content");
           var img = $(this).data("img");
           var created = $(this).data("created");

           // 3) hidden / input / textarea에 값 세팅
           $("#modal_review_id").val(reviewId);
           $("#modal_acm_name").val(acmName);
           $("#modal_content").val(content);

           // 별점 채우기
           for (var i = 1; i <= rating; i++) {
               $(".star[data-value='" + i + "']").addClass("selected").css("color", "#FFD700");
           }
           $("#modal_rating").val(rating);

           // 이미지 처리 - 콤마로 구분된 문자열을 배열로 변환
           if (img) {
               var imgArray = img.split(',').map(function(item) {
                   return item.trim(); // 앞뒤 공백 제거
               });
               
               // 기존 이미지 미리보기 컨테이너 초기화
               $("#oldImgWrap").empty();
               
               // 각 이미지에 대해 미리보기 생성
               imgArray.forEach(function(imgName) {
                   if (imgName) {
                	   var imgHtml = '<div class="me-2 mb-2 d-inline-block">' +
                       '<img src="/common/user/review_Img/' + imgName + '" ' +
                       'alt="리뷰 이미지" ' +
                       'style="max-width: 150px; max-height: 150px;">' +
                       '</div>';
                       $("#oldImgWrap").append(imgHtml);
                   }
               });
           } else {
               $("#oldImgWrap").empty();
           }
       });

       // 새로운 이미지 선택 시 미리보기
       $("#newImageInput").on("change", function(event) {
           var input = event.target;
           
           // 파일 수 체크
           if (input.files.length > 3) {
               alert("최대 3개의 이미지만 업로드할 수 있습니다.");
               $(this).val(''); // 선택된 파일들 초기화
               $("#newImagesPreview").empty();
               return;
           }
           
           // 파일 크기 및 타입 체크
           var maxSize = 5 * 1024 * 1024; // 5MB
           var validImageTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
           
           for (var i = 0; i < input.files.length; i++) {
               var file = input.files[i];
               
               if (file.size > maxSize) {
                   alert("파일 크기는 5MB를 초과할 수 없습니다.");
                   $(this).val('');
                   $("#newImagesPreview").empty();
                   return;
               }
               
               if (!validImageTypes.includes(file.type)) {
                   alert("이미지 파일만 업로드할 수 있습니다.");
                   $(this).val('');
                   $("#newImagesPreview").empty();
                   return;
               }
           }
           
           // 미리보기 생성
           $("#newImagesPreview").empty();
           Array.from(input.files).forEach(function(file) {
               var reader = new FileReader();
               reader.onload = function(e) {
            	   var imgHtml = '<div class="me-2 mb-2 d-inline-block">' +
                   '<img src="' + e.target.result + '" ' +
                   'alt="새 리뷰 이미지" ' +
                   'style="width: 100px; height: 100px; object-fit: cover;">' +
                   '</div>';

                   $("#newImagesPreview").append(imgHtml);
               }
               reader.readAsDataURL(file);
           });
       });
    });
    </script>

</body>
</html>
