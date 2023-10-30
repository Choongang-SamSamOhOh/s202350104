package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.service.FestivalsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FestivalController {
	
	private final FestivalsService fs;
	
	@RequestMapping(value = "festival")
	public String festival(Model model) {
		List<FestivalsContent> listFestivals = fs.listFestivals();
		
		model.addAttribute("listFestivals", listFestivals);
		
		return "festival/festivalList";
	}
	
	@RequestMapping(value = "festival/detail")
	public String festivalDetail(int contentId, Model model) {
		FestivalsContent festival = fs.detailFestivals(contentId);
		
		model.addAttribute("contentId", contentId);
		model.addAttribute("festival", festival);
		
		return "festival/festivalDetail";
	}
	
	@RequestMapping(value = "festival/recommend")
	public String festivalRecommendation() {
		return "festival/festivalRecommend";
	}
	
	@RequestMapping(value = "festival/test")
	public String festivalTest() {
		return "festival/festivalTest";
	}
	
	@RequestMapping(value = "festival/calendar")
	public String festivalCalendar() {
		return "festival/festivalCalendar";
	}
}
