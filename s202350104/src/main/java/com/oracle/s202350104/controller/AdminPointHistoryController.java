package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Point;
import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PointHistoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AdminPointHistoryController {
	
	private final PointHistoryService phs;
	
	@GetMapping(value = "/admin/point/pointhistory")
		public String pointhistory(PointHistory pointhistory, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		int path = 0;
		
		try {
			log.info("[{}]{}:{}",transactionId, "pointhistory", "start");
		int totalpointhistory = phs.totalpointHistory();
		
		Paging page = new Paging(totalpointhistory, currentPage);

		pointhistory.setStart(page.getStart());
		pointhistory.setEnd(page.getEnd());
		
		List<PointHistory> listPointHistory = phs.listPointHistory();
		List<PointHistory> sortedList = phs.listPointHistorySortedByDateDesc(listPointHistory);

        model.addAttribute("listPointHistory", sortedList);
        model.addAttribute("totalpointHistory", totalpointhistory);
        model.addAttribute("page",page);
		model.addAttribute("path",path);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "admin accomodation", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodation", "end");
		}
		
		return "admin/point/pointhistory";
		
	}
	
	@RequestMapping(value = "/admin/point/deletePointHistory")
	public String deletePointHistory(Integer id, Model model) {
		
		phs.deletePointHistory(id);
	   
		return "redirect:/admin/point/pointhistory";
	}
	
	@GetMapping(value="/admin/point/writeFormPointHistory")
	public String writeFormPoint(PointHistory pointhistory, Model model) {
		
		model.addAttribute("Pointhitory", pointhistory);
		
		return "admin/point/writeFormPointHistory";
	}
	
	@PostMapping("/admin/point/writePointHistory")
	public String writePointHistory(PointHistory pointhistory) {
	    phs.writePointHistory(pointhistory);
	    return "redirect:/admin/point/pointhistory";
	}
	
    @PostMapping("/admin/point/pointhistorySearch")
    public String pointhistorySearch(String search, String keyword, Model model) {
        List<PointHistory> searchResult = phs.searchPointHistory(search, keyword);
        model.addAttribute("listPointHistory", searchResult);
        return "admin/point/pointhistory";
    }
	

}
