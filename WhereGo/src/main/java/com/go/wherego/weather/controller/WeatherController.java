package com.go.wherego.weather.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.go.wherego.weather.model.service.WeatherServiceImpl;
import lombok.extern.slf4j.Slf4j;

@Slf4j

@Controller
public class WeatherController {
	
	public static final String SERVICE_KEY="ueKBwAad327Iz5OxQC1LBnYtY33Hu7OOrwZzO2CghIQcpby32mjhGT8EMAsCZmMhl6kqeyADZVIVay3rTDinnw%3D%3D";
	
	private Date tmFc=new Date();
	private SimpleDateFormat dFormat=new SimpleDateFormat("yyyyMMdd");
	private String time;
	
	@Autowired
	WeatherServiceImpl ws;

	@GetMapping("weather.we")
	public String weather() {
		return "weather/weatherView";
	}
	

	
	@ResponseBody
	@GetMapping("location.we")
	public String location(String location) throws IOException {
		String url="";
		String responseStr="";
		HttpURLConnection urlConn=null;
		BufferedReader br=null;
		//URL객체 얻기(java.net.url)
		URL requestUrl;
		getTime();
		
		String code=ws.selectCode(location);
		if(code!=null) {
			url="http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa";
			url += "?serviceKey="+SERVICE_KEY
				+ "&pageNo="+URLEncoder.encode("1", "UTF-8")
				+ "&numOfRows="+URLEncoder.encode("10", "UTF-8")
				+ "&dataType="+URLEncoder.encode("XML", "UTF-8")
				+ "&regId="+code
				+ "&tmFc="+time;
			
			requestUrl = new URL(url);
			urlConn=(HttpURLConnection)requestUrl.openConnection();
			urlConn.setRequestMethod("GET");
			urlConn.setRequestProperty("Content-type", "application/json");
			
			br=new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			
			
			String line="";
			while((line=br.readLine())!=null) {
				//System.out.println(line);
				responseStr+=line;
			}
			
		}
		return responseStr;
	}
	
	//예보시간 구하는 메소드
	private void getTime() {
		Calendar cal=Calendar.getInstance();
		if(cal.HOUR<6) {
			cal.add(cal.DATE, -1);
		}
		time=dFormat.format(cal.getTime())+"0600";
	}

}
