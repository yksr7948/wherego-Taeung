package com.go.wherego.trip.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.trip.model.dao.TripDao;
import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Trip;


@Service
public class TripServiceImpl implements TripService{

	@Autowired
	private TripDao tripDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//데이터 저장
	@Override
	public int saveArea(ArrayList<Trip> list) {
		
		int result = tripDao.saveArea(list, sqlSession);
		
		return result;
	}
	
	//여행지 총 개수
	@Override
	public int listCount() {
		
		int listCount = tripDao.listCount(sqlSession);
		
		return listCount;
	}
	
	//지역별 여행지 총 개수
	@Override
	public int areaListCount(String areaCode) {
			
		int listCount = tripDao.areaListCount(sqlSession, areaCode);
			
		return listCount;
	}
	
	//여행지 목록 조회
	@Override
	public ArrayList<Trip> selectList(PageInfo pi){
		
		ArrayList<Trip> tList = tripDao.selectList(sqlSession, pi);
		
		return tList;
	}
	
	//지역별 여행지 목록 조회
	@Override
	public ArrayList<Trip> selectAreaList(PageInfo pi, String areaCode){
			
		ArrayList<Trip> aList = tripDao.selectAreaList(sqlSession, pi, areaCode);
			
		return aList;
	}
	
	//조회수 증가
	@Override
	public int increaseCount(String contentId) {
		
		int result = tripDao.increaseCount(sqlSession, contentId);
		
		return result;
	}
	
	//조회수 가져오기
	public int selectCount(String contentId) {
		
		int count = tripDao.selectCount(sqlSession, contentId);
		
		return count;
	}
}
