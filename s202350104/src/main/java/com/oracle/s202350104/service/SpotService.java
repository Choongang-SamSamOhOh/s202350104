package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

public interface SpotService {

	List<SpotContent> listSpot(SpotContent spotContent); //  전체조회
	SpotContent       detailSpot(int contentId);
	int               insertSpot(SpotContent spotContent);
	int               updateSpot(SpotContent spot);
	int               deletespot(SpotContent spot);
	int               approveSpot(SpotContent spot);
	List<SpotContent> listSpot3(SpotContent spotContent);// 테마별 조회
	int               totalSearchSpot(SpotContent spotContent);
	

}
