package com.go.wherego.entertain.model.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.entertain.model.dao.EntertainDao;
import com.go.wherego.entertain.model.vo.WC;
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



	@Override
	public void insertWCResult(WC wc) {
		entertaindao.insertWCResult(sqlSession,wc);
	}



	@Override
	public ArrayList<WC> getWcRanking() {
		return entertaindao.getWcRanking(sqlSession);
	}



	@Override
	public int getEntireGame() {
		return entertaindao.getEntireGame(sqlSession);
	}



	@Override
	public int getWinTime(String title) {
		return entertaindao.getWinTime(sqlSession,title);
	}



	@Override
	public ArrayList<HashMap<String, BigDecimal>> getWcMbti(String title) {
		return entertaindao.getWcMbti(sqlSession, title);
	}



	@Override
	public int getMbtiCount(String title) {
		return entertaindao.getMbtiCount(sqlSession,title);
	}



	@Override
	public ArrayList<HashMap<String, BigDecimal>> getWcAge(String title) {
		return entertaindao.getWcAge(sqlSession,title);
	}



	@Override
	public ArrayList<HashMap<String, BigDecimal>> getWcGender(String title) {
		return entertaindao.getWcGender(sqlSession,title);
	}



	/*
	 * @Override public HashMap<String, Integer> getMbti(String title) { return
	 * entertaindao.getMbti(sqlSession,title); }
	 */



	

}
