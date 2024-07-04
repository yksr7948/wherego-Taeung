package com.go.wherego.plan.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PlanDataController {

	public static final String SERVICEKEY = "Y7q7XmGoF9h%2FphY8nNxCXsROOjlhzAEB3Igq4QKCxopSkOaEM5iW4PTh2HakmtsWSmmuT9Z9nJk1y%2BBti5OydQ%3D%3D";
	
	//검색 리스트 가져오기
	@ResponseBody
	@RequestMapping(value="searchPlace.pl", produces="application/json;charset=UTF-8")
	public String searchPlace(String keyword) throws IOException {
		
		String url = "http://apis.data.go.kr/B551011/KorService1/searchKeyword1";
		url += "?serviceKey="+SERVICEKEY;
		url += "&numOfRows=10&MobileOS=ETC&MobileApp=AppTest&_type=JSON&listYN=Y&arrange=O";
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
}
