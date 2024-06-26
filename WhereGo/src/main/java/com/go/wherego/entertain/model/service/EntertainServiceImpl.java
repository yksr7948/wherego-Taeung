package com.go.wherego.entertain.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.entertain.model.dao.EntertainDao;
import com.go.wherego.trip.model.vo.Trip;

@Service
public class EntertainServiceImpl implements EntertainService{
	@Autowired
	private EntertainDao entertaindao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	
	@Override
	public ArrayList<Trip> getTop100() {
		return entertaindao.getTop100(sqlSession);
	}

}
