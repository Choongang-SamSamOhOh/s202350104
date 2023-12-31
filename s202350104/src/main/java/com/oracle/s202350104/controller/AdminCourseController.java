package com.oracle.s202350104.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.ContentDaoImpl;
import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.CourseService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;

import lombok.RequiredArgsConstructor;
import lombok.val;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/course")
public class AdminCourseController {

	private final CourseService cs;
	private final ContentSerivce contentService;
	private final CommonCodeService ccs;
	private final AreaService ars;
	
	/* 전체적으로 각 Method들이 무슨 기능을 하고 있는지 간략하게 주석을 남겨주시면 다른 분들도 이해하기 좋을 것  같아요.
	 * by.엄민용
	 */ 
	
	// 관리자 코스정보 리스트 이동
	@RequestMapping(value = "/list")
	public String courseList(Course course, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin Course", "start");
			
			int path = 0;
			
			// 조건에 맞는 Course의 총 개수를 가져옴
			int courseCount = cs.courseCount(course);
			
			// 페이징 처리
			PagingList page = new PagingList(courseCount, currentPage);
			course.setStart(page.getStart());
			course.setEnd(page.getEnd());
			
			// 조건에 맞는 Course의 list를 가져옴
			List<Course> courseList = cs.courseList(course);
			
			log.info("CourseController courseListSmallCode start...");
			List<Course> courseListSmallCode = cs.courseListSmallCode(course);
			log.info("CourseListSmallCode : " + courseListSmallCode);
			
			log.info("course : " +courseList);

			model.addAttribute("courseCount", courseCount);
			model.addAttribute("courseList", courseList);
			model.addAttribute("CourseListSmallCode", courseListSmallCode);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			
		} catch (Exception e) {
			log.error("AdminCourseController courseList e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseList end");
		}

