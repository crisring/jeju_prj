package kr.co.sist.user.util;

import org.springframework.stereotype.Component;

@Component
public class BoardUtil {

	/**
	 * 페이지네이션을 사용하면 매개변수로 입력객체되는 객체의 currentPage번호,totalPage 수,totalCount 수 검색을 수행하면
	 * field 값,keyword,url이 반드시 입력되어야 합니다.
	 * 
	 * @param sVO
	 * @return
	 */
	public String pagination(SearchVO sVO) {
		StringBuilder pagination = new StringBuilder();

		if (sVO.getTotalCount() != 0) {
			// 1.한 화면에 보여줄 페이지 인덱스 수 [1][2][3]
			int pageNumber = 3;
			// 2.화면에 보여줄 시작페이지 번호 ( 1,2,3 -> 1, 4,5,6 ->4, 7,8,9 -> 7)
			int startPage = ((sVO.getCurrentPage() - 1) / pageNumber) * pageNumber + 1;
			// 3.화면에 보여줄 마지막페이지 번호
			int endPage = startPage + pageNumber - 1;
			// 4. 총 페이지 수가 연산된 마지막 페이지 수보다 작다면 총 페이지수가 마지막 페이지수로 설정
			if (sVO.getTotalPage() <= endPage) {
				endPage = sVO.getTotalPage();
			} // end
				// 5.첫 페이지가 인덱스화면이 아닌경우 (3보다 큰 경우)
			int movePage = 0;
			StringBuilder prevMark = new StringBuilder();
			prevMark.append("[ &lt;&lt; ]");

			if (sVO.getCurrentPage() > pageNumber) {// 현재 페이지가 pagination의 수 보다 크면
				prevMark.delete(0, prevMark.length());
				// 이전으로 가기 링크를 만들어 준다.
				movePage = startPage - 1;// 4,5,6->1, 7,8,9 -> 4
				prevMark.append("[ <a href=\"").append(sVO.getUrl()).append("?currentPage=").append(movePage);
				// 검색 키워드가 존재할 때

				if (sVO.getKeyWord() != null && !"".equals(sVO.getKeyWord())) {

					prevMark.append("&field=").append(sVO.getField()).append("&keyword=").append(sVO.getKeyWord());
				} // end if

				prevMark.append("\">&lt;&lt;</a> ]");
			} // end if
			prevMark.append(" ... ");

			pagination.append(prevMark);

			movePage = startPage;
			StringBuilder pageLink = new StringBuilder();

			while (movePage <= endPage) {
				if (movePage == sVO.getCurrentPage()) {// 현재 페이지는 링크를 설정하지 않는다.

					pageLink.append("[ ").append(movePage).append(" ]");

				} else {// 현재페이지가 아니면 링크를 설정한다.
					pageLink.append("[ <a href='").append(sVO.getUrl()).append("?currentPage=").append(movePage);

					// 검색 키워드가 존재할 때
					if (sVO.getKeyWord() != null && !"".equals(sVO.getKeyWord())) {
						pageLink.append("&field=").append(sVO.getField()).append("&keyword=").append(sVO.getKeyWord());
					} // end if

					pageLink.append("'>").append(movePage).append("</a> ]");

				} // end else
				movePage++;
			} // end while

			pagination.append(pageLink);
			pagination.append(" ... ");

			// 7.뒤에 페이지가 더 있는 경우
			StringBuilder nextMark = new StringBuilder();
			nextMark.append("[ &gt;&gt; ]");

			if (sVO.getTotalPage() > endPage) {

				nextMark.delete(0, nextMark.length());
				movePage = endPage + 1;

				nextMark.append("[ <a href='").append(sVO.getUrl()).append("?currentPage=").append(movePage);

				// 검색 키워드가 존재할 때
				if (sVO.getKeyWord() != null && !"".equals(sVO.getKeyWord())) {
					nextMark.append("&field=").append(sVO.getField()).append("&keyword=").append(sVO.getKeyWord());
				} // end if

				nextMark.append("'> &gt;&gt;</a> ]");
			} // end if

			pagination.append(nextMark);

		} // end if

		return pagination.toString();
	}
// pagination

}// class
