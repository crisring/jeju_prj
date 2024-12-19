package kr.co.sist.admin.acc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.persistence.PersistenceException;

@Service
public class AccommodationService {

	@Autowired(required = false)
	private AccommodationDAO saDAO;

	/**
	 * 전체 숙소 조회(검색어가 있다면 검색된 숙소 검색)
	 * 
	 * @param saVO
	 * @return
	 */
	public List<AccommodationDomain> searchAllAcc(SearchAccVO sVO) {
		List<AccommodationDomain> list = null;

		int pageSize = 10;
		int startRow = (sVO.getCurrentPage() - 1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;

		sVO.setStartRow(startRow);
		sVO.setEndRow(endRow);

		try {
			list = saDAO.selectAllAcc(sVO);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch

		return list;
	}// searchAllAcc

	public int totalPages(SearchAccVO sVO) {
		int totalCount = 0;
		int tempNo = saDAO.getAccommodationCount(sVO);

		totalCount = (int) Math.ceil((double) tempNo / 10);

		return totalCount;
	}// totalPages

}
