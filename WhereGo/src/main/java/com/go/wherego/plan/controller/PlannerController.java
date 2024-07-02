package com.go.wherego.plan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.wherego.plan.model.service.PlannerService;
import com.go.wherego.plan.model.vo.Planner;

@Controller
public class PlannerController {
	
	@Autowired
	public PlannerService planService;

	//플래너 페이지로 이동
	@RequestMapping("planner.pl")
	public String planList() {
		
		return "plan/plannerList";
	}
	
	//플래너 추가
	@RequestMapping("insertPlanner.pl")
	public String insertPlanner(Planner plan) {
		
		System.out.println(plan);
		
		
		return "";
	}
	
}
