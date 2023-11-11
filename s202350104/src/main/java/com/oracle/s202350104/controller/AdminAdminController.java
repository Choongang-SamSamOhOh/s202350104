package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.AdminListService;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/admin/*")
public class AdminAdminController {

	private final AdminListService als;
	private final CommonCodeService ccs;
	private final AreaService as;
	private final UserService us;
	
	/* 전체적으로 각 Method들이 무슨 기능을 하고 있는지 간략하게 주석을 남겨주시면 다른 분들도 이해하기 좋을 것  같아요.
	 * by.엄민용
	 */ 

	@RequestMapping(value = "/adminList")
	public String adminList(Users user, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "adminList", "start");
			int totalAdminList = als.totalAdminList();

			Paging page = new Paging(totalAdminList, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());

			List<Users> listUser = als.listUser(user);

			model.addAttribute("totalAdminList", totalAdminList);
			model.addAttribute("page", page);
			model.addAttribute("listUser", listUser);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "adminList", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "adminList", "end");
		}

		return "admin/admin/adminList";
	}

	@RequestMapping(value = "/commonCode")
	public String commonCode(CommonCodes commonCode, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "commonCode", "start");
			int totalCommonCode = ccs.totalCommonCode();

			int path = 0;

			Paging page = new Paging(totalCommonCode, currentPage);
			commonCode.setStart(page.getStart());
			commonCode.setEnd(page.getEnd());

			List<CommonCodes> listCommonCode = ccs.listCommonCode(commonCode);
			List<CommonCodes> listCommon = ccs.listCommonCode();

			model.addAttribute("totalCommonCode", totalCommonCode);
			model.addAttribute("listCommonCode", listCommonCode);
			model.addAttribute("listCommon", listCommon);
			model.addAttribute("page", page);

			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "commonCode", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "commonCode", "end");
		}

		return "admin/admin/commonCode";
	}

	@RequestMapping(value = "/commonCodeSearch")
	public String commonCodeSeacrch(CommonCodes commonCode, String currentPage, 
									Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "AdminAdminController commonCodeSearch", "start");
			int totalCommonCode = ccs.conTotalCommonCode(commonCode);

			int path = 1;
			String big_code = request.getParameter("big_code");

			Paging page = new Paging(totalCommonCode, currentPage);
			commonCode.setStart(page.getStart());
			commonCode.setEnd(page.getEnd());

			List<CommonCodes> listSearchCommonCode = ccs.listSearchCommonCode(commonCode);
			List<CommonCodes> listCommon = ccs.listCommonCode();

			model.addAttribute("totalCommonCode", totalCommonCode);
			model.addAttribute("path", path);
			model.addAttribute("big_code", big_code);
			model.addAttribute("page", page);
			model.addAttribute("listCommonCode", listSearchCommonCode);
			model.addAttribute("listCommon", listCommon);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "AdminAdminController commonCodeSearch", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "AdminAdminController commonCodeSearch", "end");
		}

		return "admin/admin/commonCode";
	}

	@RequestMapping(value = "/areaCode")
	public String areaCode(Areas area, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "areaCode", "start");
			int totalAreaCode = as.totalAreaCode();
			int path = 0;

			Paging page = new Paging(totalAreaCode, currentPage);
			area.setStart(page.getStart());
			area.setEnd(page.getEnd());

			List<Areas> listAreaCode = null;// as.listAreas(area);
			List<Areas> listAreas = as.listAreas();

			model.addAttribute("totalAreaCode", totalAreaCode);
			model.addAttribute("path", path);
			model.addAttribute("page", page);
			model.addAttribute("listAreaCode", listAreaCode);
			model.addAttribute("listAreas", listAreas);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "areaCode", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "areaCode", "end");
		}

		return "admin/admin/areaCode";

	}

	@RequestMapping(value = "/areaCodeSearch")
	public String areaCodeSearch(Areas area, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "areaCode", "start");
			int totalAreaCode = as.conTotalAreaCode(area);
			int path = 1;
			String area_code = request.getParameter("area");

			Paging page = new Paging(totalAreaCode, currentPage);
			area.setStart(page.getStart());
			area.setEnd(page.getEnd());

			List<Areas> listSearchAreaCode = as.listSearchAreaCode(area);
			List<Areas> listAreas = as.listAreas();

			model.addAttribute("totalAreaCode", totalAreaCode);
			model.addAttribute("path", path);
			model.addAttribute("area", area_code);
			model.addAttribute("page", page);
			model.addAttribute("listAreaCode", listSearchAreaCode);
			model.addAttribute("listAreas", listAreas);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "areaCode", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "areaCode", "end");
		}

		return "admin/admin/areaCode";

	}

}
