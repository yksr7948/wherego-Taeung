package com.go.wherego.weather.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
}
