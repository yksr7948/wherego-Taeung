package com.go.wherego.trip.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.go.wherego.trip.model.service.TripService;
import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Reply;
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
	@RequestMapping("tripList.tl")
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
	
	//지역별리스트 페이지로 이동
	@RequestMapping("areaList.tl")
	public String areaList(@RequestParam(value="currentPage", defaultValue="1") int currentPage, String areaCode, Model model) {
		
		String location = "";
		
		switch (areaCode) {
			case "1": location = "서울"; break;
			case "2": location = "인천"; break;
			case "3": location = "대전"; break;
			case "4": location = "대구"; break;
			case "5": location = "광주"; break;
			case "6": location = "부산"; break;
			case "7": location = "울산"; break;
			case "31": location = "경기"; break;
			case "32": location = "강원"; break;
			default: location = "제주"; break;
		}
		
		int areaListCount = tripService.areaListCount(areaCode); 
		int pageLimit = 5;
		int boardLimit = 12;
		
		PageInfo pi = Pagination.getPageInfo(areaListCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Trip> aList = tripService.selectAreaList(pi, areaCode);
		
		model.addAttribute("pi",pi);
		model.addAttribute("aList",aList);
		model.addAttribute("location",location);
		model.addAttribute("areaCode",areaCode);
		
		return "trip/areaList";
	}
	
	//상세보기 페이지로 이동
	@RequestMapping("tripDetail.tl")
	public String tripDetail(String contentId, Model model) throws IOException {
		
		String url = "http://apis.data.go.kr/B551011/KorService1/detailCommon1";
		url+="?serviceKey="+SERVICEKEY;
		//&MobileOS=ETC&MobileApp=AppTest&contentId=126508&defaultYN=Y&firstImageYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y
		url+="&MobileOS=ETC&MobileApp=AppTest&_type=json";
		url+="&contentId="+contentId;
		url+="&defaultYN=Y&firstImageYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y";
		
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
		
		JsonObject it = item.get(0).getAsJsonObject();
		
		// 날짜 형식 지정
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		// 문자열을 date 형식으로 변환
		LocalDateTime createdtime = LocalDateTime.parse(it.get("createdtime").getAsString(), inputFormatter);
		LocalDateTime modifiedtime = LocalDateTime.parse(it.get("modifiedtime").getAsString(), inputFormatter);

		// 원하는 형식으로 변환
		String formattedCreatedtime = createdtime.format(outputFormatter);
		String formattedModifiedtime = modifiedtime.format(outputFormatter);
		
		//조회수 증가
		tripService.increaseCount(contentId);
		//조회수 가져오기
		int count = tripService.selectCount(contentId);
		
		Trip t = new Trip();
		
		//여행지 공통정보 담기
		t.setContentId(it.get("contentid").getAsString());
		t.setContentTypeId(it.get("contenttypeid").getAsString());
		t.setTitle(it.get("title").getAsString());
		t.setCreatedTime(formattedCreatedtime);
		t.setModifiedTime(formattedModifiedtime);
		t.setHomepage(it.get("homepage").getAsString());
		t.setFirstImage1(it.get("firstimage").getAsString());
		t.setAddr1(it.get("addr1").getAsString());
		t.setAddr2(it.get("addr2").getAsString());
		t.setZipCode(it.get("zipcode").getAsString());
		t.setOverView(it.get("overview").getAsString());
		t.setMapx(it.get("mapx").getAsString());
		t.setMapy(it.get("mapy").getAsString());
		t.setCount(count);

		br.close();
		urlCon.disconnect();
		
		model.addAttribute("t",t);
		
		return "trip/tripDetail";
	}
	
	//여행지 상세정보 가져오기
	@ResponseBody
	@RequestMapping(value="detailInfo.tl", produces="application/json;charset=UTF-8")
	public String detailInfo(String contentId, String contentTypeId) throws IOException {
		String url = "http://apis.data.go.kr/B551011/KorService1/detailIntro1";
		url+="?serviceKey="+SERVICEKEY;
		//&MobileOS=ETC&MobileApp=AppTest&_type=json&contentId=2871985&contentTypeId=12
		url+="&MobileOS=ETC&MobileApp=AppTest&_type=json";
		url+="&contentId="+contentId;
		url+="&contentTypeId="+contentTypeId;
		
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
	
	//댓글 리스트
	@ResponseBody
	@RequestMapping(value="replyList.tl", produces="application/json;charset=UTF-8")
	public ArrayList<Reply> replyList(String contentId) {
		
		ArrayList<Reply> rList = tripService.replyList(contentId);
		
		return rList;
	}
	
	//댓글 작성
	@ResponseBody
	@RequestMapping("insertReply.tl")
	public int insertReply(Reply r) {
		
		int result = tripService.insertReply(r);
		
		return result;
	}
	
}

