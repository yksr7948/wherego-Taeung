package com.go.wherego.weather.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.go.wherego.weather.model.service.WeatherServiceImpl;

@Controller
public class WeatherController {
	
	public static final String SERVICE_KEY="ueKBwAad327Iz5OxQC1LBnYtY33Hu7OOrwZzO2CghIQcpby32mjhGT8EMAsCZmMhl6kqeyADZVIVay3rTDinnw%3D%3D";
	
	@Autowired
	WeatherServiceImpl ws;

	@GetMapping("weather.we")
	public String weather() {
		return "weather/weatherView";
	}
	
	@ResponseBody
	@GetMapping("location.we")
	public String location(String location) {
		String code=ws.selectCode(location);
		if(code!=null) {
//			받은 코드로 url 완성시켜서 openAPI통해 데이터받기
		}
		return code;
	}
}
