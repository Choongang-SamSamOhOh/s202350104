package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.ContentsDao;
import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Service
@RequiredArgsConstructor
@Slf4j
public class ContentServiceImpl implements ContentSerivce {
	
	private final ContentsDao contentsDao;
	
	@Override
	public List<Contents> listContents() {
		log.info("ContentServiceImpl listContents start...");
		List<Contents> listContents = contentsDao.listContent();
		return listContents;
	}

	@Override
	public List<Contents> getSearchContentsList(Contents contents ) {
		List<Contents> listContents = contentsDao.getSearchContentsList(contents);
		return listContents;
	}

	@Override
	public int getTotalSearchCount(Contents contents) {
		return contentsDao.getTotalSearchCount(contents);
	}

}
