package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Course {
	
	private int		id;
	private int		big_code;
	private int		small_code;
	private int		area;
	private int		sigungu;
	private String  distance;
	private String  course_info;
	private String  time;
	private String  schedule;
	private String  course_title;
	
	// CourseContent
	private int 	content_id;
	private int 	course_id;
	private int 	order_num;
	
	// contents
	private String  title;
	private String  content;
	private String  status;
	private String  img1;
	private String  img2;
	private String  img3;
	private String  address;
	private int 	postcode;
	private String  mapx;
	private String  mapy;
	private String  email;
	private String  phone;
	private String  homepage;
	private int 	readcount;
	private String  user_id;
	private Date 	created_at;
	private Date 	deleted_at;
	private String  is_deleted;
	private int		contArea;
	private int		contSigungu;
	
	// 페이징 처리용
	private String pageNum;
	private int    start;
	private int    end;
	
	// join용
	private String area_content;	// 시도
	private String sigungu_content;	// 시군구
	
	// courseContent
	private String cd_content;
	
	// 검색용
	private String searchType;
	private String keyword;
	
}
