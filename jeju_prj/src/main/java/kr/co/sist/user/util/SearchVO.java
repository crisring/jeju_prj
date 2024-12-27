package kr.co.sist.user.util;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SearchVO {

	private String keyWord; // 검색 값
	private Date startDate;
	private Date finishDate;
	private int numberPeople;

	// 검색 시작번호,끝번호, 현재페이지번호, 총 페이지수, 총게시물의 수
	private int startNum, endNum, currentPage, totalPage, totalCount;
	private String field = "0", url, user_id;// 검색할 field에 대응되는 숫자,이동할 URL

}
