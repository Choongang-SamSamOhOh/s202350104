package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.AccomodationDao;
import com.oracle.s202350104.model.AccomodationContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AccomodationServiceImpl implements AccomodationService {
	
	private final AccomodationDao ad;

	@Override
	public List<AccomodationContent> listAccomodation(AccomodationContent accomodation) {
		
		List<AccomodationContent> listAccomodation = ad.listAccomodation(accomodation);
		
		if(listAccomodation==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 리스트가 존재하지 않습니다");
		}
		
		return listAccomodation;
	}

	@Override
	public AccomodationContent detailAccomodation(int contentId) {
		AccomodationContent accomodation = ad.detailAccomodation(contentId);
		log.info("AccomodationsImpl detailAccomodation Strart...");
		if(accomodation==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 정보가 존재하지 않습니다");
		}
		
		return accomodation;
	}

	@Override
	public int totalAccomodation() {
		int totalAccomodation = 0;
		totalAccomodation = ad.totalAccomodation();
		return totalAccomodation;
	}

}