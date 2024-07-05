package com.go.wherego.entertain.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.go.wherego.entertain.model.vo.WC;
import com.go.wherego.trip.model.vo.Trip;


@Repository
public class EntertainDao {

	public ArrayList<Trip> getTop100(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("entertainMapper.getTop100");
	}

	public void insertWCResult(SqlSessionTemplate sqlSession, WC wc) {
		sqlSession.insert("entertainMapper.insertWCResult", wc);
	}

	public ArrayList<WC> getWcRanking(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("entertainMapper.getWcRanking");
	}

	public int getEntireGame(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("entertainMapper.getEntireGame");
	}

	public int getWinTime(SqlSessionTemplate sqlSession, String title) {
		return sqlSession.selectOne("entertainMapper.getWinTime",title);
	}
}
