package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDaoImpl implements BoardDao {

	private final SqlSession session;

	// 조회수 증가 logic
	public void readCountUp(int boardId) {

		log.info("BoardDao readCountUp boardId : {}", boardId);

		try {
			session.selectOne("readCountUp", boardId);
		} catch (Exception e) {
			log.error("BoardDao readCountUp Exception : {}", e.getMessage());
		}
	}

	// Paging 처리용
	@Override
	public int boardCount(int smallCode) {

		int countBoard = 0;

		try {
			countBoard = session.selectOne("boardCount", smallCode);
		} catch (Exception e) {
			log.error("BoardDao boardCount Exception : {}", e.getMessage());
		}

		return countBoard;
	}
	
	// 공지사항, DB연동
	@Override
	public List<Board> getNoticAllList(Board board) {

		List<Board> noticAllList = null;

		try {
			noticAllList = session.selectList("noticAllList", board);
			log.info("BoardDao getNoticAllList size : {}", noticAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getNoticAllList Exception : {}", e.getMessage());
		}

		return noticAllList;
	}
	
	// 이달의 소식, DB연동
	@Override
	public List<Board> getMagazinAllList(Board board) {

		List<Board> magazinAllList = null;

		try {
			magazinAllList = session.selectList("magazinAllList", board);
			log.info("BoardDao getMagazinAllList size : {}", magazinAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getMagazinAllList Exception : {}", e.getMessage());
		}

		return magazinAllList;
	}
	
	// 자유게시판, DB연동
	@Override
	public List<Board> getFreeAllList(Board board) {

		List<Board> freeAllList = session.selectList("freeAllList", board);

		log.info("BoardDao getFreeAllList size : {}", freeAllList.size());

		return freeAllList;
	}
	
	// 포토게시판, DB연동
	@Override
	public List<Board> getPhotoAllList(Board board) {

		List<Board> photoAllList = null;

		try {
			photoAllList = session.selectList("photoAllList", board);
		} catch (Exception e) {
			log.error("BoardDao getPhotoAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao getPhotoAllList End");
		}

		return photoAllList;
	}
	
	// 이벤트게시판, DB연동
	@Override
	public List<Board> getEventAllList(Board board) {

		List<Board> eventAllList = null;

		try {
			eventAllList = session.selectList("eventAllList", board);
		} catch (Exception e) {
			log.error("BoardDao getPhotoAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao getPhotoAllList End");
		}

		return eventAllList;
	}
	
	// review, DB연동
	@Override
	public List<Board> getReviewAllList(Board board) {
		log.info("BoardDao getReviewAllList Start!!");
		log.info("boardService reviewBoardList board.getContentId : {} ", board.getContent_id());
		List<Board> reviewAllList = session.selectList("reviewAllList", board);
		log.info("BoardDao reviewAllList size : {}", reviewAllList.size());
		log.info("BoardDao reviewAllList content : {}", reviewAllList.get(0).getContent());
		
		log.info("BoardDao getReviewAllList End..");

		return reviewAllList;
	}
	// 통합게시판 상세정보, DB연동
	@Override
	public Board boardDetail(int boardId) {

		Board boards = null;

		try {
			boards = session.selectOne("boardDetail", boardId);
			log.info("BoardDao boardDetail getTitle : {}", boards.getTitle());

			readCountUp(boardId);

		} catch (Exception e) {
			log.error("BoardDao boardDetail Exception : {}", e.getMessage());
		}

		return boards;
	}
	
	// 통합게시판 수정, DB연동
	@Override
	public int boardUpdate(Board board) {

		int updateBoard = 0;

		try {
			updateBoard = session.update("boardUpdate", board);
		} catch (Exception e) {
			log.error("BoardDao boardUpdate Exception : {}", e.getMessage());
		}

		return updateBoard;
	}
	
	// 통합게시판 삭제, DB연동
	@Override
	public int boardDelete(int boardId) {

		int deleteBoard = 0;

		try {
			deleteBoard = session.delete("boardDelete", boardId);
		} catch (Exception e) {
			log.error("BoardDao boardDelete Exception : {}", e.getMessage());
		}

		return deleteBoard;
	}
	
	// 통합게시판 생성, DB연동
	@Override
	public int boardInsert(Board board) {
		
		int insertBoard = 0;

		try {
			insertBoard = session.delete("boardInsert", board);
		} catch (Exception e) {
			log.error("BoardDao boardInsert Exception : {}", e.getMessage());
		}

		return insertBoard;

	}

}
