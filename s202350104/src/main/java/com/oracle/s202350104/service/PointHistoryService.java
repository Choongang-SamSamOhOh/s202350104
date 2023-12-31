package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.PointHistory;

public interface PointHistoryService {
	
	List<PointHistory>		listPointHistory();

	int 					deletePointHistory(Integer id);

	void                    writePointHistory(PointHistory pointhistory);
	
    List<PointHistory>		getPointHistoryByUserId(int user_id);

	List<PointHistory>      listPointHistorySortedByDateDesc(List<PointHistory> listPointHistory);

	List<PointHistory>      searchPointHistorylist(PointHistory pointhistory);

	int                     totalpointHistory();

	int                     conTotalPointHistory(PointHistory pointhistory);

	/* List<PointHistory> indexlistSearchPointHistory(PointHistory pointhistory); */

	List<PointHistory>      listPointHistory1(PointHistory pointhistory);
}
