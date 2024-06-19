package com.go.wherego.trip.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.go.wherego.trip.model.service.TripService;
import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Trip;
import com.go.wherego.trip.template.Pagination;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@Controller
public class TripController {

	
	public static final String SERVICEKEY = "Y7q7XmGoF9h%2FphY8nNxCXsROOjlhzAEB3Igq4QKCxopSkOaEM5iW4PTh2HakmtsWSmmuT9Z9nJk1y%2BBti5OydQ%3D%3D";
	
	@Autowired
	private TripService tripService;
	
	//여행지저장 페이지로 이동
	@RequestMapping("tripSave.do")
	public String tripSave() {
		
		return "trip/tripSave";
	}
	
	//데이터 확인
	@ResponseBody
	@RequestMapping(value="area.do",produces = "application/json;charset=UTF-8")
	public String areaPollution(String location) throws IOException {
		
		
		String url = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1";
		url+="?serviceKey="+SERVICEKEY;
		//MobileOS=ETC&MobileApp=AppTest&_type=json&areaCode=1
		url+="&numOfRows=1000";
		url+="&MobileOS=ETC";
		url+="&MobileApp=AppTest"; //결과 개수 
		url+="&_type=json";
		url+="&areaCode="+location;
		
		URL requestUrl = new URL(url);
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		urlCon.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		
		String str = "";
		
		String line;
		while((line=br.readLine()) != null) {
			str+=line;
		}
		
		br.close();
		urlCon.disconnect();
		
		System.out.println(str);
		//json 문자열 형태이기때문에 그대로 반납하여도 json화되어서 넘어감 
		
		return str;
	}
	
	//데이터 저장
	@ResponseBody
	@RequestMapping(value="save.do", produces ="application/text;charset=UTF-8")
	public String areaSave(String location) throws IOException {
		
		String url = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1";
		url+="?serviceKey="+SERVICEKEY;
		url+="&numOfRows=1000";
		url+="&MobileOS=ETC";
		url+="&MobileApp=AppTest"; //결과 개수 
		url+="&_type=json";
		url+="&areaCode=" + location;
		
		String area = "";
		
		switch (location) {
		case "1": area = "서울"; break;
		case "2": area = "인천"; break;
		case "3": area = "대전"; break;
		case "4": area = "대구"; break;
		case "5": area = "광주"; break;
		case "6": area = "부산"; break;
		case "7": area = "울산"; break;
		case "31": area = "경기"; break;
		case "32": area = "강원"; break;
		default: area = "제주"; break;
		}
		
		
		URL requestUrl = new URL(url); //요청 url을 넣어서 객체 준비
		
		HttpURLConnection urlCon = (HttpURLConnection)requestUrl.openConnection();
		
		urlCon.setRequestMethod("GET");//get방식 요청 설정
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlCon.getInputStream()));
		
		String responseStr = "";
		String line;
		while((line = br.readLine())!=null) {
			responseStr+=line;
		}
		
		JsonObject jobj = JsonParser.parseString(responseStr).getAsJsonObject();
		
		JsonObject response = jobj.getAsJsonObject("response");
		
		JsonObject body = response.getAsJsonObject("body");
		JsonObject items = body.getAsJsonObject("items");
		JsonArray item = items.getAsJsonArray("item");
		
		
		ArrayList<Trip> list = new ArrayList<>();
		
		for(int i=0;i<item.size();i++) {

			JsonObject it = item.get(i).getAsJsonObject();

			list.add(new Trip(it.get("contentid").getAsString()
							  ,it.get("contenttypeid").getAsString()
							  ,it.get("title").getAsString()
							  ,it.get("addr1").getAsString()
							  ,it.get("addr2").getAsString()
							  ,it.get("zipcode").getAsString()
							  ,it.get("areacode").getAsString()
							  ,it.get("firstimage2").getAsString()
						));
			
		}
		
		
		//작업 끝 자원반납
		br.close(); //버퍼리더반납
		urlCon.disconnect(); // 연결해제
		
		int result = tripService.saveArea(list);
		
		if(result>0) {
			return area;
		}else {
			return "저장실패";
		}
		
	}
	
	//여행지리스트 페이지로 이동
	@RequestMapping("tripList.bo")
	public String tripList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, Model model) {
		
		int listCount = tripService.listCount();
		int pageLimit = 5;
		int boardLimit = 12;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Trip> tList = tripService.selectList(pi);
		
		model.addAttribute("pi",pi);
		model.addAttribute("tList",tList);
		
		return "trip/tripList";
	}
	
}

