package com.oracle.s202350104.service;

import java.util.List;
import java.util.Map;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;

public interface TagsService {
	int totalTags(Tags tags);
	List<Tags> listTags(Tags tags);
	int insertTags(Tags tags);
	Tags selectTags(int id);
	int updateTags(Tags tags);
	int deleteTags(int id);
	List<Tags> searchContentTags(int contentId);
	List<Tags> listBoardTags(int smallCode);
	List<Tags> listUserTags(Tags tags);
	List<Tags> listContentTags(int bigCode);
	List<Tags> searchBoardTagsOne(int boardId);
	void boardTagsInsert(Tags tags);
	List<Tags> boardTagDetail(int id);
	int boardTagDelete(int id);
	int updateBoardTags(int boardId, int[] finalTags);
	int updateContentTags(int contentId, int[] finalTags);
	List<Tags> listCourseTags(int smallCode);
	List<Tags> searchCourseTags(int courseId);
	int updateCourseTags(int courseId, int[] finalTags);
	int selectUserTagsCnt(int tagId);
	int selectBoardTagsCnt(int tagId);
	int selectContentTagsCnt(int tagId);
	int selectCourseTagsCnt(int tagId);
	int userTagsTotal(Tags tag);
	List<Tags> searchUserTagsList(Tags tag);
	int boardTagsTotal(Tags tag);
	List<Tags> searchBoardTagsList(Tags tag);
	int contentTagsTotal(Tags tag);
	List<Tags> searchContentTagsList(Tags tag);
	int courseTagsTotal(Tags tag);
	List<Tags> searchCourseTagsList(Tags tag);
	List<Tags> searchUserTagsOne(int userId);
	int updateUserTags(int userId, int[] finalTags);
	List<Tags> userPopularTags();
	
}
