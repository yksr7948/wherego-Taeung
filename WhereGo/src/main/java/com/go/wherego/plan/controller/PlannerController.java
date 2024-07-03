package com.go.wherego.plan.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.wherego.plan.model.service.PlanDataService;
import com.go.wherego.plan.model.service.PlannerService;
import com.go.wherego.plan.model.vo.Planner;

@Controller
public class PlannerController {
	
	@Autowired
	public PlannerService plannerService;
	@Autowired
	public PlanDataService planDataService;

	//플래너 페이지로 이동
	@RequestMapping("planner.pl")
	public String planList() {
		
		return "plan/plannerList";
	}
	
	//플래너 작성페이지로 이동
	@RequestMapping("insertPlanner.pl")
	public String insertPlanner(Planner planner, Model model) {
		
		List<Date> days = planDataService.getDays(planner.getStartDate(), planner.getEndDate());
		
		model.addAttribute("days",days);
		model.addAttribute("planner",planner);
		
		return "plan/plannerInsert";
	}
	
}
