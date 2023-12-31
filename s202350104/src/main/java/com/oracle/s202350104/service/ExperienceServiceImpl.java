package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.ExperienceDao;
import com.oracle.s202350104.model.ExperienceContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ExperienceServiceImpl implements ExperienceService {

	private final ExperienceDao ed;
	
	@Override
	public List<ExperienceContent> listExperience(ExperienceContent experience) {
		List<ExperienceContent> listExperience = ed.listExperience(experience);
		return listExperience;
	}

	@Override
	public ExperienceContent detailExperience(int contentId) {
		ExperienceContent experience = ed.detailExperience(contentId);
		return experience;
	}

	@Override
	public int totalExperience() {
		int totalExperienceCnt = ed.totalExperience();
		return totalExperienceCnt;
	}

	@Override
	public int experienceDelete(int contentId) {
		int experienceDelete = 0;
		experienceDelete = ed.experienceDelete(contentId);
		
		return experienceDelete;
	}
	
	@Override
	public int totalSearchExperience(ExperienceContent experience) {
		int totalSearchExperience = ed.totalSearchExperience(experience);
		return totalSearchExperience;
	}

	@Override
	public List<ExperienceContent> listSearchExperience(ExperienceContent experience) {
		List<ExperienceContent> listSearchExperience = ed.listSearchExperience(experience);
		return listSearchExperience;
	}

	@Override
	public List<ExperienceContent> listSmallCode(ExperienceContent experience) {
		List<ExperienceContent> listSmallCode = ed.listSmallCode(experience);
		return listSmallCode;
	}

	@Override
	public int experienceRestore(int contentId) {
		int experienceRestore = 0;
		experienceRestore = ed.experienceRestore(contentId);
		return experienceRestore;
	}

	@Override
	public int experienceUpdate(ExperienceContent experienceContent) {
		int experienceUpdate = 0;
		experienceUpdate = ed.experienceUpdate(experienceContent);
		return experienceUpdate;
	}

	@Override
	public int experienceApprove(ExperienceContent experienceContent) {
		int result = ed.experienceApprove(experienceContent);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 승인에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public int insertExperience(ExperienceContent experience) {
		int insertExperience = ed.insertExperience(experience);
		return insertExperience;
	}

	@Override
	public int mainTotalExperience() {
		int mainTotalExperience = 0;
		mainTotalExperience =ed.mainTotalExperience();
		return mainTotalExperience;
	}

	@Override
	public int totalMainSearchExperience(ExperienceContent experience) {
		int totalMainSearchExperience = 0;
		totalMainSearchExperience = ed.totalMainSearchExperience(experience);
		return totalMainSearchExperience;
	}

	@Override
	public List<ExperienceContent> listMainSearchExperience(ExperienceContent experience) {
		List<ExperienceContent> listMainSearchExperience = null;
		listMainSearchExperience = ed.listMainSearchExperience(experience);
		return listMainSearchExperience;
	}
}	
