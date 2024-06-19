package com.go.wherego.weather.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WeatherController {

	@GetMapping("weather.we")
	public String weather() {
		return "weather/weatherView";
	}
}
