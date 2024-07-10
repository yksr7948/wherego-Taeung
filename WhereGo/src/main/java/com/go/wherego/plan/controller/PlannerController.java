package com.go.wherego.plan.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.go.wherego.plan.model.service.PlanDataService;
import com.go.wherego.plan.model.service.PlannerService;
import com.go.wherego.plan.model.vo.PlanData;
import com.go.wherego.plan.model.vo.Planner;
import com.google.gson.Gson;

@Controller
public class PlannerController {
	
	@Autowired
	public PlannerService plannerService;
	@Autowired
	public PlanDataService planDataService;

	//플래너 페이지로 이동
	@RequestMapping("planner.pl")
	public String planList(String userId, Model model) {
		
		ArrayList<Planner> plannerList = plannerService.selectPlanner(userId);
		ArrayList<PlanData> planList = planDataService.selectPlanData(plannerList);
		
		model.addAttribute("plannerList", plannerList);
		model.addAttribute("planList", planList);
		
		return "plan/plannerList";
	}
	
	//플래너 작성페이지로 이동
	@RequestMapping("insertPlanner.pl")
	public String insertPlanner(Planner planner, Model model) {
		
		//DAY들 가져오기
		List<Date> days = planDataService.getDays(planner.getStartDate(), planner.getEndDate());
		
		model.addAttribute("days",days);
		model.addAttribute("planner",planner);
		
		return "plan/plannerInsert";
	}
	
    // 플래너 상세보기 페이지로 이동
    @RequestMapping("plannerDetailView.pl")
    public String plannerDetailView(@RequestParam("plannerNo") int plannerNo, Model model) {
        Planner planner = plannerService.selectPlannerByNo(plannerNo);
        ArrayList<PlanData> planDataList = planDataService.selectPlanDataByPlannerNo(plannerNo);

        if (!planDataList.isEmpty()) {
            PlanData initialData = planDataList.get(0);
            model.addAttribute("initialMapX", initialData.getMapx());
            model.addAttribute("initialMapY", initialData.getMapy());
        } else {
            model.addAttribute("initialMapX", "0");
            model.addAttribute("initialMapY", "0");
        }

        Gson gson = new Gson();
        String planDataJson = gson.toJson(planDataList);
        model.addAttribute("planDataJson", planDataJson);

        model.addAttribute("planner", planner);
        model.addAttribute("planDataList", planDataList);

        return "plan/plannerDetailView";
    }
}