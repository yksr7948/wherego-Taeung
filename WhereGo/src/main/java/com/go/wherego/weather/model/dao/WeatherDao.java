package com.go.wherego.weather.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.go.wherego.weather.model.vo.Weather;

@Repository
public class WeatherDao {
	
	//기온코드 조회
	public String selectTcode(SqlSessionTemplate sqlSession,String location) {
		return sqlSession.selectOne("weatherMapper.selectTcode", location);
	}

	//날씨코드 조회
	public String selectWcode(SqlSessionTemplate sqlSession, String location) {
		return sqlSession.selectOne("weatherMapper.selectWcode", location);
	}

	public ArrayList<Weather> getLocation(SqlSessionTemplate sqlSession, String location) {
		ArrayList<Weather> wList=(ArrayList)sqlSession.selectList("weatherMapper.selectLocations", location);
		return wList;
	}
	
}
