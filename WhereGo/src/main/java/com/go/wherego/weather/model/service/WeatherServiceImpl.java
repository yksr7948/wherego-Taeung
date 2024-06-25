package com.go.wherego.weather.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.weather.model.dao.WeatherDao;
import com.go.wherego.weather.model.vo.Weather;

@Service
public class WeatherServiceImpl implements WeatherService{

	@Autowired
	WeatherDao dao;
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public String selectTcode(Weather we) {
		return dao.selectTcode(sqlSession,we);
	}


	@Override
	public String selectWcode(Weather we) {
		return dao.selectWcode(sqlSession, we);
	}


	@Override
	public ArrayList<Weather> getLocation(String location) {
		return dao.getLocation(sqlSession,location);
	}

}
