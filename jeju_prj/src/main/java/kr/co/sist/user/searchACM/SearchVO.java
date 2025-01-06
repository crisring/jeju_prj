package kr.co.sist.user.searchACM;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class SearchVO {

	private String keyWord;
	private Date startDate;
	private Date finishDate;
	private int numberPeople;

}
