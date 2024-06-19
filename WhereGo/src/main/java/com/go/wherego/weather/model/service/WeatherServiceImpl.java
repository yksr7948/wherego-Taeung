package com.go.wherego.weather.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.weather.model.dao.WeatherDao;

@Service
public class WeatherServiceImpl implements WeatherService{

	@Autowired
	WeatherDao dao;
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public String selectCode(String location) {
		return dao.selectCode(sqlSession,location);
	}

}
