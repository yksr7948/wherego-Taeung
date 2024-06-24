package com.go.wherego.weather.model.service;

import java.util.ArrayList;

import com.go.wherego.weather.model.vo.Weather;

public interface WeatherService {
	String selectTcode(String location);
	
	String selectWcode(String location);
	
	ArrayList<Weather> getLocation(String location);
}
