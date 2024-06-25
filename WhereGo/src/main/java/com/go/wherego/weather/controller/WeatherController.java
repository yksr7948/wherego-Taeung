package com.go.wherego.weather.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.go.wherego.weather.model.service.WeatherServiceImpl;
import com.go.wherego.weather.model.vo.Weather;

import lombok.extern.slf4j.Slf4j;



@Controller
public class WeatherController {
	
	public static final String SERVICE_KEY="ueKBwAad327Iz5OxQC1LBnYtY33Hu7OOrwZzO2CghIQcpby32mjhGT8EMAsCZmMhl6kqeyADZVIVay3rTDinnw%3D%3D";
	

	private Calendar cal=Calendar.getInstance();
	private String time;
	
	@Autowired
	WeatherServiceImpl ws;

	@GetMapping("weather.we")
	public ModelAndView weather(ModelAndView mv,
						@RequestParam(defaultValue = "서울")String location) {
		mv.addObject("area", location);
		mv.setViewName("weather/weatherView");
		return mv;
	}
	
	@ResponseBody
	@GetMapping("date.we")
	public ArrayList<String> getDate() {
		SimpleDateFormat dFormat=new SimpleDateFormat("MM/dd");
		ArrayList<String> dList=new ArrayList<>();
		cal.add(cal.DATE, 3);
		for(int i=0;i<5;i++) {
			String date=dFormat.format(cal.getTime());
			dList.add(date);
			cal.add(cal.DATE, 1);
		}
		cal.add(cal.DATE, -8);
		return dList;
	}
	
	@ResponseBody
	@GetMapping("location.we")
	public ArrayList<Weather> getLocation(String location) {
		ArrayList<Weather> locations=new ArrayList<>();
		locations=ws.getLocation(location);
		return locations;
	}
	
	@ResponseBody
	@GetMapping("temperature.we")
	public String temperature(String location,String sido) throws IOException {
		String url="";
		String responseStr="";
		HttpURLConnection urlConn=null;
		BufferedReader br=null;
		//URL객체 얻기(java.net.url)
		URL requestUrl;
		getTime();
		
		Weather we= new Weather().builder().locationName(location)
											.area(sido).build();
		String code=ws.selectTcode(we);
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
	
	
	@ResponseBody
	@PostMapping(value="weather.we",produces = "text/plain;charset=UTF-8")
	public String weather(String location,String sido) throws IOException {
		String url="";
		String responseStr="";
		HttpURLConnection urlConn=null;
		BufferedReader br=null;
		//URL객체 얻기(java.net.url)
		URL requestUrl;
		getTime();
		
		Weather we= new Weather().builder().locationName(location)
				.area(sido).build();
		String code=ws.selectWcode(we);
		if(code!=null) {
			url="http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst"
				+"?serviceKey="+SERVICE_KEY
				+ "&pageNo="+URLEncoder.encode("1", "UTF-8")
				+ "&numOfRows="+URLEncoder.encode("10", "UTF-8")
				+ "&dataType="+URLEncoder.encode("XML", "UTF-8")
				+ "&regId="+code
				+ "&tmFc="+time;;
				
				requestUrl = new URL(url);
				urlConn=(HttpURLConnection)requestUrl.openConnection();
				urlConn.setRequestMethod("GET");
				urlConn.setRequestProperty("Content-type", "application/json");
				
				br=new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
				
				
				String line="";
				while((line=br.readLine())!=null) {
					responseStr+=line;
				}
		}	
		return responseStr;
	}
	
	//t.addr1을 가져와서 위치정보 가져온후에 날씨페이지 이동
	@GetMapping("checkWeather.we")
	public ModelAndView checkWeather(ModelAndView mv,String location) {
		String area=location.substring(0, 2);
		if(area.equals("경기")) {
			area=location.replaceAll(" ", "").substring(3, 5);
		} else if(area.equals("강원")) {
			area=location.replaceAll(" ", "").substring(7, 9);
		}
		return weather(mv,area);
	}
	
	
	//예보시간 구하는 메소드(06시마다 갱신되기때문에 6시 기준으로 날짜변경)
	private void getTime() {
		if(cal.HOUR<6) {
			cal.add(cal.DATE, -1);
		}
		SimpleDateFormat dFormat=new SimpleDateFormat("yyyyMMdd");
		time=dFormat.format(cal.getTime())+"0600";
	}

}
