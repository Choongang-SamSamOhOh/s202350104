package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Tags;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class TagsDaoImpl implements TagsDao {
	
	private final SqlSession session;

	@Override
	public int totalTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}
	
	@Override
	public List<Tags> listTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhTagsListPage", tags);
			log.info("TagsDaoImpl listTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalUserTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhUserTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalUserTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listUserTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhUserTagsAll", tags);
			log.info("TagsDaoImpl listUserTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listUserTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalBoardTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhBoardTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalBoardTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listBoardTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhBoardTagsListPage", tags);
			log.info("TagsDaoImpl listBoardTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listBoardTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalContentTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhContentTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalContentTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listContentTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagsListPage", tags);
			log.info("TagsDaoImpl listContentTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listContentTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> listTagsAll() {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhTagsListAll");
			log.info("TagsDaoImpl listTagsAll() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listTagsAll() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int insertTags(Tags tags) {
		int result = 0;
		try {
			result = session.insert("nhTagsInsert", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl insertTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public Tags selectTags(int id) {
		Tags tags = null;
		try {
			tags = session.selectOne("nhTagsSelect", id);
			log.info("TagsDaoImpl selectTags() => " + tags.getName());
		} catch(Exception e) {
			log.info("TagsDaoImpl selectTags() => " + e.getMessage());
		}
		return tags;
	}

	@Override
	public int updateTags(Tags tags) {
		int result = 0;
		try {
			result = session.update("nhTagsUpdate", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl insertTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteTags(int id) {
		int result = 0;
		try {
			session.delete("nhUserTagsDelete", id);
			session.delete("nhContentTagsDelete", id);
			session.delete("nhBoardTagsDelete", id);
			result = session.delete("nhTagsDelete", id);
		} catch(Exception e) {
			log.info("TagsDaoImpl deleteTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Tags> searchContentTags(int contentId) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagsSearch", contentId);
		} catch (Exception e) {
			log.info("TagsDaoImpl searchContentTags() => " + e.getMessage());
		}
		return listTags;
	}
		
}
