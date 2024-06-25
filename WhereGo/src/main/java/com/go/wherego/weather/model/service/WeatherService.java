package com.go.wherego.weather.model.service;

import java.util.ArrayList;

import com.go.wherego.weather.model.vo.Weather;

public interface WeatherService {
	String selectTcode(Weather we);
	
	String selectWcode(Weather we);
	
	ArrayList<Weather> getLocation(String location);
}
