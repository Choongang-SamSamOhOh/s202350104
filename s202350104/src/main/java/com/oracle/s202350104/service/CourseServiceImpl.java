package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.boot.context.annotation.DeterminableImports;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.CourseDao;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CourseServiceImpl implements CourseService {

	private final CourseDao cd;

	@Override
	public int courseCount(Course course) {
		int courseCount = cd.courseCount(course);
		
		return courseCount;
	}

	@Override
	public List<Course> courseList(Course course) {
		 List<Course> courseList = cd.courseList(course);
		
		if(courseList == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 리스트가 없습니다.");
		}
		
		return courseList;
	}

	@Override
	public List<Course> courseDetail(int course_id) {
		List<Course> courseDetailList = cd.courseDetail(course_id);
		
		if(courseDetailList == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 상세 리스트가 없습니다.");
		}
		
		return courseDetailList;
	}

	@Override
	public int courseInsert(Course course) {
		int courseInsert = cd.courseInsert(course);
		log.info("CourseServiceImpl courseCount courseInsert ->" + courseInsert);
		
		return courseInsert;
	}

	@Override
	public int courseContentInsert(List<CourseContent> courseContentList) {
		log.info("courseContentInsert ->" + courseContentList);
		int courseContentInsert = cd.courseContentInsert(courseContentList);
		log.info("CourseServiceImpl courseCount courseInsert ->" + courseContentInsert);	
		
		return courseContentInsert;
	}
	
	@Override
	public int courseContentDelete(int id) {
		log.info("CourseServiceImpl courseContentDelete start...");
		int courseContentDelete = cd.courseContentDelete(id);
		log.info("CourseServiceImpl courseContentDelete courseDelete ->" + courseContentDelete);
		
		return courseContentDelete;
	}

	@Override
	public int courseDelete(int id) {
		log.info("CourseServiceImpl courseDelete start...");
		int courseDelete = cd.courseDelete(id);
		log.info("CourseServiceImpl courseDelete courseDelete ->" + courseDelete);
		
		return courseDelete;
	}

	@Override
	public Course courseUpdateDetail(int id) {
		Course courseUpdateDetail = cd.courseUpdateDetail(id);
		
		return courseUpdateDetail;
	}

	@Override
	public int courseUpdate(Course course) {
		log.info("CourseServiceImpl courseUpdate start...");
		int courseUpdate = cd.courseUpdate(course);
		
		return courseUpdate;
	}

	@Override
	public List<CourseContent> courseContentList(int id) {
		List<CourseContent> courseContentList = cd.courseContentList(id);
		
		return courseContentList;
	}


	@Override
	public int deleteCourseContent(CourseContent courseContent) {
		int deleteCourseContent = cd.deleteCourseContent(courseContent);
		
		return deleteCourseContent;
	}

	@Override
	public int deleteToContent(List<CourseContent> deleteContent) {
		int deleteToContent = cd.deleteToContent(deleteContent);
		
		return deleteToContent;
	}

	@Override
	public int maxOrderNum(int id) {
		int maxOrderNum = cd.maxOrderNum(id);
		
		return maxOrderNum;
	}

	@Override
	public List<Course> courseListSmallCode(Course course) {
		List<Course> courseListSmallCode = cd.courseListSmallCode(course);
		
		return courseListSmallCode;
	}
	

}
