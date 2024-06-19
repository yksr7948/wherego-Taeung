package com.go.wherego.weather.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class WeatherDao {
	

	public String selectCode(SqlSessionTemplate sqlSession,String location) {
		return sqlSession.selectOne("weatherMapper.selectCode", location);
	}
	
}
