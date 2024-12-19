package kr.co.sist.admin.acc;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchAccVO {

	private String acm_name;

	private int acm_type_id, startRow, endRow, currentPage;
}
