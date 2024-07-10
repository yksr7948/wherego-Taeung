package com.go.wherego.plan.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.go.wherego.plan.model.service.PlanDataService;
import com.go.wherego.plan.model.service.PlannerService;
import com.go.wherego.plan.model.vo.PlanData;
import com.go.wherego.plan.model.vo.Planner;

@Controller
public class PlanDataController {

	public static final String SERVICEKEY = "Y7q7XmGoF9h%2FphY8nNxCXsROOjlhzAEB3Igq4QKCxopSkOaEM5iW4PTh2HakmtsWSmmuT9Z9nJk1y%2BBti5OydQ%3D%3D";
	
	@Autowired
	public PlannerService plannerService;
	@Autowired
	public PlanDataService planDataService;

	//검색 리스트 가져오기
	@ResponseBody
	@RequestMapping(value="searchPlace.pl", produces="application/json;charset=UTF-8")
	public String searchPlace(String keyword, String pageNo) throws IOException {
		
		String url = "http://apis.data.go.kr/B551011/KorService1/searchKeyword1";
		url += "?serviceKey="+SERVICEKEY;
		url += "&numOfRows=9&MobileOS=ETC&MobileApp=AppTest&_type=JSON&listYN=Y&arrange=O";
		url += "&pageNo="+pageNo;
		url += "&keyword="+URLEncoder.encode(keyword,"UTF-8");
		
		URL requestUrl = new URL(url);
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		
		urlCon.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		
		String responseStr = "";
		
		String line;
		
		while((line = br.readLine())!=null) {
			responseStr+=line;
		}
		
		
		return responseStr;
	}
	
	//플래너 저장
	@PostMapping(value="savePlanner.pl")
	public ResponseEntity<String> savePlanner(@RequestBody PlanData data) {
		
		ArrayList<PlanData> pList = new ArrayList<>();
		
		
		//플래너 저장
		int result = plannerService.insertPlanner(data.getPlanner());
		
		// planner 저장 성공하면 planList 저장하기
		for(PlanData plan : data.getPlanList()) {
            pList.add(new PlanData(plan.getPlanNo(),
                                   data.getPlanner().getPlannerNo(), 
                                   plan.getDay(),
                                   plan.getName(),
                                   plan.getTime(),
                                   plan.getIntro(),
                                   plan.getMapx(),
                                   plan.getMapy(),
                                   plan.getFirstImage()));
        }
		
		int result2 = planDataService.insertPlanData(pList);
		
		if(result <= 0 || result2 > 0){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("플래너 저장에 실패하였습니다, 다시 작성해주세요.");
        }

		return ResponseEntity.ok("Success");
	}
}