		return "admin/course/list";
	}
	
	@RequestMapping(value = "/list1")
	public String courseList(Course course, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "CourseList1", "start");
			
			int path = 1;
			String small_code = request.getParameter("small_code");
			String big_code = request.getParameter("big_code");
			String keyword = request.getParameter("keyword");
			String area = request.getParameter("area");
			String sigungu = request.getParameter("sigungu");
			
			// 조건에 맞는 Course의 총 개수를 가져옴
			int courseCount = cs.courseCount(course);
			
			// 페이징 처리
			PagingList page = new PagingList(courseCount, currentPage);
			course.setStart(page.getStart());
			course.setEnd(page.getEnd());
			
			// 조건에 맞는 Course의 list를 가져옴
			List<Course> courseList = cs.courseList(course);
			
			log.info("CourseController courseListSmallCode start...");
			List<Course> courseListSmallCode = cs.courseListSmallCode(course);
			log.info("CourseListSmallCode : " + courseListSmallCode);
			
			log.info("course : " +courseList);

			model.addAttribute("courseCount", courseCount);
			model.addAttribute("courseList", courseList);
			model.addAttribute("CourseListSmallCode", courseListSmallCode);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			model.addAttribute("small_code", small_code);
			model.addAttribute("big_code", big_code);
			model.addAttribute("keyword", keyword);
			model.addAttribute("area" , area);
			model.addAttribute("sigungu", sigungu);
			
		} catch (Exception e) {
			log.error("AdminCourseController courseList e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseList end");
		}

		return "admin/course/list";
	}

	@RequestMapping(value = "/courseUpdateForm")
	public String courseUpdateForm(int id, String currentPage, Model model) {
		log.info("AdminCourseController courseUpdateForm start...");
		try {
			log.info("AdminCourseController courseUpdateForm id : " + id);
		
			Course course = cs.courseUpdateDetail(id);

			List<CourseContent> courseContentList = cs.courseContentList(id);
			log.info("AdminCourseController courseUpdateForm courseContentList.size() : " + courseContentList.size());
			
			List<CommonCodes> listCodes = ccs.listCommonCode();
			log.info("listCodes : " + listCodes);
			
			List<Areas> listAreas = ars.listAreas();
			log.info("listAreas : " + listAreas);
			List<Areas> listSigungu = ars.listSigungu(course.getArea());
			log.info("listSigungu : " + listSigungu);
			
//			List<Course> courseDetailContent = cs.courseDetail(course.getCourse_id());
//			log.info("AdminCourseController courseUpdateForm course ->" + courseDetailContent.size());

			model.addAttribute("course", course);
			model.addAttribute("courseContentList", courseContentList);
			model.addAttribute("listCodes", listCodes);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("listSigungu", listSigungu);
//			model.addAttribute("courseContent", courseContent);

		} catch (Exception e) {
			log.error("AdminCourseController courseUpdateForm e.getMessage() : " + e.getMessage());
		} finally {
			log.info("AdminCourseController courseUpdateForm end...");
		}
		return "course/courseUpdateForm";
	}

	@RequestMapping(value = "courseUpdate", method = RequestMethod.POST)
	public String courseUpdate(@RequestParam(name = "id") int courseId,
								Course course,
								@RequestParam(name = "delList", required = false) List<String> delList,
							    @RequestParam(name = "addList", required = false) List<String> addList,
								Model model) {
		log.info("AdminCourseController courseUpdate start...");
		log.info("AdminCourseController courseUpdate course ->" + course);
		
		
		try {
			log.info("courseID:{}", course.getId());
			int course_id = cs.courseUpdate(course);
			log.info("AdminCourseController courseUpdate course_id ->" + course_id);
			
			log.info("contentsToAdd : {}", addList);
			log.info("contentsToDelete : {}", delList);
			
			
			log.info("AdminCourseController courseUpdate deleteContent start...");
			List<CourseContent> deleteContent = new ArrayList<CourseContent>();
			
			if(delList != null) {
				for (int i = 0; i < delList.size(); i++) {
					CourseContent dd = new CourseContent();
					
					dd.setContent_id(Integer.parseInt(delList.get(i)));
					log.info("setContent_id deleteContentId ->" + (delList.get(i)));
					dd.setCourse_id(course.getId());
					log.info("setCourse_id deleteCourseId ->" + course.getId());
					deleteContent.add(dd);
				}
			log.info("AdminCourseController deleteToContent start...");
			int deleteToContent = cs.deleteToContent(deleteContent);
			log.info("AdminCourseController delToContent ->" + deleteToContent);
			}
			

			log.info("AdminCourseController courseUpdate addToContent start...");
			List<CourseContent> addToContent = new ArrayList<CourseContent>();
			
			if(addList != null) { 
				// 주어진 코스에 대한 데이터베이스의 최대 순서 번호 결정
				int maxOrderNum = cs.maxOrderNum(course.getId());
				
				for (int i = 0; i < addList.size(); i++) {
					CourseContent cc = new CourseContent();
					
					cc.setContent_id(Integer.parseInt(addList.get(i)));
					log.info("setContent_id newCourseId ->" + (addList.get(i)));
					cc.setCourse_id(course.getId());
					log.info("setCourse_id newCourseId ->" + course.getId());
					cc.setOrder_num(maxOrderNum + i + 1);
					log.info("setOrder_num newCourseId ->" + (maxOrderNum + i + 1));
					addToContent.add(cc);
				}
			log.info(addList.toString());
			int courseContentInsert = cs.courseContentInsert(addToContent);
			log.info("AdminCourseController courseContentInsert ->" + courseContentInsert);
			}
			

		} catch (Exception e) {
			log.error("AdminCourseController courseUpdate e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseUpdate end...");
		}
		return "redirect:/admin/course/list";
	}

	@RequestMapping(value = "/courseInsertForm")
	public String courseInsertForm(Course Course, Contents contents, Model model) {
		log.info("AdminCourseController courseInsertForm start...");
		log.info("AdminCourseController courseInsertForm contents.getId() -> {}", contents.getId());
		
		List<CommonCodes> listCodes = ccs.listCommonCode();
		
		model.addAttribute("listCodes", listCodes);
		
		return "course/courseInsertForm";
	}

	@RequestMapping(value = "/courseInsert")
	public String courseInsert(Course course, @RequestParam(value = "contents") List<String> contents, Model model) {
		
		try {
			log.info("AdminCourseController courseInsert start...");
			log.info("AdminCourseController courseInsert course ->" + course);
			log.info("AdminCourseController courseInsert course ->" + contents);

			/* TODO: Course정보를 INSERT. */
			int newCourseId = cs.courseInsert(course);
			log.info("AdminCourseController courseInsert courseInsert ->" + newCourseId);

			List<CourseContent> courseContentList = new ArrayList<CourseContent>();
			
			/* TODO: Content Course정보를 INSERT */ // dto
			for (int i = 0; i < contents.size(); i++) {
				CourseContent cc = new CourseContent();
				cc.setContent_id(Integer.parseInt(contents.get(i)));
				log.info("setContent_id newContent_id ->" + (contents.get(i)));
				cc.setCourse_id(newCourseId);
				log.info("setCourse_id newCourse_id ->" + newCourseId);
				cc.setOrder_num(i + 1);
				log.info("setCourse_id newOrder_num ->" + i);
				courseContentList.add(cc);
			}
			
			log.info(contents.toString());
			int courseContentInsert = cs.courseContentInsert(courseContentList);
			log.info("AdminCourseController courseInsert courseInsert ->" + courseContentInsert);

		} catch (Exception e) {
			log.error("AdminCourseController courseInsert e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseInsert end...");
		}
		return "redirect:/admin/course/list";
	}

	@RequestMapping(value = "/contentListAll")
	public String contentListAll(Contents content, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "contentListAll", "start");
			
			int path = 0;
			
			// 조건에 맞는 컨텐츠의 전체 list의 수를 나타냄.
			int contentCount = contentService.contentCount(content);
			
			// 페이징 처리
			PagingList page = new PagingList(contentCount, currentPage);
			content.setStart(page.getStart());
			content.setEnd(page.getEnd());
			
			// 조건에 맞는 컨텐츠의 list를 나타냄
			List<Contents> listContents = contentService.listContents(content);
			log.info("listContents : " + listContents);
			
			model.addAttribute("contentCount", contentCount);
			model.addAttribute("listContents", listContents);
			model.addAttribute("page", page);
			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("ContentController contentListAll e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("ContentController contentListAll end...");
		}
		return "content/contentListAll";
	}
	
	@RequestMapping(value = "/contentListAll1")
	public String contentListAll(Contents content, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "contentListAll", "start");
			
			int path = 1;
			String keyword = request.getParameter("keyword");
			String area = request.getParameter("area");
			String sigungu = request.getParameter("sigungu");
			
			// 조건에 맞는 컨텐츠의 전체 list의 수를 나타냄.
			int contentCount = contentService.contentCount(content);
			
			// 페이징 처리
			PagingList page = new PagingList(contentCount, currentPage);
			content.setStart(page.getStart());
			content.setEnd(page.getEnd());
			
			// 조건에 맞는 컨텐츠의 list를 나타냄
			List<Contents> listContents = contentService.listContents(content);
			log.info("listContents : " + listContents);
			
			model.addAttribute("contentCount", contentCount);
			model.addAttribute("listContents", listContents);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			model.addAttribute("keyword", keyword);
			model.addAttribute("area" , area);
			model.addAttribute("sigungu", sigungu);

		} catch (Exception e) {
			log.error("ContentController contentListAll e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("ContentController contentListAll end...");
		}
		return "content/contentListAll";
	}

	@RequestMapping(value = "/courseDelete")
	public String courseDelete(int id) {
		log.info("AdminCourseController courseDelete start...");
		
		try {
			/* TODO: CourseContents 삭제 */
			log.info("AdminCourseController id ->" + id);
			
			int courseContentDelete = cs.courseContentDelete(id);
			log.info("AdminCourseController courseContentDelete courseDelete ->" + courseContentDelete);

			/* TODO: Courses 삭제 */
			int courseDelete = cs.courseDelete(id);
			log.info("AdminCourseController courseDelete courseDelete ->" + courseDelete);

		} catch (Exception e) {
			log.error("AdminCourseController courseDelete e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseDelete end...");
		}
		return "redirect:/admin/course/list";
	}

//	@RequestMapping(value = "/deleteCourseContentAjax")
//	public String deleteCourseContent(@RequestParam("content_id") int contentId, @RequestParam("course_id") int courseId) {
//		log.info("AdminCourseController deleteCourseContent id ->" + contentId, courseId);
//		String deleteCourseContentStr = null;
//		
//		try {
//			int deleteCourseContent = cs.deleteCourseContent(contentId, courseId);
//			log.info("AdminCourseController deleteCourseContent deleteCourseContent ->" + deleteCourseContent);
//			deleteCourseContentStr = Integer.toString(deleteCourseContent);
//			
//		} catch (Exception e) {
//			log.error("AdminCourseController deleteCourseContent e.getMessage() ->" + e.getMessage());
//		} finally {
//			log.info("AdminCourseController deleteCourseContent end...");
//		}
//		
//		return deleteCourseContentStr;
//	}
	@ResponseBody
	@RequestMapping(value = "deleteCourseContentAjax", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCourseContent(@RequestBody CourseContent courseContent) {
		log.info("AdminCourseController deleteCourseContent start...");
		log.info("AdminCourseController deleteCourseContent getCourse_id() ->" + courseContent);
		
		ResponseEntity<String> response = null;

		try {
			int deleteCourseContent = cs.deleteCourseContent(courseContent);
			log.info("AdminCourseController deleteCourseContent deleteCourseContent ->" + deleteCourseContent);
			
			// if문 {} 잘 사용하기, 조건이 하나여도 가독성에 좋게 {} 사용 by. 엄민용
			if (deleteCourseContent == 0)
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 리스트가 존재하지 않습니다.");

			response = ResponseEntity.status(HttpStatus.CREATED).body("success");
		} catch (Exception e) {
			log.error("AdminCourseController deleteCourseContent e.getMessage() ->" + e.getMessage());
			
			response = ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());

		} finally {
			log.info("AdminCourseController deleteCourseContent end...");
		}

		return response;
	}

}
